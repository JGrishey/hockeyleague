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
        return (
            <div>
                <ReactTable
                    data={data}
                    columns={[
                        {
                            Header: "Name",
                            id: "name",
                            accessor: d => (<div><a href={"/leagues/" + d.league_id + "/seasons/" + d.season_id + "/teams/" + d.team_id}>{d.name}</a></div>),
                            width: 200
                        },
                        {
                            Header: "GP",
                            accessor: "gp",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "W",
                            accessor: "wins",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "L",
                            accessor: "losses",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "OTL",
                            accessor: "otl",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P",
                            accessor: "pts",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P%",
                            id: "pts%",
                            accessor: d => d["pts%"].toFixed(3),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GF",
                            accessor: "gf",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GA",
                            accessor: "ga",
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GF/GP",
                            id: "gfpg",
                            accessor: d => d.gfpg.toFixed(2),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "GA/GP",
                            id: "gapg",
                            accessor: d => d.gapg.toFixed(2),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PP%",
                            id: "pp%",
                            accessor: d => d["pp%"].toFixed(1),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "PK%",
                            id: "pk%",
                            accessor: d => d["pk%"].toFixed(1),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SHOTS/GP",
                            id: "shfpg",
                            accessor: d => d.shfpg.toFixed(1),
                            width: 79,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "SA/GP",
                            id: "shapg",
                            accessor: d => d.shapg.toFixed(1),
                            width: 63,
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "FOW%",
                            id: "fow%",
                            accessor: d => d["fow%"].toFixed(1),
                            width: 73,
                            style: {"textAlign": "center"}
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
