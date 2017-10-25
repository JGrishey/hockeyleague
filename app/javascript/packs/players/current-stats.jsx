import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    return JSON.parse(document.getElementById("current-data").getAttribute("data-data"))
}

const goalieData = (data) => {
    return data.filter((x) => {
        return x.goalie_games > 0
    })
}

const skaterData = (data) => {
    return data.filter((x) => {
        return x.games_played > 0
    })
}

class Current extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        const docWidth = document.getElementById("current-stats").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <div>
                { skaterData(data).length > 0 &&
                    <div>
                    <div className="font-weight-bold mb-2 text-uppercase">Skater</div>
                    <ReactTable
                        data={skaterData(data)}
                        columns={[
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                width: 100,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Team",
                                id: "team",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                                width: 150,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GP",
                                accessor: "games_played",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "HITS",
                                accessor: "hits",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P/GP",
                                id: "p/gp",
                                accessor: d => d["games_played"] == 0 ? (d["points"] / d["games_played"]).toFixed(2) : (0).toFixed(2),
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PPG",
                                accessor: "ppg",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SHG",
                                accessor: "shg",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "S",
                                accessor: "shots",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SH%",
                                id: "sh_per",
                                accessor: d => d["sh_per"] != null ? (d["sh_per"] * 102).toFixed(1) : (0).toFixed(1),
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW",
                                accessor: "fow",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOT",
                                accessor: "fot",
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW%",
                                id: "fo_per",
                                accessor: d => d["fo_per"] != null ? (d["fo_per"] * 102).toFixed(1) : (0).toFixed(1),
                                maxWidth: 53,
                                style: {"textAlign": "center"}
                            },
                        ]}
                        className="-striped -highlight"
                        resizable={false}
                        showPagination={false}
                        pageSize={skaterData(data).length}
                        defaultSorted={[
                            {
                                id: "points",
                                desc: true
                            }
                        ]}
                    />
                    </div>
                }
                { goalieData(data).length > 0 &&
                    <div>
                    <div className="font-weight-bold mb-2 mt-2 text-uppercase">Goalie</div>
                    <ReactTable
                        data={goalieData(data)}
                        columns={[
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                width: 100,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Team",
                                id: "team",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                                width: 150,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GP",
                                accessor: "goalie_games",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "g_goals",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "g_assists",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "ga",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "sa",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv_per",
                                accessor: d => d["sv_per"].toFixed(3),
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GAA",
                                id: "gaa",
                                accessor: d => d["gaa"].toFixed(2),
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SO",
                                accessor: "so",
                                width: 102,
                                style: {"textAlign": "center"}
                            },
                        ]}
                        className="-striped -highlight"
                        resizable={false}
                        showPagination={false}
                        pageSize={goalieData(data).length}
                        defaultSorted={[
                            {
                                id: "league",
                                desc: true
                            }
                        ]}
                    />
                    </div>
                }
            </div>
        )
    }
}

render(<Current />, document.getElementById("current-stats"))
