import React from 'react'
import { Link, Switch, Route } from 'react-router-dom'

const Navigation = () => (
<aside id="menu">
    <div id="navigation">
        <div className="profile-picture">
            <a href="index.html">
                <img src="images/profile.jpg" className="img-circle m-b" alt="logo"/>
            </a>

            <div className="stats-label text-color">
                <span className="font-extra-bold font-uppercase">Robert Razer</span>

                <div className="dropdown">
                    <a className="dropdown-toggle" href="options.html#" data-toggle="dropdown">
                        <small className="text-muted">Founder of App <b className="caret"></b></small>
                    </a>
                    <ul className="dropdown-menu animated flipInX m-t-xs">
                        <li><a href="contacts.html">Contacts</a></li>
                        <li><a href="profile.html">Profile</a></li>
                        <li><a href="analytics.html">Analytics</a></li>
                        <li className="divider"></li>
                        <li><a href="login.html">Logout</a></li>
                    </ul>
                </div>


                <div id="sparkline1" className="small-chart m-t-sm"></div>
                <div>
                    <h4 className="font-extra-bold m-b-xs">
                        $260 104,200
                    </h4>
                    <small className="text-muted">Your income from the last year in sales product X.</small>
                </div>
            </div>
        </div>

        <ul className="nav" id="side-menu">
	        <li><Link to='/'><span className="nav-label">Home</span></Link></li>
	        <li><Link to='/cards'><span className="nav-label">Cards</span></Link></li>
	        <li><Link to='/roster'><span className="nav-label">Roster</span></Link></li>
	        <li><Link to='/schedule'><span className="nav-label">Schedule</span></Link></li>
        </ul>
    </div>
</aside>
)

export default Navigation