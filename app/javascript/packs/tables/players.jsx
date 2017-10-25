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
        const docWidth = document.getElementById("players").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <div>
                <div className="text-center font-weight-bold text-uppercase mb-2 mt-2">Skaters</div>
                <ReactTable
                    data={skaterData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            width: 210,
                        },
                        {
                            Header: "GP",
                            accessor: "games_played",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "G",
                            accessor: "goals",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "A",
                            accessor: "assists",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P",
                            accessor: "points",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "+/-",
                            id: "plus_minus",
                            accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PIM",
                            accessor: "pim",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "HITS",
                            accessor: "hits",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P/GP",
                            id: "p/gp",
                            accessor: d => d["games_played"] == 0 ? (d["points"] / d["games_played"]).toFixed(2) : (0).toFixed(2),
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PPG",
                            accessor: "ppg",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHG",
                            accessor: "shg",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "S",
                            accessor: "shots",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SH%",
                            id: "sh_per",
                            accessor: d => d["sh_per"] != null ? (d["sh_per"] * 105).toFixed(1) : (0).toFixed(1),
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW",
                            accessor: "fow",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOT",
                            accessor: "fot",
                            maxWidth: 56,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW%",
                            id: "fo_per",
                            accessor: d => d["fo_per"] != null ? (d["fo_per"] * 105).toFixed(1) : (0).toFixed(1),
                            maxWidth: 56,
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
                <div className="text-center font-weight-bold text-uppercase mb-2 mt-2">Goalies</div>
                <ReactTable
                    data={goalieData(data)}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                            width: 210,
                        },
                        {
                            Header: "GP",
                            accessor: "goalie_games",
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "G",
                            accessor: "g_goals",
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "A",
                            accessor: "g_assists",
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GA",
                            accessor: "ga",
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SA",
                            accessor: "sa",
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SV%",
                            id: "sv_per",
                            accessor: d => d["sv_per"].toFixed(3),
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GAA",
                            id: "gaa",
                            accessor: d => d["gaa"].toFixed(2),
                            width: 105,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SO",
                            accessor: "so",
                            width: 105,
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
