import React from 'react'

import { Link } from 'react-router-dom'

import axios from 'axios'

export default class Chat extends React.Component {
    constructor () {
        super()

        this.state = {
            messages: [],
            chat_box_id: 1,
            message: "Enter a message.",
        }

        this.handleSubmit = this.handleSubmit.bind(this)
        this.handleChange = this.handleChange.bind(this)
        this.setCable = this.setCable.bind(this)
    }

    getMessages () {
        axios.get('api/chat_boxes/1/messages')
        .then(response => {
            this.setState({messages: response.data})
            console.log(response.data)
        })
        .catch(error => {
            console.error(error)
        })
    }

    setCable () {
        let self = this
        this.cable = App.cable.subscriptions.create(
            {
                channel: "ChatBoxesChannel",
                chat_box_id: this.state.chat_box_id
            }, 
            {
                connected () {},
                disconnected () {},
                received(data) {
                    return self.setState((previous) => ({
                        messages: previous.messages.concat([{body: data['message'], author: data['author'], id: data['id'], time: data['time']}])
                    }))
                },
                send_message(message, chat_box_id) {
                    return this.perform("send_message", {message, chat_box_id});
                }
            },
        )
    }

    handleSubmit (event) {
        this.cable.send_message(this.state.message, this.state.chat_box_id);
        event.preventDefault()
    }

    handleChange (event) {
        this.setState({message: event.target.value})
    }

    componentDidMount () {
        this.getMessages()
        this.setCable()
    }

    render () {
        return (
            <div>
                <nav className="navbar text-white bg-main highlighted navbar-expand-sm border border-main border-left-0 border-right-0">
                    <ul className="navbar-nav mr-auto ml-auto">
                        <li className="nav-item ml-1 mr-1">
                            <Link className="nav-link" to="/administrative/rules">Rules</Link>
                        </li>
                        <li className="nav-item nav-active ml-1 mr-1">
                            <Link className="nav-link" to="/pages/chat">Chat</Link>
                        </li>
                    </ul>
                </nav>
                <div id="chatbox">
                    <div id="messages" data-chat-box-id={this.chat_box_id}>
                        {this.state.messages.map((m) => {
                            return (
                                <div key={m.id}>
                                    <div className="row mt-1 pt-2 justify-content-center">
                                        <div className="col-11 border border-top-0 border-right-0 border-bottom-0">
                                            <div className="row justify-content-between mb-2">
                                                <div className="col-3 text-left font-weight-bold">
                                                    {m.author}
                                                </div>
                                                <div className="col-3 text-right text-muted">
                                                    {m.time} ago
                                                </div>
                                            </div>
                                            <div className="row">
                                                <div className="col-12 text-left message-to-be-parsed" dangerouslySetInnerHTML={{__html: m.body}}>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            )
                        })}
                    </div>
                    <form noValidate="novalidate" id="new_message" url="#" method="post" onSubmit={this.handleSubmit}>
                        <input type="text" value={this.state.message} onChange={this.handleChange} id="message_body"/>
                        <input type="submit" id="real-submit"/>
                    </form>
                </div>
            </div>
        )
    }
}