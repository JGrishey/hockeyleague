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
            <div className="p-3">
                <a href={"/" + player["name"]}>
                    <div className="picture" style={{margin: "0 auto"}}>
                        <img className="img-responsive rounded-circle p-3" style={{maxWidth: "100%", maxHeight: "100%"}} src={player["avatar"] === "nil" ? "https://badgeville.com/images/default-user.png" : player["avatar"]}/>
                    </div>
                    <div className="text-center font-weight-bold text-uppercase">
                        {player["name"]}
                    </div>
                    <div className="text-center font-weight-bold text-uppercase">
                        {
                            this.state.name === "sv_per" &&
                            <span>{"SV%"}</span>
                        }
                        {
                            this.state.name === "goalie_games" &&
                            <span>{"GAMES PLAYED"}</span>
                        }
                        {
                            this.state.name === "plus_minus" &&
                            <span>{"+/-"}</span>
                        }
                        {
                            this.state.name != "sv_per" && this.state.name != "goalie_games" && this.state.name != "plus_minus" &&
                            <span>{this.state.name}</span>
                        }
                    </div>
                    <div className="text-center font-weight-bold">
                        {
                            this.state.name === "sv_per" &&
                            <span>{player[this.state.name.toLowerCase()].toFixed(3)}</span>              
                        }
                        {
                            this.state.name === "gaa" &&
                            <span>{player[this.state.name.toLowerCase()].toFixed(2)}</span>  
                        }
                        {
                            this.state.name === "plus_minus" &&
                            <span>{player[this.state.name.toLowerCase()] > 0 ? "+" + player[this.state.name.toLowerCase()] : player[this.state.name.toLowerCase()]}</span>
                        }
                        {
                            (this.state.name != "sv_per" && this.state.name != "gaa" && this.state.name != "plus_minus") &&
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
            <div className="col-12 col-lg-6">
                <div className="text-center font-weight-bold text-uppercase">
                        {
                            name === "sv_per" &&
                            <span>{"SV%"}</span>
                        }
                        {
                            name === "goalie_games" &&
                            <span>{"GAMES PLAYED"}</span>
                        }
                        {
                            name === "plus_minus" &&
                            <span>{"+/-"}</span>
                        }
                        {
                            name != "sv_per" && name != "goalie_games" && name != "plus_minus" &&
                            <span>{name}</span>
                        }
                </div>

                <div className="row">
                    <div className="col-6 p-4">
                        { content }
                    </div>

                    <div className="col-6">
                        {
                            players.map((player, index) => {
                                return (
                                    <div className="text-left" key={index} onMouseOver={this.selectPlayer.bind(this, player)} ref={player}>
                                        <div className="row">
                                            <div className="col-12">{player["name"]}</div>
                                        </div>
                                        <div className="row">
                                            <div className="col-9 align-self-center">
                                                <div className="progress align-self-center">
                                                    <div className={player["name"] === selected["name"] ? "progress-bar bg-primary" : "progess-bar bg-dark"} 
                                                        role="progressbar" 
                                                        style={{height: "5px", width: player[name.toLowerCase()] > 0 ? player[name.toLowerCase()] / maxStat * 100 + "%" : "0"}}
                                                        aria-valuenow={ player[name.toLowerCase()] > 0 ? player[name.toLowerCase()].toString() : "0"}
                                                        aria-valuemin="0" 
                                                        aria-valuemax={maxStat.toString()}>
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="col-3 text-left align-top">
                                                {
                                                    name === "sv_per" &&
                                                    <span style={{fontSize: "0.9em"}}>{player[name.toLowerCase()].toFixed(3)}</span>              
                                                }
                                                {
                                                    name === "gaa" &&
                                                    <span>{player[name.toLowerCase()].toFixed(2)}</span>  
                                                }
                                                {
                                                    name === "plus_minus" &&
                                                    <span>{player[name.toLowerCase()] > 0 ? "+" + player[name.toLowerCase()] : player[name.toLowerCase()]}</span>
                                                }
                                                {
                                                    (name != "sv_per" && name != "gaa" && name != "plus_minus") &&
                                                    <span>{player[name.toLowerCase()]}</span>
                                                }
                                            </div>
                                        </div>
                                    </div>
                                )
                            })
                        }
                    </div>
                </div>
            </div>
        )
    }
}

export default Panel;
