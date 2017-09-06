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
        return (
            <div>
                { skaterData(data).length > 0 &&
                    <div>
                    <ReactTable
                        data={skaterData(data)}
                        columns={[
                            {
                                Header: "POS",
                                accessor: "position",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Player",
                                accessor: "name",
                                minWidth: 124,
                                style: { "textAlign": "center"}
                            },
                            {
                                Header: "G",
                                accessor: "goals",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "A",
                                accessor: "assists",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "P",
                                accessor: "points",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "+/-",
                                id: "plus_minus",
                                accessor: d => d["plus_minus"] > 0 ? "+" + d["plus_minus"] : d["plus_minus"],
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "PIM",
                                accessor: "pim",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SOG",
                                accessor: "shots",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOW",
                                accessor: "fow",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "FOT",
                                accessor: "fot",
                                minWidth: 70,
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
                    <ReactTable
                        data={goalieData(data)}
                        columns={[
                            {
                                Header: "POS",
                                accessor: "position",
                                minWidth: 70,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "Player",
                                accessor: "name",
                                minWidth: 124,
                                style: { "textAlign": "center"}
                            },
                            {
                                Header: "GA",
                                accessor: "goals_against",
                                minWidth: 185,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SA",
                                accessor: "shots_against",
                                minWidth: 185,
                                style: {"textAlign": "center"}
                            },
                            {
                                Header: "SV%",
                                id: "sv%",
                                accessor: d => d["sv%"].toFixed(3),
                                minWidth: 185,
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
