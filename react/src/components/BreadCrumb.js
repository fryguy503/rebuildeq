import React from 'react'
import { Link } from 'react-router-dom'

const BreadCrumb = () => (
    <div className="small-header">
        <div className="hpanel">
            <div className="panel-body">
                <div id="hbreadcrumb" className="pull-right">
                    <ol className="hbreadcrumb breadcrumb">
                        <li><a href="index.html">Dashboard</a></li>
                        <li className="active">
                            <span>Options </span>
                        </li>
                    </ol>
                </div>
                <h2 className="font-light m-b-xs">
                    Options
                </h2>
                <small>Example small header for demo purpose.</small>
            </div>
        </div>
    </div>
)

export default BreadCrumb
