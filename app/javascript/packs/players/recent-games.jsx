import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    return JSON.parse(document.getElementById("recent-games").getAttribute("data-data"))
}

const goalieData = (data) => {
    return data.filter((x) => {
        return x.position === "G"
    })
}

const skaterData = (data) => {
    return data.filter((x) => {
        return x.position != "G"
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
        const docWidth = document.getElementById("recent").offsetWidth - (1.25 * 16 * 2)
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
                                Header: "League",
                                accessor: "league",
                                width: actualWidth >= 992 ? docWidth / (100 / 10) : 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                width: actualWidth >= 992 ? docWidth / (100 / 10) : 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Score",
                                id: "score",
                                accessor: d => (
                                    <div>
                                        <a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/games/" + d.game_id}>{d.away + " "}
                                            {d.away_goals + " " } @ {" " + d.home_goals + " "} {d.home}
                                        </a>
                                    </div>
                                    ),
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 20) : 125,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "POS",
                                accessor: "position",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Hits",
                                accessor: "hits",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "S",
                                accessor: "shots",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 8)) : 50,
                                style: {"textAlign": "center"}
                            }
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
                </div>
            }
            { goalieData(data).length > 0 &&
                <div>
                    <div className="font-weight-bold mb-2 mt-2 text-uppercase">Goalie</div>
                    <ReactTable
                        data={goalieData(data)}
                        columns={[
                            {
                                Header: "League",
                                accessor: "league",
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 10) : 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 10) : 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Score",
                                id: "score",
                                accessor: d => (
                                    <div>
                                        <a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/games/" + d.game_id}>{d.away + " "}
                                            {d.away_goals + " " } @ {" " + d.home_goals + " "} {d.home}
                                        </a>
                                    </div>
                                    ),
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 20) : 125,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "shots_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 3)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "goals_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 3)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv%",
                                accessor: d => d["sv%"].toFixed(3),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (60 / 3)) : 50,
                                style: {"textAlign": "center"}
                            },
                        ]}
                        className="-striped -highlight"
                        resizable={false}
                        showPagination={false}
                        pageSize={goalieData(data).length}
                        defaultSorted={[
                            {
                                id: "points",
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

render(<Current />, document.getElementById("recent"))
