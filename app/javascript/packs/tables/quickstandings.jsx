import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'
import "react-table/react-table.css"

const getData = () => {
    console.log(document.getElementById("standings").getAttribute("data-data"))
    return JSON.parse(document.getElementById("standings").getAttribute("data-data"))
}

class QuickStandings extends React.Component {
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
                            minWidth: 200
                        },
                        {
                            Header: "W",
                            accessor: "wins",
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "L",
                            accessor: "losses",
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "OTL",
                            accessor: "otl",
                            style: {"textAlign": "center"}
                        },
                        {
                            Header: "P",
                            accessor: "pts",
                            style: {"textAlign": "center"}
                        }
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

render(<QuickStandings />, document.getElementById("standings"))
