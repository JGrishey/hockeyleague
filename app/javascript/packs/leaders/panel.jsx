import React from 'react'
import { render } from 'react-dom'

import ReactTable from 'react-table'

class Panel extends React.Component {
    constructor (props) {
        super(props)
        this.state = {
            name: props.statName,
            players: props.players,
            selected: props.players[0]
        }
    }

    selectPlayer (player) {
        this.setState({selected: player});
    }

    renderPlayer (player) {
        return (
            <div>
                <a href={"/" + player["name"]}>
                    <div className="picture">
                        <img className="photo" src={player["avatar"] === "nil" ? "https://badgeville.com/images/default-user.png" : player["avatar"]}/>
                        <img className="team-photo" src={player["team_logo"]}/>
                    </div>
                    <div className="name">
                        {player["name"]}
                    </div>
                    <div className="category-2">
                        {this.state.name}
                    </div>
                    <div className="number">
                        {
                            this.state.name === "sv%" &&
                            <span>{player[this.state.name.toLowerCase()].toFixed(3)}</span>              
                        }
                        {
                            this.state.name === "gaa" &&
                            <span>{player[this.state.name.toLowerCase()].toFixed(2)}</span>  
                        }
                        {
                            this.state.name === "plus-minus" &&
                            <span>{player[this.state.name.toLowerCase()] > 0 ? "+" + player[this.state.name.toLowerCase()] : player[this.state.name.toLowerCase()]}</span>
                        }
                        {
                            (this.state.name != "sv%" && this.state.name != "gaa" && this.state.name != "plus-minus") &&
                            <span>{player[this.state.name.toLowerCase()]}</span>
                        }
                    </div>
                </a>
            </div>
        )
    }

    render () {
        const { name, players, selected } = this.state

        let maxStat = Math.max.apply(Math, players.map((p) => { return p[name.toLowerCase()] }))

        let content = this.renderPlayer(selected)

        return (
            <div className="panel-stat">
                <div className="name">{name}</div>

                <div className="selected">
                    { content }
                </div>

                <div className="bars">
                    {
                        players.map((player, index) => {
                            return (
                                <div className="bar" key={index} onMouseOver={this.selectPlayer.bind(this, player)} ref={player}>
                                    <div className={player["name"] === selected["name"] ? "player -bold" : "player"}>{player["name"]}</div>
                                        <svg className="percent" width="200px" height="5px">
                                            <rect width={
                                                        player[name.toLowerCase()] > 0 ? player[name.toLowerCase()] / maxStat * 200 : 0
                                                    } 
                                                    height={"5px"} 
                                                    rx="2px" 
                                                    ry="2px" 
                                                    fill={player["name"] === selected["name"] ? "#0183DA" : "#d6d6d5"}>
                                            </rect>
                                        </svg>
                                    <div className={player["name"] === selected["name"] ? "number -bold" : "number"}>
                                        {
                                            name === "sv%" &&
                                            <span>{player[name.toLowerCase()].toFixed(3)}</span>              
                                        }
                                        {
                                            name === "gaa" &&
                                            <span>{player[name.toLowerCase()].toFixed(2)}</span>  
                                        }
                                        {
                                            name === "plus-minus" &&
                                            <span>{player[name.toLowerCase()] > 0 ? "+" + player[name.toLowerCase()] : player[name.toLowerCase()]}</span>
                                        }
                                        {
                                            (name != "sv%" && name != "gaa" && name != "plus-minus") &&
                                            <span>{player[name.toLowerCase()]}</span>
                                        }
                                    </div>
                                </div>
                            )
                        })
                    }
                </div>
            </div>
        )
    }
}

export default Panel;
