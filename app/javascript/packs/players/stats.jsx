import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    let leagues = document.getElementsByClassName("league-data")

    let data = {}
    
    for (let i = 0; i < leagues.length; i++) {
        data[leagues[i].getAttribute("id")] = JSON.parse(leagues[i].getAttribute("data-data"))
    }

    return data
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

class Stats extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData(),
            mode: "MHL"
        }
    }

    selectMode (mode) {
        this.setState({ mode });
    }

    renderLeague (league) {
        const leagueData = this.state.data[league]
        const docWidth = document.getElementById("stats").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth

        return (
            <div>
                { skaterData(leagueData).length > 0 &&
                    <div>
                    <div className="font-weight-bold mb-2 text-uppercase">Skater</div>
                    <ReactTable
                        data={skaterData(leagueData)}
                        columns={[
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Team",
                                id: "team",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GP",
                                accessor: "games_played",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus-minus",
                                accessor: d => d["plus-minus"] > 0 ? "+" + d["plus-minus"] : d["plus-minus"],
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Hits",
                                accessor: "hits",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P/GP",
                                id: "p/gp",
                                accessor: d => d["p/gp"].toFixed(2),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PPG",
                                accessor: "ppg",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PPP",
                                accessor: "ppp",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SHG",
                                accessor: "shg",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SHP",
                                accessor: "shp",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "S",
                                accessor: "shots",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SH%",
                                id: "sh%",
                                accessor: d => d["sh%"].toFixed(1),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW",
                                accessor: "fow",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOT",
                                accessor: "fot",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FO%",
                                id: "fo%",
                                accessor: d => d["fo%"].toFixed(1),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 19) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                        ]}
                        className="-striped -highlight"
                        resizable={false}
                        showPagination={false}
                        pageSize={skaterData(leagueData).length}
                        defaultSorted={[
                            {
                                id: "points",
                                desc: true
                            }
                        ]}
                    />
                    </div>
                }
                { goalieData(leagueData).length > 0 &&
                    <div>
                    <div className="font-weight-bold mb-2 mt-2 text-uppercase">Goalie</div>
                    <ReactTable
                        data={goalieData(leagueData)}
                        columns={[
                            {
                                Header: "Season",
                                id: "season",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id}>{d.season}</a></div>),
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Team",
                                id: "team",
                                accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.team}</a></div>),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GP",
                                accessor: "goalie_games",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "W",
                                accessor: "wins",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "L",
                                accessor: "losses",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "OTL",
                                accessor: "otl",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "goals_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "shots_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv%",
                                accessor: d => d["sv%"].toFixed(3),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GAA",
                                id: "gaa",
                                accessor: d => d["gaa"].toFixed(2),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SO",
                                accessor: "shutouts",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10) + 1) : 50,
                                style: {"textAlign": "center"}
                            },
                        ]}
                        className="-striped -highlight"
                        resizable={false}
                        showPagination={false}
                        pageSize={goalieData(leagueData).length}
                        defaultSorted={[
                            {
                                id: "season",
                                desc: true
                            }
                        ]}
                    />
                    </div>
                }
            </div>
        )
    }

    render () {
        const { data, mode } = this.state

        let content = this.renderLeague(mode)

        return (
            <div>
                <div className="btn-group mb-2">
                    {Object.keys(data).map((key, index) => {
                        return (<button 
                                    onClick={this.selectMode.bind(this, key)} 
                                    ref={key} key={index} 
                                    style={{cursor: "pointer"}}
                                    className={key === mode ? "btn btn-outline-info" : "btn btn-outline-secondary"}>{key}
                                </button>)
                    })}
                </div>
                {content}
            </div>
        )
    }
}

render(<Stats />, document.getElementById("stats"))
