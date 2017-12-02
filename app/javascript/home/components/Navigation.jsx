import React from 'react'

import {  
  Link
} from 'react-router-dom'

import axios from 'axios'

export default class Navigation extends React.Component {

    constructor () {
        super()

        this.state = {
            leagues: [],
            username: "",
            notifications: 0
        }
    }

    setLeagues () {
        axios.get('api/leagues')
        .then(response => {
            this.setState({leagues: response.data})
        })
        .catch(error => {
            console.error(error)
        })
    }

    setUserInfo () {
        const username = document.querySelector("#app").getAttribute("data-username")
        const notifications = Number(document.querySelector("#app").getAttribute("data-notifications"))

        this.setState({
            username: username,
            notifications: notifications
        })
    }

    componentDidMount () {
        this.setLeagues()
        this.setUserInfo()
    }

    render () {
        return (
            <div className="text-center">
                <nav className="navbar navbar-expand-sm">
                    <Link className="navbar-brand" to="/">Moose Hockey League</Link>
                    <ul className="navbar-nav ml-auto">
                        { this.state.username &&
                            <li className="nav-item">
                                <Link className="nav-link" to="/administrative/notifications"><span className="badge badge-dark">{this.state.notifications}</span> Notifications</Link>
                            </li>
                        }
                        { this.state.username && 
                            <li className="nav-item">
                                <Link className="nav-link" to={`/${this.state.username}`}>{this.state.username}</Link>
                            </li>
                        }
                        { this.state.username == "" &&
                            <li className="nav-item">
                                <Link className="nav-link" to="/administrative/login">Log in</Link>
                            </li>
                        }
                    </ul>
                </nav>
            </div>
        )
    }
}