
import React from 'react'
import {  
  BrowserRouter as Router,
  Route
} from 'react-router-dom'

const App = (props) => (
    <div>
        <Header/>
        <Router>
            <div>
                <Route
                    exact={true}
                    path='/'
                    component={Home}
                />
            </div>
        </Router>
        <Footer/>
    </div>
)

const Home = () => {
    return (
        <div>
            Home
        </div>
    )
}

const Header = () => {
    return (
        <div>
            <h1 className="text-center">Moose Hockey League</h1>
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