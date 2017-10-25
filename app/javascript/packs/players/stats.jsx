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
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Hits",
                                accessor: "hits",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P/GP",
                                id: "p_per",
                                accessor: d => d["p_per"].toFixed(2),
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PPG",
                                accessor: "ppg",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SHG",
                                accessor: "shg",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "S",
                                accessor: "shots",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SH%",
                                id: "sh_per",
                                accessor: d => ((d["sh_per"] || 0) * 100).toFixed(1),
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW",
                                accessor: "fow",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOT",
                                accessor: "fot",
                                width: 53,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FO%",
                                id: "fo_per",
                                accessor: d => ((d["fo_per"]  || 0) * 100).toFixed(1),
                                width: 53,
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
                                width: 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "ga",
                                width: 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "sa",
                                width: 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv%",
                                accessor: d => (d["sv%"] || 0).toFixed(3),
                                width: 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "GAA",
                                id: "gaa",
                                accessor: d => (d["gaa"] || 0).toFixed(2),
                                width: 75,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SO",
                                accessor: "so",
                                width: 75,
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
