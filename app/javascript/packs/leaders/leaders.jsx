import React from 'react'
import { render } from 'react-dom'
import Panel from './panel'

import ReactTable from 'react-table'

const getData = (attrib) => {
    const data = document.getElementById(attrib + "-leaders").getAttribute("data-data")

    return data
}

class Leaders extends React.Component {
    constructor () {
        super()
        this.state = {
            goals: getData("goal"),
            assists: getData("assist"),
            points: getData("point"),
            plus_minus: getData("plusminus"),
            gaa: getData("gaa"),
            wins: getData("win"),
            sv: getData("sv"),
            so: getData("so")
        }
    }

    render () {
        const { goals, assists, points, plus_minus, gaa, wins, sv, so } = this.state

        return (
            <div>
                <div className="category">
                    <div className="header">Skaters</div>
                    <Panel statName="goals" players={goals}/>
                    <Panel statName="assists" players={assists}/>
                    <Panel statName="points" players={points}/>
                    <Panel statName="plus-minus" players={plus_minus}/>
                </div>
                <div className="category">
                    <div className="header">Goalies</div>
                    <Panel statName="gaa" players={gaa}/>
                    <Panel statName="wins" players={wins}/>
                    <Panel statName="sv%" players={sv}/>
                    <Panel statName="shutouts" players={so}/>
                </div>
            </div>
        )
    }
}

render(<Leaders />, document.getElementById("leaders"))
