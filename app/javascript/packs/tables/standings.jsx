import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    console.log(document.getElementById("standings").getAttribute("data-data"))
    return JSON.parse(document.getElementById("standings").getAttribute("data-data"))
}

class Standings extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        const docWidth = document.getElementById("standings").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <div>
                <ReactTable
                    data={data}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.name}</a></div>),
                            minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150,
                            headerStyle: {whiteSpace: "normal"}
                        },
                        {
                            Header: "GP",
                            accessor: "gp",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "W",
                            accessor: "wins",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "L",
                            accessor: "losses",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "OTL",
                            accessor: "otl",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "P",
                            accessor: "pts",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "P%",
                            id: "pts%",
                            accessor: d => d["pts%"].toFixed(3),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "GF",
                            accessor: "gf",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "GA",
                            accessor: "ga",
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "GF/GP",
                            id: "gfpg",
                            accessor: d => d.gfpg.toFixed(2),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "GA/GP",
                            id: "gapg",
                            accessor: d => d.gapg.toFixed(2),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "PP%",
                            id: "pp%",
                            accessor: d => d["pp%"].toFixed(1),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "PK%",
                            id: "pk%",
                            accessor: d => d["pk%"].toFixed(1),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "SHOTS/GP",
                            id: "shfpg",
                            accessor: d => d.shfpg.toFixed(1),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "SA/GP",
                            id: "shapg",
                            accessor: d => d.shapg.toFixed(1),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                        {
                            Header: "FOW%",
                            id: "fow%",
                            accessor: d => d["fow%"].toFixed(1),
                            style: {"textAlign": "center"},
                            headerStyle: {whiteSpace: "normal"},
                            maxWidth: actualWidth >= 992 ? docWidth / (100 / (85 / 15)) : 50
                        },
                    ]}
                    className="-striped -highlight"
                    showPagination={false}
                    pageSize={data.length}
                    resizable={false}
                    defaultSorted={[
                        {
                            id: "pts",
                            desc: true
                        }
                    ]}
                />
            </div>
        )
    }
}

render(<Standings />, document.getElementById("standings"))
