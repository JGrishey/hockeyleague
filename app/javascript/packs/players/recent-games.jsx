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
        return (
            <div>
            { skaterData(data).length > 0 &&
                <div>
                    <div className="sub-header">Skater</div>
                    <ReactTable
                        data={skaterData(data)}
                        columns={[
                            {
                                Header: "League",
                                accessor: "league",
                                width: 60,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                width: 75,
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
                                width: 130,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "POS",
                                accessor: "position",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Hits",
                                accessor: "hits",
                                width: 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "S",
                                accessor: "shots",
                                width: 50,
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
                    <div className="sub-header">Goalie</div>
                    <ReactTable
                        data={goalieData(data)}
                        columns={[
                            {
                                Header: "League",
                                accessor: "league",
                                width: 60,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                width: 75,
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
                                width: 130,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "POS",
                                accessor: "position",
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
                                Header: "GA",
                                accessor: "goals_against",
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
