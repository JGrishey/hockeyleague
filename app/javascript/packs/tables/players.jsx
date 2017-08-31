import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    return JSON.parse(document.getElementById("players").getAttribute("data-data"))
}

const skaterData = (data) => {
    return data.filter((x) => {
        return x.games_played > 0
    })
}

const goalieData = (data) => {
    return data.filter((x) => {
        return x.goalie_games > 0
    })
}

class Players extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        return (
            <div>
                <div className="sub-header">Skaters</div>
                <ReactTable
                    data={skaterData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            width: 150
                        },
                        {
                            Header: "Team",
                            id: "team",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GP",
                            accessor: "games_played",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "G",
                            accessor: "goals",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "A",
                            accessor: "assists",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P",
                            accessor: "points",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "+/-",
                            id: "plus-minus",
                            accessor: d => d["plus-minus"] > 0 ? "+" + d["plus-minus"] : d["plus-minus"],
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PIM",
                            accessor: "pim",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "Hits",
                            accessor: "hits",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P/GP",
                            id: "p/gp",
                            accessor: d => d["p/gp"].toFixed(2),
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PPG",
                            accessor: "ppg",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PPP",
                            accessor: "ppp",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHG",
                            accessor: "shg",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHP",
                            accessor: "shp",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "S",
                            accessor: "shots",
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SH%",
                            id: "sh%",
                            accessor: d => d["sh%"].toFixed(1),
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW",
                            accessor: "fow",
                            width: 62,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOT",
                            accessor: "fot",
                            width: 62,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW%",
                            id: "fo%",
                            accessor: d => d["fo%"].toFixed(1),
                            width: 56,
                            style: {"textAlign": "center"}
                        },
                    ]}
                    className="-striped -highlight"
                    resizable={false}
                    defaultSorted={[
                        {
                            id: "points",
                            desc: true
                        }
                    ]}
                />
                <div className="sub-header">Goalies</div>
                <ReactTable
                    data={goalieData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            width: 150
                        },
                        {
                            Header: "Team",
                            id: "team",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GP",
                            accessor: "goalie_games",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "W",
                            accessor: "wins",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "L",
                            accessor: "losses",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "OTL",
                            accessor: "otl",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GA",
                            accessor: "goals_against",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SA",
                            accessor: "shots_against",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SV%",
                            id: "sv%",
                            accessor: d => d["sv%"].toFixed(3),
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GAA",
                            id: "gaa",
                            accessor: d => d["gaa"].toFixed(2),
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SO",
                            accessor: "shutouts",
                            width: 100,
                            style: {"textAlign": "center"}
                        },
                    ]}
                    className="-striped -highlight"
                    resizable={false}
                    defaultSorted={[
                        {
                            id: "points",
                            desc: true
                        }
                    ]}
                />
            </div>
        )
    }
}

render(<Players />, document.getElementById("players"))
