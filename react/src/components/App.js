import React from 'react'
import Navigation from './Navigation'
import Header from './Header'
import BreadCrumb from './BreadCrumb'
import Footer from './Footer'
import Main from './Main'

const App = () => (
  <div className="boxed-wrapper">
  	<Header />
  	<Navigation />    
  	<div id="wrapper">
	  	<BreadCrumb />
	  	<div className="content">
	    	<Main />
	    </div>
	    <Footer />
    </div>
  </div>
)

export default App
