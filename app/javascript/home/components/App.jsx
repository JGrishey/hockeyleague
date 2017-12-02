import React from 'react'

import {  
  HashRouter as Router,
  Route,
  Link
} from 'react-router-dom'

import axios from 'axios'

import Navigation from './Navigation'
import Home from './Home'

const App = (props) => (
    <div className="container mt-3"> 
        <Router>
            <div>
                <Navigation/>
                <Route
                    exact={true}
                    path='/'
                    render={() => {
                        return (
                            <Home/>
                        )
                    }}
                />
                <Route
                    path='/league/:name'
                    component={League}
                />
                <Footer/>
            </div>
        </Router>
    </div>
)

const League = () => {
    return (
        <div>
            League
        </div>
    )
}

const Footer = () => {
    return (
        <div>
            Footer
        </div>
    )
}

export default App  