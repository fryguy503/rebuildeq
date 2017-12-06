import React from 'react'
import { Link } from 'react-router-dom'

// The Header creates links that can be used to navigate
// between routes.
const Header = () => (
<div id="header">
    <div className="color-line">
    </div>
    <div id="logo" className="light-version">
        <span>
            RebuildEQ
        </span>
    </div>
    <nav role="navigation">
        <div className="small-logo">
            <span className="text-primary">RebuildEQ</span>
        </div>
        
        <div className="mobile-menu">
            <button type="button" className="navbar-toggle mobile-menu-toggle" data-toggle="collapse" data-target="#mobile-collapse">
                <i className="fa fa-chevron-down"></i>
            </button>
            <div className="collapse mobile-navbar" id="mobile-collapse">
                <ul className="nav navbar-nav">
                    <li>
                        <a className="" href="login.html">Login</a>
                    </li>
                    <li>
                        <a className="" href="login.html">Logout</a>
                    </li>
                    <li>
                        <a className="" href="profile.html">Profile</a>
                    </li>
                </ul>
            </div>
        </div>
        <div className="navbar-right">
            <ul className="nav navbar-nav no-borders">
                <li className="dropdown">
                    <a className="dropdown-toggle" href="options.html#" data-toggle="dropdown">
                        <i className="pe-7s-speaker"></i>
                    </a>
                    <ul className="dropdown-menu hdropdown notification animated flipInX">
                        <li>
                            <a>
                                <span className="label label-success">NEW</span> It is a long established.
                            </a>
                        </li>
                        <li>
                            <a>
                                <span className="label label-warning">WAR</span> There are many variations.
                            </a>
                        </li>
                        <li>
                            <a>
                                <span className="label label-danger">ERR</span> Contrary to popular belief.
                            </a>
                        </li>
                        <li className="summary"><a href="options.html#">See all notifications</a></li>
                    </ul>
                </li>
                <li className="dropdown">
                    <a className="dropdown-toggle" href="options.html#" data-toggle="dropdown">
                        <i className="pe-7s-keypad"></i>
                    </a>

                    <div className="dropdown-menu hdropdown bigmenu animated flipInX">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <a href="projects.html">
                                        <i className="pe pe-7s-portfolio text-info"></i>
                                        <h5>Projects</h5>
                                    </a>
                                </td>
                                <td>
                                    <a href="mailbox.html">
                                        <i className="pe pe-7s-mail text-warning"></i>
                                        <h5>Email</h5>
                                    </a>
                                </td>
                                <td>
                                    <a href="contacts.html">
                                        <i className="pe pe-7s-users text-success"></i>
                                        <h5>Contacts</h5>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="forum.html">
                                        <i className="pe pe-7s-comment text-info"></i>
                                        <h5>Forum</h5>
                                    </a>
                                </td>
                                <td>
                                    <a href="analytics.html">
                                        <i className="pe pe-7s-graph1 text-danger"></i>
                                        <h5>Analytics</h5>
                                    </a>
                                </td>
                                <td>
                                    <a href="file_manager.html">
                                        <i className="pe pe-7s-box1 text-success"></i>
                                        <h5>Files</h5>
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </li>
                <li className="dropdown">
                    <a className="dropdown-toggle label-menu-corner" href="options.html#" data-toggle="dropdown">
                        <i className="pe-7s-mail"></i>
                        <span className="label label-success">4</span>
                    </a>
                    <ul className="dropdown-menu hdropdown animated flipInX">
                        <div className="title">
                            You have 4 new messages
                        </div>
                        <li>
                            <a>
                                It is a long established.
                            </a>
                        </li>
                        <li>
                            <a>
                                There are many variations.
                            </a>
                        </li>
                        <li>
                            <a>
                                Lorem Ipsum is simply dummy.
                            </a>
                        </li>
                        <li>
                            <a>
                                Contrary to popular belief.
                            </a>
                        </li>
                        <li className="summary"><a href="options.html#">See All Messages</a></li>
                    </ul>
                </li>
                <li>
                    <a href="options.html#" id="sidebar" className="right-sidebar-toggle">
                        <i className="pe-7s-upload pe-7s-news-paper"></i>
                    </a>
                </li>
                <li className="dropdown">
                    <a href="login.html">
                        <i className="pe-7s-upload pe-rotate-90"></i>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</div>


)

export default Header
