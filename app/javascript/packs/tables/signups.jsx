import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    return JSON.parse(document.getElementById("signups").getAttribute("data-data"))
}

class Signups extends React.Component {
    constructor () {
        super()
        this.state = {
            data: getData()
        }
    }
    render () {
        const { data } = this.state
        const docWidth = document.getElementById("signups").offsetWidth - (1.25 * 16 * 2)
        const actualWidth = document.body.clientWidth
        return (
            <ReactTable
                data={data}
                columns={[
                    {
                        Header: "Name",
                        id: "name",
                        accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                        minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150
                    },
                    {
                        Header: "POS",
                        accessor: "preferred",
                        style: {"textAlign": "center"},
                        maxWidth: actualWidth >= 992 ? docWidth / (100 / (70 / 4)) : 100
                    },
                    {
                        Header: "Willing",
                        id: "willing",
                        accessor: d => (d["willing"].join(", ")),
                        style: {"textAlign": "center"},
                        minWidth: actualWidth >= 992 ? docWidth / (100 / 15) : 150
                    },
                    {
                        Header: "MIA",
                        accessor: "mia",
                        style: {"textAlign": "center"},
                        maxWidth: actualWidth >= 992 ? docWidth / (100 / (70 / 4)) : 100
                    },
                    {
                        Header: "Veteran",
                        id: "veteran",
                        accessor: d => d.veteran ? "Yes" : "No",
                        style: {"textAlign": "center"},
                        maxWidth: actualWidth >= 992 ? docWidth / (100 / (70 / 4)) : 100
                    },
                    {
                        Header: "Part-time",
                        id: "part_time",
                        accessor: d => d.part_time ? "Yes" : "No",
                        style: {"textAlign": "center"},
                        maxWidth: actualWidth >= 992 ? docWidth / (100 / (70 / 4)) : 100
                    },
                ]}
                className="-striped -highlight"
                resizable={true}
                defaultSorted={[
                    {
                        id: "name",
                        desc: true
                    }
                ]}
            />
        )
    }
}

render(<Signups />, document.getElementById("signups"))
