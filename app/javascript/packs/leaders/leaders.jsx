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
            gp: getData("gp"),
            sv: getData("sv"),
            so: getData("so")
        }
    }

    render () {
        const { goals, assists, points, plus_minus, gaa, gp, sv, so } = this.state

        return (
            <div>
                <div className="card mt-4">
                    <div className="card-header text-center bg-dark text-white">Skaters</div>
                    <div className="card-body row">
                        {goals.length == 0 && 
                                <div className="card-text text-center col-12">No Data</div>
                        }
                        {goals.length > 0 && <Panel statName="goals" players={goals}/>}
                        {assists.length > 0 && <Panel statName="assists" players={assists}/>}
                        {points.length > 0 && <Panel statName="points" players={points}/>}
                        {plus_minus.length > 0 && <Panel statName="plus_minus" players={plus_minus}/>}
                    </div>
                </div>
                <div className="card mt-4">
                    <div className="card-header text-center bg-dark text-white">Goalies</div>
                    <div className="card-body row">
                        {gaa.length == 0 && 
                                <div className="card-text text-center col-12">No Data</div>
                        }
                        {gaa.length > 0 && <Panel statName="gaa" players={gaa}/>}
                        {gp.length > 0 && <Panel statName="goalie_games" players={gp}/>}
                        {sv.length > 0 && <Panel statName="sv_per" players={sv}/>}
                        {so.length > 0 && <Panel statName="so" players={so}/>}
                    </div>
                </div>
            </div>
        )
    }
}

render(<Leaders />, document.getElementById("leaders"))
