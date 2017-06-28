<!DOCTYPE html>
<html>

<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta property="og:title" content="{$site->title}">
      <meta property="og:type" content="website">
      <meta property="twitter:account_id" content="4777423195">
      <meta itemprop="name" content="RebuildEQ">
      <meta itemprop="description" content="Rebuild EQ - A private Everquest server">
      <meta property="og:url" content="http://rebuildeq.com">
      <meta property="og:image" content="{$site->image}">
      <meta property="og:site_name" content="RebuildEQ.com">
      <meta property="og:description" content="{$site->description}">
      <meta name="description" content="{$site->description}">
      <meta name="author" content="Shin Noir, @rebuildeq">
  <title>{$site->title} | RebuildEQ</title>
  
<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'>

  <!-- FullCalendar Plugin CSS -->
  <link rel="stylesheet" type="text/css" href="/r2/vendor/plugins/fullcalendar/fullcalendar.min.css">

  <!-- Theme CSS -->
  <link rel="stylesheet" type="text/css" href="/r2/assets/skin/default_skin/css/theme.css">

  <!-- Admin Forms CSS -->
  <link rel="stylesheet" type="text/css" href="/r2/assets/admin-tools/admin-forms/css/admin-forms.css">

  <!-- Favicon -->
  {if !empty($favicon)}<link rel="shortcut icon" href="{$favicon}">{else}<link rel="shortcut icon" href="/favicon/rebuildeq.ico">{/if}

<link rel="stylesheet" type="text/css" href="/r2/vendor/plugins/footable/css/footable.core.min.css">

<link rel="stylesheet" type="text/css" href="/css/icons.css">
<!-- jQuery -->
<script src="/r2/vendor/jquery/jquery-1.11.1.min.js"></script>
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="/r2/https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="/r2/https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  <![endif]-->
</head>

<body class="dashboard-page sb-l-m">

{*<div id="skin-toolbox">
  <div class="panel">
    <div class="panel-heading">
        <span class="panel-icon">
          <i class="fa fa-gear"></i>
        </span>
      <span class="panel-title"> Theme Options</span>
    </div>
    <div class="panel-body pn">
      <ul class="nav nav-list nav-list-sm pl15 pt10" role="tablist">
        <li class="active">
          <a href="#toolbox-header" role="tab" data-toggle="tab">Navbar</a>
        </li>
        <li>
          <a href="#toolbox-sidebar" role="tab" data-toggle="tab">Sidebar</a>
        </li>
        <li>
          <a href="#toolbox-settings" role="tab" data-toggle="tab">Misc</a>
        </li>
      </ul>
      <div class="tab-content p20 ptn pb15">
        <div role="tabpanel" class="tab-pane active" id="toolbox-header">
          <form id="toolbox-header-skin">
            <h4 class="mv20">Header Skins</h4>
            <div class="skin-toolbox-swatches">
              <div class="checkbox-custom checkbox-disabled fill mb5">
                <input type="radio" name="headerSkin" id="headerSkin8" checked value="">
                <label for="headerSkin8">Light</label>
              </div>
              <div class="checkbox-custom fill checkbox-primary mb5">
                <input type="radio" name="headerSkin" id="headerSkin1" value="bg-primary">
                <label for="headerSkin1">Primary</label>
              </div>
              <div class="checkbox-custom fill checkbox-info mb5">
                <input type="radio" name="headerSkin" id="headerSkin3" value="bg-info">
                <label for="headerSkin3">Info</label>
              </div>
              <div class="checkbox-custom fill checkbox-warning mb5">
                <input type="radio" name="headerSkin" id="headerSkin4" value="bg-warning">
                <label for="headerSkin4">Warning</label>
              </div>
              <div class="checkbox-custom fill checkbox-danger mb5">
                <input type="radio" name="headerSkin" id="headerSkin5" value="bg-danger">
                <label for="headerSkin5">Danger</label>
              </div>
              <div class="checkbox-custom fill checkbox-alert mb5">
                <input type="radio" name="headerSkin" id="headerSkin6" value="bg-alert">
                <label for="headerSkin6">Alert</label>
              </div>
              <div class="checkbox-custom fill checkbox-system mb5">
                <input type="radio" name="headerSkin" id="headerSkin7" value="bg-system">
                <label for="headerSkin7">System</label>
              </div>
              <div class="checkbox-custom fill checkbox-success mb5">
                <input type="radio" name="headerSkin" id="headerSkin2" value="bg-success">
                <label for="headerSkin2">Success</label>
              </div>
              <div class="checkbox-custom fill mb5">
                <input type="radio" name="headerSkin" id="headerSkin9" value="bg-dark">
                <label for="headerSkin9">Dark</label>
              </div>
            </div>
          </form>
        </div>
        <div role="tabpanel" class="tab-pane" id="toolbox-sidebar">
          <form id="toolbox-sidebar-skin">
            <h4 class="mv20">Sidebar Skins</h4>
            <div class="skin-toolbox-swatches">
              <div class="checkbox-custom fill mb5">
                <input type="radio" name="sidebarSkin" checked id="sidebarSkin3" value="">
                <label for="sidebarSkin3">Dark</label>
              </div>
              <div class="checkbox-custom fill checkbox-disabled mb5">
                <input type="radio" name="sidebarSkin" id="sidebarSkin1" value="sidebar-light">
                <label for="sidebarSkin1">Light</label>
              </div>
              <div class="checkbox-custom fill checkbox-light mb5">
                <input type="radio" name="sidebarSkin" id="sidebarSkin2" value="sidebar-light light">
                <label for="sidebarSkin2">Lighter</label>
              </div>
            </div>
          </form>
        </div>
        <div role="tabpanel" class="tab-pane" id="toolbox-settings">
          <form id="toolbox-settings-misc">
            <h4 class="mv20 mtn">Layout Options</h4>
            <div class="form-group">
              <div class="checkbox-custom fill mb5">
                <input type="checkbox" checked="" id="header-option">
                <label for="header-option">Fixed Header</label>
              </div>
            </div>
            <div class="form-group">
              <div class="checkbox-custom fill mb5">
                <input type="checkbox" checked="" id="sidebar-option">
                <label for="sidebar-option">Fixed Sidebar</label>
              </div>
            </div>
            <div class="form-group">
              <div class="checkbox-custom fill mb5">
                <input type="checkbox" id="breadcrumb-option">
                <label for="breadcrumb-option">Fixed Breadcrumbs</label>
              </div>
            </div>
            <div class="form-group">
              <div class="checkbox-custom fill mb5">
                <input type="checkbox" id="breadcrumb-hidden">
                <label for="breadcrumb-hidden">Hide Breadcrumbs</label>
              </div>
            </div>
            <h4 class="mv20">Layout Options</h4>
            <div class="form-group">
              <div class="radio-custom mb5">
                <input type="radio" id="fullwidth-option" checked name="layout-option">
                <label for="fullwidth-option">Fullwidth Layout</label>
              </div>
            </div>
            <div class="form-group mb20">
              <div class="radio-custom radio-disabled mb5">
                <input type="radio" id="boxed-option" name="layout-option" disabled>
                <label for="boxed-option">Boxed Layout
                  <b class="text-muted">(Coming Soon)</b>
                </label>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="form-group mn br-t p15">
        <a href="#" id="clearLocalStorage" class="btn btn-primary btn-block pb10 pt10">Clear LocalStorage</a>
      </div>
    </div>
  </div>
</div>*}
<!-- End: Theme Preview Pane -->

<!-- Start: Main -->
<div id="main">

{*
  <!--
     ".navbar" Helper Classes:
  
     * Positioning Classes:
      '.navbar-static-top' - Static top positioned navbar
      '.navbar-static-top' - Fixed top positioned navbar

     * Available Skin Classes:
       .bg-dark    .bg-primary   .bg-success
       .bg-info    .bg-warning   .bg-danger
       .bg-alert   .bg-system
  
    Example: <header class="navbar navbar-fixed-top bg-primary">
    Results: Fixed top navbar with blue background
  -->
*}

{if isset($showHeader) AND $showHeader == true}
  <!-- Start: Header -->
  <header class="navbar bg-danger navbar-fixed-top navbar-shadow bg-dark">
    <div class="navbar-branding dark bg-dark">
      <a class="navbar-brand" href="/">
        <b>Rebuild</b>EQ
      </a>
      <span id="toggle_sidemenu_l" class="fa fa-align-justify"></span>
    </div>
    <ul class="nav navbar-nav navbar-left">
      
      {*<li>
        <form class="navbar-form navbar-left navbar-search alt" role="search">
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Search..." value="Search...">
          </div>
        </form>
      </li>*}
      {*<li class="dropdown menu-merge hidden-xs">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown
          <span class="fa fa-angle-down"></span>
        </a>
        <ul class="dropdown-menu" role="menu">
          <li><a href="#">Action</a></li>
          <li><a href="#">Another action</a></li>
          <li><a href="#">Something else here</a></li>
          <li class="divider"></li>
          <li><a href="#">Separated link</a></li>
        </ul>
      </li>
      *}
    </ul>
    <ul class="nav navbar-nav navbar-right">
      {*<li>
        <div class="navbar-btn btn-group">
          <a href="#" class="topbar-menu-toggle btn btn-sm" data-toggle="button">
            <span class="imoon imoon-wand"></span>
          </a>
        </div>
      </li>*}
      {*<li class="dropdown menu-merge">
        <div class="navbar-btn btn-group">
          <button aria-expanded="true" data-toggle="dropdown" class="btn btn-sm dropdown-toggle">
            <span class="ad fa fa-bell-o va-m"></span>
          </button>
          <div class="dropdown-menu dropdown-persist w350 animated animated-shorter fadeIn" role="menu">
            <div class="panel mbn">
              <div class="panel-menu">
                <div class="btn-group btn-group-justified btn-group-nav" role="tablist">
                  <a href="#nav-tab1" data-toggle="tab" class="btn btn-default btn-sm active">Notifications</a>
                  <a href="#nav-tab2" data-toggle="tab" class="btn btn-default btn-sm br-l-n br-r-n">Messages</a>
                  <a href="#nav-tab3" data-toggle="tab" class="btn btn-default btn-sm">Activity</a>
                </div>
              </div>
              <div class="panel-body panel-scroller scroller-navbar pn scroller scroller-active">
                <!--<div style="height: 250px;" class="scroller-bar">-->
                  <!--<div style="height: 250px; margin-bottom: 0px; margin-top: 0px;" class="scroller-track">-->
                    <!--<div style="height: 179.598px; top: 0px;" class="scroller-handle"></div>-->
                  <!--</div>-->
                <!--</div>-->
                <div class="scroller-content">
                <div class="tab-content br-n pn">
                  <div id="nav-tab1" class="tab-pane alerts-widget active" role="tabpanel">
                    <div class="media">
                      <a class="media-left" href="#"> <span class="glyphicon glyphicon-user"></span> </a>
                      <div class="media-body">
                        <h5 class="media-heading">New Registration
                          <small class="text-muted"></small>
                        </h5> Tyler Durden - 16 hours ago

                      </div>
                      <div class="media-right">
                        <div class="media-response"> Approve?</div>
                        <div class="btn-group">
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-check text-success"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-remove"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div class="media">
                      <a class="media-left" href="#"> <span class="glyphicon glyphicon-shopping-cart"></span> </a>
                      <div class="media-body">
                        <h5 class="media-heading">New Order
                          <small class="text-muted"></small>
                        </h5> <a href="#">Apple Ipod</a> - 4 hours ago
                      </div>
                      <div class="media-right">
                        <div class="media-response"> Confirm?</div>
                        <div class="btn-group">
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-check text-success"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-print"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div class="media">
                      <a class="media-left" href="#"> <span class="glyphicon glyphicon-comment"></span> </a>
                      <div class="media-body">
                        <h5 class="media-heading">New Comment
                          <small class="text-muted"></small>
                        </h5> Mike - I loved your article!
                      </div>
                      <div class="media-right">
                        <div class="media-response text-right"> Moderate?</div>
                        <div class="btn-group">
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-pencil"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-check text-success"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div class="media">
                      <a class="media-left" href="#"> <span class="glyphicon glyphicon-star"></span> </a>
                      <div class="media-body">
                        <h5 class="media-heading">New Review
                          <small class="text-muted"></small>
                        </h5> Sammy Hilton - 4 hours ago
                      </div>
                      <div class="media-right">
                        <div class="media-response"> Approve?</div>
                        <div class="btn-group">
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-check text-success"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-remove"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                    <div class="media">
                      <a class="media-left" href="#"> <span class="glyphicon glyphicon-user"></span> </a>
                      <div class="media-body">
                        <h5 class="media-heading">New Registration
                          <small class="text-muted"></small>
                        </h5> Michael Sober - 7 hours ago
                      </div>
                      <div class="media-right">
                        <div class="media-response"> Approve?</div>
                        <div class="btn-group">
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-check text-success"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-xs dark">
                            <i class="fa fa-remove"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div id="nav-tab2" class="tab-pane chat-widget" role="tabpanel">
                    <div class="media">
                      <div class="media-left">
                        <a href="#">
                          <img class="media-object" alt="64x64" src="/r2/assets/img/avatars/3.jpg">
                        </a>
                      </div>
                      <div class="media-body">
                        <span class="media-status online"></span>
                        <h5 class="media-heading">Courtney Faught
                          <small> - 12:30am</small>
                        </h5> Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin.
                      </div>
                    </div>
                    <div class="media">
                      <div class="media-body">
                        <span class="media-status offline"></span>
                        <h5 class="media-heading">Joe Gibbons
                          <small> - 12:30am</small>
                        </h5> Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque.
                      </div>
                      <div class="media-right">
                        <a href="#">
                          <img class="media-object" alt="64x64" src="/r2/assets/img/avatars/1.jpg">
                        </a>
                      </div>
                    </div>
                  </div>
                  <div id="nav-tab3" class="tab-pane scroller-nm" role="tabpanel">
                    <ul class="media-list" role="menu">
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/5.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading">Article
                            <small class="text-muted">- 08/16/22</small>
                          </h5> Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/2.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading mv5">Article
                            <small> - 08/16/22</small>
                          </h5>
                          Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/3.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading">Article
                            <small class="text-muted">- 08/16/22</small>
                          </h5> Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/4.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading mv5">Article
                            <small class="text-muted">- 08/16/22</small>
                          </h5> Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/5.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading">Article
                            <small class="text-muted">- 08/16/22</small>
                          </h5> Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/2.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading mv5">Article
                            <small> - 08/16/22</small>
                          </h5>
                          Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                      <li class="media">
                        <a class="media-left" href="#"> <img src="/r2/assets/img/avatars/3.jpg" class="mw40" alt="avatar"> </a>
                        <div class="media-body">
                          <h5 class="media-heading">Article
                            <small class="text-muted">- 08/16/22</small>
                          </h5> Last Updated 36 days ago by
                          <a class="text-system" href="#"> Max </a>
                        </div>
                      </li>
                    </ul>
                    <table class="table table-striped hidden">
                      <thead>
                      <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Username</th>
                      </tr>
                      </thead>
                      <tbody>
                      <tr>
                        <td>Mark</td>
                        <td>Otto</td>
                        <td>@mdo</td>
                      </tr>
                      <tr>
                        <td>Jacob</td>
                        <td>Thornton</td>
                        <td>@fat</td>
                      </tr>
                      <tr>
                        <td>Larry</td>
                        <td>the Bird</td>
                        <td>@twitter</td>
                      </tr>
                      <tr>
                        <td>Sussy</td>
                        <td>Watcher</td>
                        <td>@thehawk</td>
                      </tr>
                      <tr>
                        <td>Mark</td>
                        <td>Otto</td>
                        <td>@mdo</td>
                      </tr>
                      <tr>
                        <td>Sussy</td>
                        <td>Watcher</td>
                        <td>@thehawk</td>
                      </tr>
                      <tr>
                        <td>Jacob</td>
                        <td>Thornton</td>
                        <td>@fat</td>
                      </tr>
                      <tr>
                        <td>Larry</td>
                        <td>the Bird</td>
                        <td>@twitter</td>
                      </tr>
                      <tr>
                        <td>Sussy</td>
                        <td>Watcher</td>
                        <td>@thehawk</td>
                      </tr>
                      <tr>
                        <td>Mark</td>
                        <td>Otto</td>
                        <td>@mdo</td>
                      </tr>
                      <tr>
                        <td>Jacob</td>
                        <td>Thornton</td>
                        <td>@fat</td>
                      </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div></div>
              <div class="panel-footer text-center p9">
                <a href="#" class=""> View All </a>
              </div>
            </div>
          </div>
        </div>
      </li>*}
      {*<li class="dropdown menu-merge">
        <div class="navbar-btn btn-group">
          <button data-toggle="dropdown" class="btn btn-sm dropdown-toggle">
            <span class="flag-xs flag-us"></span>
            <!-- <span class="caret"></span> -->
          </button>
          <ul class="dropdown-menu pv5 animated animated-short flipInX" role="menu">
            <li>
              <a href="/r2/javascript:void(0);">
                <span class="flag-xs flag-in mr10"></span> Hindu </a>
            </li>
            <li>
              <a href="/r2/javascript:void(0);">
                <span class="flag-xs flag-tr mr10"></span> Turkish </a>
            </li>
            <li>
              <a href="/r2/javascript:void(0);">
                <span class="flag-xs flag-es mr10"></span> Spanish </a>
            </li>
          </ul>
        </div>
      </li>*}
      {*<li class="menu-divider hidden-xs">
        <i class="fa fa-circle"></i>
      </li>*}
      {*<li class="dropdown menu-merge">
        <a href="#" class="dropdown-toggle fw700 p15" data-toggle="dropdown">
          <img src="/r2/assets/img/avatars/1.jpg" alt="avatar" class="mw30 br64">
          <span class="hidden-xs pl15 pr5"> John Doe </span>
          <span class="fa fa-angle-down hidden-xs"></span>
        </a>
        <ul class="dropdown-menu list-group dropdown-persist w250" role="menu">
          <li class="dropdown-header clearfix">
            <div class="pull-left ml10">
              <select id="user-status">
                <optgroup label="Current Status:">
                  <option value="1-1">Away</option>
                  <option value="1-2">Offline</option>
                  <option value="1-3" selected="selected">Online</option>
                </optgroup>
              </select>
            </div>

            <div class="pull-right mr10">
              <select id="user-role">
                <optgroup label="Logged in As:">
                  <option value="1-1">Client</option>
                  <option value="1-2">Editor</option>
                  <option value="1-3" selected="selected">Admin</option>
                </optgroup>
              </select>
            </div>
          </li>
          <li class="list-group-item">
            <a href="#" class="animated animated-short fadeInUp">
              <span class="fa fa-envelope"></span> Messages
              <span class="label label-warning">2</span>
            </a>
          </li>
          <li class="list-group-item">
            <a href="#" class="animated animated-short fadeInUp">
              <span class="fa fa-user"></span> Friends
              <span class="label label-warning">6</span>
            </a>
          </li>
          <li class="list-group-item">
            <a href="#" class="animated animated-short fadeInUp">
              <span class="fa fa-bell"></span> Notifications </a>
          </li>
          <li class="list-group-item">
            <a href="#" class="animated animated-short fadeInUp">
              <span class="fa fa-gear"></span> Settings </a>
          </li>
          <li class="dropdown-footer">
            <a href="#" class="">
              Logout </a>
          </li>
        </ul>
      </li>*}
    </ul>
  </header>
  <!-- End: Header -->
  {/if}

  <!-- Start: Sidebar -->
  <aside id="sidebar_left" class="nano nano-light affix" {if !empty($showHeader) AND !$showHeader}style="padding-top: 0px;"{/if}>

    <!-- Start: Sidebar Left Content -->
    <div class="sidebar-left-content nano-content">

      <!-- Start: Sidebar Header -->
      <header class="sidebar-header">

        <!-- Sidebar Widget - Menu (slidedown) -->
        <div class="sidebar-widget menu-widget">
          <div class="row text-center mbn">
            <div class="col-xs-4">
              <a href="/r2/dashboard.html" class="text-primary" data-toggle="tooltip" data-placement="top" title="Dashboard">
                <span class="glyphicon glyphicon-home"></span>
              </a>
            </div>
            <div class="col-xs-4">
              <a href="/r2/pages_messages.html" class="text-info" data-toggle="tooltip" data-placement="top" title="Messages">
                <span class="glyphicon glyphicon-inbox"></span>
              </a>
            </div>
            <div class="col-xs-4">
              <a href="/r2/pages_profile.html" class="text-alert" data-toggle="tooltip" data-placement="top" title="Tasks">
                <span class="glyphicon glyphicon-bell"></span>
              </a>
            </div>
            <div class="col-xs-4">
              <a href="/r2/pages_timeline.html" class="text-system" data-toggle="tooltip" data-placement="top" title="Activity">
                <span class="fa fa-desktop"></span>
              </a>
            </div>
            <div class="col-xs-4">
              <a href="/r2/pages_profile.html" class="text-danger" data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="fa fa-gears"></span>
              </a>
            </div>
            <div class="col-xs-4">
              <a href="/r2/pages_gallery.html" class="text-warning" data-toggle="tooltip" data-placement="top" title="Cron Jobs">
                <span class="fa fa-flask"></span>
              </a>
            </div>
          </div>
        </div>

        <!-- Sidebar Widget - Search (hidden) -->
        <div class="sidebar-widget search-widget hidden">
          <div class="input-group">
              <span class="input-group-addon">
                <i class="fa fa-search"></i>
              </span>
            <input type="text" id="sidebar-search" class="form-control" placeholder="Search...">
          </div>
        </div>

      </header>
      <!-- End: Sidebar Header -->

      <!-- Start: Sidebar Menu -->
      <ul class="nav sidebar-menu">
        <li class="sidebar-label">Menu</li>
        <li>
          <a href="/about">
            <span class="fa fa-question"></span>
            <span class="sidebar-title">About RebuildEQ</span>
              <span class="sidebar-title-tray">
              </span>
          </a>
        </li>
        <li>
          <a href="/builds">
            <span class="glyphicon glyphicon-book"></span>
            <span class="sidebar-title">Builds</span>
          </a>
        </li>
        <li>
          <a href="/changelog">
            <span class="fa fa-newspaper-o"></span>
            <span class="sidebar-title">Changelog</span>
          </a>
        </li>

        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-heart  "></span>
            <span class="sidebar-title">Guides</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/guide/card">
                <span class="glyphicon glyphicon-credit-card"></span>Card List</a>
            </li>
            <li>
              <a href="/guide/zone">
                <span class="glyphicon glyphicon-warning-sign"></span>Disabled Zones</a>
            </li>
          </ul>
        </li>

        
        {*<li class="sidebar-label">Theme Tools</li>*}
        <li>
          <a class="accordion-toggle" href="#">
            <span class="fa fa-search"></span>
            <span class="sidebar-title">Lookup</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/lookup/">
                <span class="fa fa-map-marker"></span>Browse by Zone</a>
            </li>
            <li>
              <a href="/lookup/npc/">
                <span class="glyphicon glyphicon-knight"></span>Search by NPC</a>
            </li>
            <li>
              <a href="/lookup/item/">
                <span class="glyphicon glyphicon-apple"></span>Search by Item</a>
            </li>
          </ul>
        </li>

        <li>
          <a href="/donate/">
            <span class="fa fa-dollar"></span>
            <span class="sidebar-title">Donate</span>
          </a>
        </li>

{*
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-check"></span>
            <span class="sidebar-title">Admin Forms</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/r2/admin_forms-elements.html">
                <span class="glyphicon glyphicon-shopping-cart"></span> Admin Elements </a>
            </li>
            <li>
              <a href="/r2/admin_forms-widgets.html">
                <span class="glyphicon glyphicon-calendar"></span> Admin Widgets </a>
            </li>
            <li>
              <a href="/r2/admin_forms-layouts.html">
                <span class="fa fa-desktop"></span> Admin Layouts </a>
            </li>
            <li>
              <a href="/r2/admin_forms-wizard.html">
                <span class="fa fa-clipboard"></span> Admin Wizard </a>
            </li>
            <li>
              <a href="/r2/admin_forms-validation.html">
                <span class="glyphicon glyphicon-check"></span> Admin Validation </a>
            </li>
          </ul>
        </li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="fa fa-columns"></span>
            <span class="sidebar-title">Admin Layouts</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa fa-arrows-h"></span>
                Sidebars
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_sidebar-left-static.html">
                    Left Static </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-left-fixed.html">
                    Left Fixed </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-left-widgets.html">
                    Left Widgets </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-left-minified.html">
                    Left Minified </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-left-light.html">
                    Left White </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-right-static.html">
                    Right Static </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-right-fixed.html">
                    Right Fixed </a>
                </li>
                <li>
                  <a href="/r2/layout_sidebar-right-menu.html">
                    Right w/Menu </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-arrows-v"></span>
                Navbar
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_navbar-static.html">
                    Navbar Static </a>
                </li>
                <li>
                  <a href="/r2/layout_navbar-fixed.html">
                    Navbar Fixed </a>
                </li>
                <li>
                  <a href="/r2/layout_navbar-menus.html">
                    Navbar Menus </a>
                </li>
                <li>
                  <a href="/r2/layout_navbar-contextual.html">
                    Contextual Example </a>
                </li>
                <li>
                  <a href="/r2/layout_navbar-search-alt.html">
                    Search Alt Style </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-hand-o-up"></span>
                Topbar
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_topbar.html">
                    Default Style </a>
                </li>
                <li>
                  <a href="/r2/layout_topbar-menu.html">
                    Default w/Menu </a>
                </li>
                <li>
                  <a href="/r2/layout_topbar-alt.html">
                    Alternate Style </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-arrows-v"></span>
                Content Body
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_content-blank.html">
                    Blank Starter </a>
                </li>
                <li>
                  <a href="/r2/layout_content-fixed.html">
                    Fixed Window </a>
                </li>
                <li>
                  <a href="/r2/layout_content-heading.html">
                    Content Heading </a>
                </li>
                <li>
                  <a href="/r2/layout_content-tabs.html">
                    Content Tabs </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-pause"></span>
                Content Trays
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_tray-left.html">
                    Tray Left Static </a>
                </li>
                <li>
                  <a href="/r2/layout_tray-left-fixed.html">
                    Tray Left Fixed </a>
                </li>
                <li>
                  <a href="/r2/layout_tray-right.html">
                    Tray Right Static </a>
                </li>
                <li>
                  <a href="/r2/layout_tray-right-fixed.html">
                    Tray Right Fixed </a>
                </li>
                <li>
                  <a href="/r2/layout_tray-both.html">
                    Left + Right Static </a>
                </li>
                <li>
                  <a href="/r2/layout_tray-both-fixed.html">
                    Left + Right Fixed </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-plus-square-o"></span>
                Boxed Layout
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_boxed.html">
                    Default </a>
                </li>
                <li>
                  <a href="/r2/layout_boxed-horizontal.html">
                    Horizontal Menu </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-arrow-circle-o-up"></span>
                Horizontal Menu
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/layout_horizontal-sm.html">
                    Small Size</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-md.html">
                    Medium Size</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-lg.html">
                    Large Size</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-light.html">
                    Light Skin</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-topbar.html">
                    With Topbar</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-topbar-alt.html">
                    With Alt Topbar</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-collapsed.html">
                    Collapsed onLoad</a>
                </li>
                <li>
                  <a href="/r2/layout_horizontal-boxed.html">
                    In Boxed Layout</a>
                </li>
              </ul>
            </li>
          </ul>
        </li>

        <li class="sidebar-label">Systems</li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="fa fa-diamond"></span>
            <span class="sidebar-title">Information Panels</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/r2/widgets_tile.html">
                <span class="fa fa-cube"></span> Tile Widgets</a>
            </li>
            <li>
              <a href="/r2/widgets_panel.html">
                <span class="fa fa-desktop"></span> Panel Widgets </a>
            </li>
            <li>
              <a href="/r2/widgets_scroller.html">
                <span class="fa fa-columns"></span> Scroller Widgets </a>
            </li>
            <li>
              <a href="/r2/widgets_data.html">
                <span class="fa fa-dot-circle-o"></span> Admin Widgets </a>
            </li>
          </ul>
        </li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-shopping-cart"></span>
            <span class="sidebar-title">Ecommerce</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li class="active">
              <a href="/r2/ecommerce_dashboard.html">
                <span class="glyphicon glyphicon-shopping-cart"></span> Dashboard
                <span class="label label-xs bg-primary">New</span>
              </a>
            </li>
            <li>
              <a href="/r2/ecommerce_products.html">
                <span class="glyphicon glyphicon-tags"></span> Products </a>
            </li>
            <li>
              <a href="/r2/ecommerce_orders.html">
                <span class="fa fa-money"></span> Orders </a>
            </li>
            <li>
              <a href="/r2/ecommerce_customers.html">
                <span class="fa fa-users"></span> Customers </a>
            </li>
            <li>
              <a href="/r2/ecommerce_settings.html">
                <span class="fa fa-gears"></span> Store Settings </a>
            </li>
          </ul>
        </li>

        <!-- sidebar resources -->
        <li class="sidebar-label">Elements</li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-bell"></span>
            <span class="sidebar-title">UI Elements</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/r2/ui_alerts.html">
                <span class="fa fa-warning"></span> Alerts </a>
            </li>
            <li>
              <a href="/r2/ui_animations.html">
                <span class="fa fa-spinner"></span> Animations </a>
            </li>
            <li>
              <a href="/r2/ui_buttons.html">
                <span class="fa fa-plus-square-o"></span> Buttons </a>
            </li>
            <li>
              <a href="/r2/ui_typography.html">
                <span class="fa fa-text-width"></span> Typography </a>
            </li>
            <li>
              <a href="/r2/ui_portlets.html">
                <span class="fa fa-archive"></span> Portlets </a>
            </li>
            <li>
              <a href="/r2/ui_progress-bars.html">
                <span class="fa fa-bars"></span> Progress Bars </a>
            </li>
            <li>
              <a href="/r2/ui_tabs.html">
                <span class="fa fa-toggle-off"></span> Tabs </a>
            </li>
            <li>
              <a href="/r2/ui_icons.html">
                <span class="fa fa-hand-o-right"></span> Icons </a>
            </li>
            <li>
              <a href="/r2/ui_grid.html">
                <span class="fa fa-th-large"></span> Grid </a>
            </li>
          </ul>
        </li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-hdd"></span>
            <span class="sidebar-title">Form Elements</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a href="/r2/form_inputs.html">
                <span class="fa fa-magic"></span> Basic Inputs </a>
            </li>
            <li>
              <a href="/r2/form_plugins.html">
                <span class="fa fa-bell-o"></span> Plugin Inputs
                <span class="label label-xs bg-primary">New</span>
              </a>
            </li>
            <li>
              <a href="/r2/form_editors.html">
                <span class="fa fa-clipboard"></span> Editors </a>
            </li>
            <li>
              <a href="/r2/form_treeview.html">
                <span class="fa fa-tree"></span> Treeview </a>
            </li>
            <li>
              <a href="/r2/form_nestable.html">
                <span class="fa fa-tasks"></span> Nestable </a>
            </li>
            <li>
              <a href="/r2/form_image-tools.html">
                <span class="fa fa-cloud-upload"></span> Image Tools
                <span class="label label-xs bg-primary">New</span>
              </a>
            </li>
            <li>
              <a href="/r2/form_uploaders.html">
                <span class="fa fa-cloud-upload"></span> Uploaders </a>
            </li>
            <li>
              <a href="/r2/form_notifications.html">
                <span class="fa fa-bell-o"></span> Notifications </a>
            </li>
            <li>
              <a href="/r2/form_content-sliders.html">
                <span class="fa fa-exchange"></span> Content Sliders </a>
            </li>
          </ul>
        </li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-tower"></span>
            <span class="sidebar-title">Plugins</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a class="accordion-toggle" href="#">
                <span class="glyphicon glyphicon-globe"></span> Maps
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/maps_advanced.html">Admin Maps</a>
                </li>
                <li>
                  <a href="/r2/maps_basic.html">Basic Maps</a>
                </li>
                <li>
                  <a href="/r2/maps_vector.html">Vector Maps</a>
                </li>
                <li>
                  <a href="/r2/maps_full.html">Full Map</a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-area-chart"></span> Charts
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/charts_highcharts.html">Highcharts</a>
                </li>
                <li>
                  <a href="/r2/charts_d3.html">D3 Charts</a>
                </li>
                <li>
                  <a href="/r2/charts_flot.html">Flot Charts</a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-table"></span> Tables
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/tables_basic.html"> Basic Tables</a>
                </li>
                <li>
                  <a href="/r2/tables_datatables.html"> DataTables </a>
                </li>
                <li>
                  <a href="/r2/tables_datatables-editor.html"> Editable Tables </a>
                </li>
                <li>
                  <a href="/r2/tables_pricing.html"> Pricing Tables </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-flask"></span> Misc
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/misc_tour.html"> Site Tour</a>
                </li>
                <li>
                  <a href="/r2/misc_timeout.html"> Session Timeout</a>
                </li>
                <li>
                  <a href="/r2/misc_nprogress.html"> Page Progress Loader </a>
                </li>
              </ul>
            </li>
          </ul>
        </li>
        <li>
          <a class="accordion-toggle" href="#">
            <span class="glyphicon glyphicon-duplicate"></span>
            <span class="sidebar-title">Pages</span>
            <span class="caret"></span>
          </a>
          <ul class="nav sub-nav">
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-gears"></span> Utility
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">

                <li>
                  <a href="/r2/pages_confirmation.html" target="_blank"> Confirmation
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_login.html" target="_blank"> Login </a>
                </li>
                <li>
                  <a href="/r2/pages_login(alt).html" target="_blank"> Login Alt
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_register.html" target="_blank"> Register </a>
                </li>
                <li>
                  <a href="/r2/pages_register(alt).html" target="_blank"> Register Alt
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_screenlock.html" target="_blank"> Screenlock </a>
                </li>
                <li>
                  <a href="/r2/pages_screenlock(alt).html" target="_blank"> Screenlock Alt
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_forgotpw.html" target="_blank"> Forgot Password </a>
                </li>
                <li>
                  <a href="/r2/pages_forgotpw(alt).html" target="_blank"> Forgot Pass Alt
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_coming-soon.html" target="_blank"> Coming Soon
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_404.html"> 404 Error </a>
                </li>
                <li>
                  <a href="/r2/pages_500.html"> 500 Error </a>
                </li>
                <li>
                  <a href="/r2/pages_404(alt).html"> 404 Error Alt </a>
                </li>
                <li>
                  <a href="/r2/pages_500(alt).html"> 500 Error Alt </a>
                </li>
              </ul>
            </li>
            <li>
              <a class="accordion-toggle" href="#">
                <span class="fa fa-desktop"></span> Basic
                <span class="caret"></span>
              </a>
              <ul class="nav sub-nav">
                <li>
                  <a href="/r2/pages_search-results.html">Search Results
                    <span class="label label-xs bg-primary">New</span>
                  </a>
                </li>
                <li>
                  <a href="/r2/pages_profile.html"> Profile </a>
                </li>
                <li>
                  <a href="/r2/pages_timeline.html"> Timeline Split </a>
                </li>
                <li>
                  <a href="/r2/pages_timeline-single.html"> Timeline Single </a>
                </li>
                <li>
                  <a href="/r2/pages_faq.html"> FAQ Page </a>
                </li>
                <li>
                  <a href="/r2/pages_calendar.html"> Calendar </a>
                </li>
                <li>
                  <a href="/r2/pages_messages.html"> Messages </a>
                </li>
                <li>
                  <a href="/r2/pages_messages(alt).html"> Messages Alt </a>
                </li>
                <li>
                  <a href="/r2/pages_gallery.html"> Gallery </a>
                </li>
                <li>
                  <a href="/r2/pages_invoice.html"> Printable Invoice </a>
                </li>
              </ul>
            </li>
          </ul>
        </li>
        *}
        {*
        <!-- sidebar bullets -->
        <li class="sidebar-label">Projects</li>
        <li class="sidebar-proj">
          <a href="#projectOne">
            <span class="fa fa-dot-circle-o text-warning"></span>
            <span class="sidebar-title">Executive Meeting</span>
          </a>
        </li>
        <li class="sidebar-proj">
          <a href="#projectTwo">
            <span class="fa fa-dot-circle-o text-system"></span>
            <span class="sidebar-title">HelpDisk Redesign</span>
          </a>
        </li>
        <li class="sidebar-proj">
          <a href="#projectTwo">
            <span class="fa fa-dot-circle-o text-info"></span>
            <span class="sidebar-title">Sony Board Meeting</span>
          </a>
        </li>
        <li class="sidebar-proj">
          <a href="#projectThree">
            <span class="fa fa-dot-circle-o text-primary"></span>
            <span class="sidebar-title">Apple Tech Conference</span>
          </a>
        </li>

        <!-- sidebar progress bars -->
        <li class="sidebar-label pb10">User Stats</li>
        <li class="sidebar-stat">
          <a href="#projectOne" class="">
            <span class="fa fa-inbox"></span>
            <span class="sidebar-title text-muted">Bandwidth</span>
            <span class="pull-right mr20 text-muted">35%</span>
            <div class="progress progress-bar-xs mh20 mb10">
              <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="45" aria-valuemin="0"
                   aria-valuemax="100" style="width: 35%">
                <span class="sr-only">35% Complete</span>
              </div>
            </div>
          </a>
        </li>
        <li class="sidebar-stat">
          <a href="#projectOne" class="">
            <span class="fa fa-dropbox"></span>
            <span class="sidebar-title text-muted">Cloud Storage</span>
            <span class="pull-right mr20 text-muted">62%</span>
            <div class="progress progress-bar-xs mh20">
              <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="62" aria-valuemin="0"
                   aria-valuemax="100" style="width: 62%">
                <span class="sr-only">62% Complete</span>
              </div>
            </div>
          </a>
        </li>
      </ul>
      <!-- End: Sidebar Menu -->
*}
      {*
      <!-- Start: Sidebar Collapse Button -->
      <div class="sidebar-toggle-mini">
        <a href="#">
          <span class="fa fa-sign-out"></span>
        </a>
      </div>
      <!-- End: Sidebar Collapse Button -->
      *}
    </div>
    <!-- End: Sidebar Left Content -->

  </aside>
  <!-- End: Sidebar Left -->

  <!-- Start: Content-Wrapper -->
  <section id="content_wrapper">

    <!-- Start: Topbar-Dropdown -->
    <div id="topbar-dropmenu" class="alt">
      <div class="topbar-menu row">
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-primary light">
            <span class="glyphicon glyphicon-inbox text-muted"></span>
            <span class="metro-title">Messages</span>
          </a>
        </div>
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-info light">
            <span class="glyphicon glyphicon-user text-muted"></span>
            <span class="metro-title">Users</span>
          </a>
        </div>
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-success light">
            <span class="glyphicon glyphicon-headphones text-muted"></span>
            <span class="metro-title">Support</span>
          </a>
        </div>
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-system light">
            <span class="glyphicon glyphicon-facetime-video text-muted"></span>
            <span class="metro-title">Videos</span>
          </a>
        </div>
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-warning light">
            <span class="fa fa-gears text-muted"></span>
            <span class="metro-title">Settings</span>
          </a>
        </div>
        <div class="col-xs-4 col-sm-2">
          <a href="#" class="metro-tile bg-alert light">
            <span class="glyphicon glyphicon-picture text-muted"></span>
            <span class="metro-title">Pictures</span>
          </a>
        </div>
      </div>
    </div>
    <!-- End: Topbar-Dropdown -->

    <!-- Start: Topbar -->
    <header id="topbar" class="alt">
      <div class="topbar-left">
        <ol class="breadcrumb">
          <li class="crumb-icon">
            <a href="/">
              <span class="glyphicon glyphicon-home"></span>
            </a>
          </li>
          {if !empty($crumbs)}
          {foreach from=$crumbs item=crumb}

          <li class="crumb-{if !empty($crumb->isActive) && $crumb->isActive}active{else}trail{/if}">
          {if !empty($crumb->link)}<a href="{$crumb->link}">{/if}
            {$crumb->name}
          {if !empty($crumb->link)}</a>{/if}
          </li> 
          {/foreach}
          {/if}
        </ol>
      </div>
      <div class="topbar-right">
        
        
      {*
        <div class="ib topbar-dropdown">
          <label for="topbar-multiple" class="control-label fs16">Reporting Period:</label>
          <select id="topbar-multiple" class="hidden">
            <optgroup label="Filter By:">
              <option value="1-1">Last 30 Days</option>
              <option value="1-2" selected="selected">Last 60 Days</option>
              <option value="1-3">Last Year</option>
            </optgroup>
          </select>
        </div>
        *}
        <div class="ml30 ib va-m" id="toggle_sidemenu_r">
          <a href="/" class="pl5">
          </a>
          {*
          <a href="#" class="pl5">
            <i class="fa fa-align-right fs17"></i>
          </a>
          *}
        </div>
      </div>
    </header>
    <!-- End: Topbar -->

    <!-- Begin: Content -->
    {$content}
    <!-- End: Content -->


  </section>
  <!-- End: Content-Wrapper -->

  <!-- Start: Right Sidebar -->
  <aside id="sidebar_right" class="nano affix">

    <!-- Start: Sidebar Right Content -->
    <div class="sidebar-right-content nano-content">

      <div class="tab-block sidebar-block br-n">
        <ul class="nav nav-tabs tabs-border nav-justified hidden">
          <li class="active">
            <a href="#sidebar-right-tab1" data-toggle="tab">Tab 1</a>
          </li>
          <li>
            <a href="#sidebar-right-tab2" data-toggle="tab">Tab 2</a>
          </li>
          <li>
            <a href="#sidebar-right-tab3" data-toggle="tab">Tab 3</a>
          </li>
        </ul>
        <div class="tab-content br-n">
          <div id="sidebar-right-tab1" class="tab-pane active">

            <h5 class="title-divider text-muted mb20"> Server Statistics
                <span class="pull-right"> 2013
                  <i class="fa fa-caret-down ml5"></i>
                </span>
            </h5>
            <div class="progress mh5">
              <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 44%">
                <span class="fs11">DB Request</span>
              </div>
            </div>
            <div class="progress mh5">
              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 84%">
                <span class="fs11 text-left">Server Load</span>
              </div>
            </div>
            <div class="progress mh5">
              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 61%">
                <span class="fs11 text-left">Server Connections</span>
              </div>
            </div>

            <h5 class="title-divider text-muted mt30 mb10">Traffic Margins</h5>
            <div class="row">
              <div class="col-xs-5">
                <h3 class="text-primary mn pl5">132</h3>
              </div>
              <div class="col-xs-7 text-right">
                <h3 class="text-success-dark mn">
                  <i class="fa fa-caret-up"></i> 13.2% </h3>
              </div>
            </div>

            <h5 class="title-divider text-muted mt25 mb10">Database Request</h5>
            <div class="row">
              <div class="col-xs-5">
                <h3 class="text-primary mn pl5">212</h3>
              </div>
              <div class="col-xs-7 text-right">
                <h3 class="text-success-dark mn">
                  <i class="fa fa-caret-up"></i> 25.6% </h3>
              </div>
            </div>

            <h5 class="title-divider text-muted mt25 mb10">Server Response</h5>
            <div class="row">
              <div class="col-xs-5">
                <h3 class="text-primary mn pl5">82.5</h3>
              </div>
              <div class="col-xs-7 text-right">
                <h3 class="text-danger mn">
                  <i class="fa fa-caret-down"></i> 17.9% </h3>
              </div>
            </div>

            <h5 class="title-divider text-muted mt40 mb20"> Server Statistics
              <span class="pull-right text-primary fw700">USA</span>
            </h5>


          </div>
          <div id="sidebar-right-tab2" class="tab-pane"></div>
          <div id="sidebar-right-tab3" class="tab-pane"></div>
        </div>
        <!-- end: .tab-content -->
      </div>
    </div>
  </aside>
  <!-- End: Right Sidebar -->

</div>
<!-- End: Main -->

{if !empty($showFooter) AND $showFooter}
 <footer id="content-footer" class="affix">
      <div class="row">
        <div class="col-xs-6">
          <span class="footer-legal">
                <a class="btn btn-sm btn-primary signup" href="/chat" role="button">Join Now!</a></span>
        </div>
        <div class="col-xs-6 text-right">
       
          <span class="footer-meta">by Shin Noir</span>
          <a href="#" class="footer-return-top">
            <span class="fa fa-chevron-up"></span>
          </a>
        </div>
      </div>
    </footer>
{/if}



<!--- Widgets -->

<div class="item_tooltip" class="panel" style="display: none; position: fixed;">  
  <div class="panel-body">
  <span style="vertical-align:middle;width:50px"> <span class="item_icon" style="width:40px;height:auto;"></span></span>
  <span class="item_name" class="panel-title">Cloth Shirt</span>
  {include file="./_item_stats.tpl"}
  </div>
</div>


<!--- End Widgets -->


<!-- BEGIN: PAGE SCRIPTS -->


<script src="/r2/vendor/jquery/jquery_ui/jquery-ui.min.js"></script>

<!-- HighCharts Plugin -->
<script src="/r2/vendor/plugins/highcharts/highcharts.js"></script>

<!-- Simple Circles Plugin -->
<script src="/r2/vendor/plugins/circles/circles.js"></script>

<!-- JvectorMap Plugin + US Map (more maps in plugin/assets folder) -->
<script src="/r2/vendor/plugins/jvectormap/jquery.jvectormap.min.js"></script>
<script src="/r2/vendor/plugins/jvectormap/assets/jquery-jvectormap-us-lcc-en.js"></script>

<!-- Bootstrap Tabdrop Plugin -->
<script src="/r2/vendor/plugins/tabdrop/bootstrap-tabdrop.js"></script>

<!-- Charts JS -->
<!--<script src="/r2/vendor/plugins/highcharts/highcharts.js"></script>-->
<!--<script src="/r2/vendor/plugins/circles/circles.js"></script>-->

<script src="/r2/vendor/plugins/footable/js/footable.all.min.js"></script>

<!-- FullCalendar Plugin + moment Dependency -->
<script src="/r2/vendor/plugins/fullcalendar/lib/moment.min.js"></script>
<script src="/r2/vendor/plugins/fullcalendar/fullcalendar.min.js"></script>

<!-- Theme Javascript -->
<script src="/r2/assets/js/utility/utility.js"></script>
<script src="/r2/assets/js/demo/demo.js"></script>
<script src="/r2/assets/js/main.js"></script>

 <script type="text/javascript">
  jQuery(document).ready(function() {

    "use strict";


    // Init FooTable Examples
    //$('.footable').footable();


  });

  $(document).on("mouseenter", "a", function(e){    
    showItemTooltip($(this))
  });

  $(document).on("mouseleave", "a", function(){
     var tooltip = $(this).attr("itemtooltip");
      if (!tooltip) return;
      hideItemTooltip();
  });

  var lastItemId = 0;
  function showItemTooltip(e) {
    var id = $(e).attr("itemtooltip");
    if (!id) return;

    if (lastItemId == id) { //don't need to call twice if it's previously requested
      $('.item_tooltip').show();
      $('.item_tooltip').css({ left: e.offset().left + 120, top: e.offset().top - 250});
    }

    $.ajax({
      type: "POST",
      url: "/rest/lookup/item",
      data: "item_id="+id,
      success: function (data) {
        var rest = jQuery.parseJSON(data);
        if (rest.Status != 1) {
          console.log("return != 1, aborting showItemTooltip");
          return;
        }

        //console.log(rest);
        console.log(rest.Data.class);
        $('.item_icon').attr("class", "item_icon image-icon icon-"+rest.Data.icon);
        $('.item_name').html(rest.Data.Name);
        $('.item_class').html(rest.Data.classesString);
        $('.item_race').html(rest.Data.racesString);
        $('.item_platinum').html(rest.Data.price % 1000);
        $('.item_gold').html(rest.Data.price % 100);
        $('.item_silver').html(rest.Data.price % 10);
        $('.item_copper').html(rest.Data.price % 1);
        $('.item_tooltip').show();
        $('.item_tooltip').css({ left: e.offset().left + 120, top: e.offset().top - 250});
      },
      error: function() {
        console.log("Error requesting!?");
      }
    });


   
  }

  function hideItemTooltip() {
    $('.item_tooltip').hide();
  }
  </script>
</body>
</html>
