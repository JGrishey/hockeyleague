import React from 'react'
import { render } from 'react-dom'
import Panel from './panel'

import ReactTable from 'react-table'

const getData = (attrib) => {
    const data = document.getElementById(attrib + "-leaders").getAttribute("data-data")

    return JSON.parse(data)
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
                    {goals.length == 0 && <div className="noData">No Data</div>}
                    {goals.length > 0 && <Panel statName="goals" players={goals}/>}
                    {assists.length > 0 && <Panel statName="assists" players={assists}/>}
                    {points.length > 0 && <Panel statName="points" players={points}/>}
                    {plus_minus.length > 0 && <Panel statName="plus-minus" players={plus_minus}/>}
                </div>
                <div className="category">
                    <div className="header">Goalies</div>
                    {gaa.length == 0 && <div className="no-data">No Data</div>}
                    {gaa.length > 0 && <Panel statName="gaa" players={gaa}/>}
                    {wins.length > 0 && <Panel statName="wins" players={wins}/>}
                    {sv.length > 0 && <Panel statName="sv%" players={sv}/>}
                    {so.length > 0 && <Panel statName="shutouts" players={so}/>}
                </div>
            </div>
        )
    }
}

render(<Leaders />, document.getElementById("leaders"))
