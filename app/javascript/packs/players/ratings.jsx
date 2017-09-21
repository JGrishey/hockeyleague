import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

const getData = () => {
    const data = document.getElementById("ratings").getAttribute("data-data")

    return JSON.parse(data)
}

class Ratings extends React.Component {
    constructor () {
        super()
        this.state = {
            players: getData()
        }
    }

    render () {
        const { players } = this.state

        return (
            <div>
                {players.map((player, index) => {
                    return (
                        <div key={index} className="row justify-content-center p-3">
                            <div className="col-2 col-lg-1 text-left bg-white align-self-center p-3 ">
                                <a href={"/" + player["user_name"] }>
                                    <img className="img-fluid rounded-circle" src={player["user_avatar"] === "nil" ? "https://badgeville.com/images/default-user.png" : player["user_avatar"]}/>
                                </a>
                            </div>
                            <div className="col-6 col-lg-3 text-left bg-white align-self-center p-3 ">
                                <a href={"/" + player["user_name"] }>
                                    {player["user_name"]}
                                </a>
                            </div>
                            <div className="col-4 col-lg-2 text-center align-self-center p-3 font-weight-bold" style={{backgroundColor: "rgba(255, 133, 0, " + player['norm_rating'] + ")"}}>
                                { player["rating"] * 100 }
                            </div>
                        </div>
                    )
                })}
            </div>
        )
    }
}

render(<Ratings />, document.getElementById("ratings"))
