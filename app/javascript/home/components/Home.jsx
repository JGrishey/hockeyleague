import React from 'react'

import { Link } from 'react-router-dom'

import axios from 'axios'
import Chat from './Chat'

export default class Home extends React.Component {
    constructor () {
        super()

        this.state = {

        }
    }

    render () {
        return (
            <div>
                <Chat></Chat>
            </div>
        )
    }
}