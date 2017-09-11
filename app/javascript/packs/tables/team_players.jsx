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

class TeamPlayers extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        const docWidth = document.getElementById("players").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <div>
                <div className="font-weight-bold mb-2 text-uppercase">Skaters</div>
                <ReactTable
                    data={skaterData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            minWidth: actualWidth >= 992 ? docWidth / (100 / 14) : 150,
                        },
                        {
                            Header: "Team",
                            id: "team",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GP",
                            accessor: "games_played",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "G",
                            accessor: "goals",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "A",
                            accessor: "assists",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P",
                            accessor: "points",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "+/-",
                            id: "plus-minus",
                            accessor: d => d["plus-minus"] > 0 ? "+" + d["plus-minus"] : d["plus-minus"],
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PIM",
                            accessor: "pim",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "Hits",
                            accessor: "hits",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P/GP",
                            id: "p/gp",
                            accessor: d => d["p/gp"].toFixed(2),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PPG",
                            accessor: "ppg",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PPP",
                            accessor: "ppp",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHG",
                            accessor: "shg",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHP",
                            accessor: "shp",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "S",
                            accessor: "shots",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SH%",
                            id: "sh%",
                            accessor: d => d["sh%"].toFixed(1),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW",
                            accessor: "fow",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOT",
                            accessor: "fot",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FO%",
                            id: "fo%",
                            accessor: d => d["fo%"].toFixed(1),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 18)) : 50,
                            style: {"textAlign": "center"}
                        },
                    ]}
                    className="-striped -highlight"
                    resizable={false}
                    showPagination={false}
                    pageSize={skaterData(data).length > 0 ? skaterData(data).length : 1}
                    defaultSorted={[
                        {
                            id: "points",
                            desc: true
                        }
                    ]}
                />
                <div className="font-weight-bold mb-2 mt-2 text-uppercase">Goalies</div>
                <ReactTable
                    data={goalieData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            minWidth: actualWidth >= 992 ? docWidth / (100 / 14) : 150
                        },
                        {
                            Header: "Team",
                            id: "team",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GP",
                            accessor: "goalie_games",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "W",
                            accessor: "wins",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "L",
                            accessor: "losses",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "OTL",
                            accessor: "otl",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GA",
                            accessor: "goals_against",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SA",
                            accessor: "shots_against",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SV%",
                            id: "sv%",
                            accessor: d => d["sv%"].toFixed(3),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GAA",
                            id: "gaa",
                            accessor: d => d["gaa"].toFixed(2),
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SO",
                            accessor: "shutouts",
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (86 / 10)) : 50,
                            style: {"textAlign": "center"}
                        },
                    ]}
                    className="-striped -highlight"
                    resizable={false}
                    showPagination={false}
                    pageSize={goalieData(data).length > 0 ? goalieData(data).length : 1}
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

render(<TeamPlayers />, document.getElementById("players"))
