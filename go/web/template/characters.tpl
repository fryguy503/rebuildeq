
<!-- Simple splash screen-->
<div class="splash"> <div class="color-line"></div><div class="splash-title"><h1>Homer - Responsive Admin Theme</h1><p>Special Admin Theme for small and medium webapp with very clean and aesthetic style and feel. </p><div class="spinner"> <div class="rect1"></div> <div class="rect2"></div> <div class="rect3"></div> <div class="rect4"></div> <div class="rect5"></div> </div> </div> </div>
<!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->

<!-- Header -->
<div id="header">
    <div class="color-line">
    </div>
    <div id="logo" class="light-version">
        <span>
            Homer Theme
        </span>
    </div>
    {{template "navmenu" .}}
</div>

<!-- Navigation -->
<aside id="menu">
    <div id="navigation">
        <div class="profile-picture">
            <a href="index.html">
                <img src="images/profile.jpg" class="img-circle m-b" alt="logo">
            </a>

            <div class="stats-label text-color">
                <span class="font-extra-bold font-uppercase">Robert Razer</span>

                <div class="dropdown">
                    <a class="dropdown-toggle" href="tables_design.html#" data-toggle="dropdown">
                        <small class="text-muted">Founder of App <b class="caret"></b></small>
                    </a>
                    <ul class="dropdown-menu animated flipInX m-t-xs">
                        <li><a href="contacts.html">Contacts</a></li>
                        <li><a href="profile.html">Profile</a></li>
                        <li><a href="analytics.html">Analytics</a></li>
                        <li class="divider"></li>
                        <li><a href="login.html">Logout</a></li>
                    </ul>
                </div>


                <div id="sparkline1" class="small-chart m-t-sm"></div>
                <div>
                    <h4 class="font-extra-bold m-b-xs">
                        $260 104,200
                    </h4>
                    <small class="text-muted">Your income from the last year in sales product X.</small>
                </div>
            </div>
        </div>

        <ul class="nav" id="side-menu">
            <li>
                <a href="index.html"> <span class="nav-label">Dashboard</span> <span class="label label-success pull-right">v.1</span> </a>
            </li>
            <li>
                <a href="analytics.html"> <span class="nav-label">Analytics</span><span class="label label-warning pull-right">NEW</span> </a>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">Interface</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="panels.html">Panels design</a></li>
                    <li><a href="typography.html">Typography</a></li>
                    <li><a href="buttons.html">Colors &amp; Buttons</a></li>
                    <li><a href="components.html">Components</a></li>
                    <li><a href="alerts.html">Alerts</a></li>
                    <li><a href="modals.html">Modals</a></li>
                    <li><a href="loading_buttons.html">Loading buttons</a></li>
                    <li><a href="draggable.html">Draggable panels</a></li>
                    <li><a href="code_editor.html">Code editor</a></li>
                    <li><a href="email_template.html">Email template</a></li>
                    <li><a href="nestable_list.html">List</a></li>
                    <li><a href="tour.html">Tour</a></li>
                    <li><a href="icons.html">Icons library</a></li>
                </ul>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">App views</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="contacts.html">Contacts</a></li>
                    <li><a href="projects.html">Projects</a></li>
                    <li><a href="project.html">Project detail</a></li>
                    <li><a href="app_plans.html">App plans</a></li>
                    <li><a href="social_board.html">Social board</a></li>
                    <li><a href="faq.html">FAQ</a></li>
                    <li><a href="timeline.html">Timeline</a></li>
                    <li><a href="notes.html">Notes</a></li>
                    <li><a href="profile.html">Profile</a></li>
                    <li><a href="mailbox.html">Mailbox</a></li>
                    <li><a href="mailbox_compose.html">Email compose</a></li>
                    <li><a href="mailbox_view.html">Email view</a></li>
                    <li><a href="blog.html">Blog</a></li>
                    <li><a href="blog_details.html">Blog article</a></li>
                    <li><a href="forum.html">Forum</a></li>
                    <li><a href="forum_details.html">Forum details</a></li>
                    <li><a href="gallery.html">Gallery</a></li>
                    <li><a href="calendar.html">Calendar</a></li>
                    <li><a href="invoice.html">Invoice</a></li>
                    <li><a href="file_manager.html">File manager</a></li>
                    <li><a href="chat_view.html">Chat view</a></li>
                    <li><a href="search.html">Search view</a></li>
                </ul>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">Charts</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="chartjs.html">ChartJs</a></li>
                    <li><a href="flot.html">Flot charts</a></li>
                    <li><a href="inline.html">Inline graphs</a></li>
                    <li><a href="chartist.html">Chartist</a></li>
                    <li><a href="c3.html">C3 Charts</a></li>
                </ul>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">Box transitions</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="overview.html"><span class="label label-success pull-right">Start</span> Overview </a>  </li>
                    <li><a href="transition_two.html">Columns from up</a></li>
                    <li><a href="transition_one.html">Columns custom</a></li>
                    <li><a href="transition_three.html">Panels zoom</a></li>
                    <li><a href="transition_four.html">Rows from down</a></li>
                    <li><a href="transition_five.html">Rows from right</a></li>
                </ul>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">Common views</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="login.html">Login</a></li>
                    <li><a href="register.html">Register</a></li>
                    <li><a href="error_one.html">Error 404</a></li>
                    <li><a href="error_two.html">Error 505</a></li>
                    <li><a href="lock.html">Lock screen</a></li>
                    <li><a href="password_recovery.html">Passwor recovery</a></li>
                </ul>
            </li>
            <li class="active">
                <a href="tables_design.html#"><span class="nav-label">Tables</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li class="active"><a href="tables_design.html">Tables design</a></li>
                    <li><a href="datatables.html">Data tables</a></li>
                    <li><a href="footable.html">Foo Table</a></li>

                </ul>
            </li>
            <li>
                <a href="widgets.html"> <span class="nav-label">Widgets</span> <span class="label label-success pull-right">Special</span></a>
            </li>
            <li>
                <a href="tables_design.html#"><span class="nav-label">Forms</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="forms_elements.html">Forms elements</a></li>
                    <li><a href="forms_extended.html">Forms extended</a></li>
                    <li><a href="text_editor.html">Text editor</a></li>
                    <li><a href="wizard.html">Wizard</a></li>
                    <li><a href="validation.html">Validation</a></li>
                </ul>
            </li>
            <li>
                <a href="options.html"> <span class="nav-label">Layout options</span></a>
            </li>
            <li>
                <a href="grid_system.html"> <span class="nav-label">Grid system</span></a>
            </li>
            <li>
                <a href="landing_page.html"> <span class="nav-label">Landing page</span></a>
            </li>
            <li>
                <a href="package.html"> <span class="nav-label">Package</span></a>
            </li>

        </ul>
    </div>
</aside>

<!-- Main Wrapper -->
<div id="wrapper">

<div class="normalheader ">
    <div class="hpanel">
        <div class="panel-body">
            <a class="small-header-action" href="tables_design.html">
                <div class="clip-header">
                    <i class="fa fa-arrow-up"></i>
                </div>
            </a>

            <div id="hbreadcrumb" class="pull-right m-t-lg">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="index.html">Dashboard</a></li>
                    <li>
                        <span>Tables</span>
                    </li>
                    <li class="active">
                        <span>Tables design</span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                Tables design
            </h2>
            <small>Examples of various designs of tables.</small>
        </div>
    </div>
</div>

<div class="content">

<div class="row">
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="panel-heading">
                <div class="panel-tools">
                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                    <a class="closebox"><i class="fa fa-times"></i></a>
                </div>
                This is a basic table design
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                <table cellpadding="1" cellspacing="1" class="table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>CharacterID</th>
                        <th>ZoneID</th>                        
                    </tr>
                    </thead>
                    <tbody>
                    {{range $key, $value := .}}
                    <tr>
                        
                        <td><a href="/character/{{$value.Id}}">{{$value.Name}}</a></td>
                        <td>{{$value.Id}}</td>
                        <td><a href="/zone/{{$value.Zoneid}}">{{$value.Zoneid}}</a></td>         
                    </tr>
                    {{end}}                
                    </tbody>
                </table>
                </div>

            </div>
            <div class="panel-footer">
                Table - 6 rows
            </div>
        </div>
    </div>
</div>
    <!-- Footer-->
    <footer class="footer">
        <span class="pull-right">
            Example text
        </span>
        Company 2015-2020
    </footer>

</div>