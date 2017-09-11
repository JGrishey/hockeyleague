import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    return JSON.parse(document.getElementById("away").getAttribute("data-data"))
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

class AwayBox extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        const docWidth = document.getElementById("away").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <div>
                { skaterData(data).length > 0 &&
                    <div>
                    <ReactTable
                        data={skaterData(data)}
                        columns={[
                            {
                                Header: "Player",
                                accessor: "name",
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150,
                                style: { "textAlign": "center"}
                            },
                            {
                                Header: "POS",
                                accessor: "position",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SOG",
                                accessor: "shots",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW",
                                accessor: "fow",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOT",
                                accessor: "fot",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 10)) : 50,
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
                    <div className="mt-2">
                    <ReactTable
                        data={goalieData(data)}
                        columns={[
                            {
                                Header: "Player",
                                accessor: "name",
                                minWidth: actualWidth >= 992 ? docWidth / (100 / 20) : 400,
                                style: { "textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "goals_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (80 / 4)) : 200,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "shots_against",
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (80 / 4)) : 200,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv%",
                                accessor: d => d["sv%"].toFixed(3),
                                maxWidth: actualWidth >= 992 ? docWidth / (100 / (80 / 4)) : 200,
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

render(<AwayBox />, document.getElementById("away"))
