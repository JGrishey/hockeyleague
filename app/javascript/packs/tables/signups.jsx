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
        return (
            <ReactTable
                data={data}
                columns={[
                    {
                        Header: "Name",
                        id: "name",
                        accessor: d => (<div><a href={"/" + d.name}>{d.name}</a></div>),
                    },
                    {
                        Header: "POS",
                        accessor: "preferred",
                        style: {"textAlign": "center"}
                    },
                    {
                        Header: "Willing",
                        id: "willing",
                        accessor: d => (d["willing"].join(", ")),
                        style: {"textAlign": "center"}
                    },
                    {
                        Header: "MIA",
                        accessor: "mia",
                        style: {"textAlign": "center"}
                    },
                    {
                        Header: "Veteran",
                        id: "veteran",
                        accessor: d => d.veteran ? "Yes" : "No",
                        style: {"textAlign": "center"}
                    },
                    {
                        Header: "Part-time",
                        id: "part_time",
                        accessor: d => d.part_time ? "Yes" : "No",
                        style: {"textAlign": "center"}
                    },
                ]}
                className="-striped -highlight"
                resizable={false}
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
