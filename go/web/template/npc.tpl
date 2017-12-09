
<!-- Simple splash screen-->
<div class="splash"> <div class="color-line"></div><div class="splash-title"><h1>Homer - Responsive Admin Theme</h1><p>Special Admin Theme for small and medium webapp with very clean and aesthetic style and feel. </p><div class="spinner"> <div class="rect1"></div> <div class="rect2"></div> <div class="rect3"></div> <div class="rect4"></div> <div class="rect5"></div> </div> </div> </div>
<!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="/http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
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
            <a href="/index.html">
                <img src="/images/profile.jpg" class="img-circle m-b" alt="logo">
            </a>

            <div class="stats-label text-color">
                <span class="font-extra-bold font-uppercase">Robert Razer</span>

                <div class="dropdown">
                    <a class="dropdown-toggle" href="/profile.html#" data-toggle="dropdown">
                        <small class="text-muted">Founder of App <b class="caret"></b></small>
                    </a>
                    <ul class="dropdown-menu animated flipInX m-t-xs">
                        <li><a href="/contacts.html">Contacts</a></li>
                        <li><a href="/profile.html">Profile</a></li>
                        <li><a href="/analytics.html">Analytics</a></li>
                        <li class="divider"></li>
                        <li><a href="/login.html">Logout</a></li>
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
                <a href="/index.html"> <span class="nav-label">Dashboard</span> <span class="label label-success pull-right">v.1</span> </a>
            </li>
            <li>
                <a href="/analytics.html"> <span class="nav-label">Analytics</span><span class="label label-warning pull-right">NEW</span> </a>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Interface</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/panels.html">Panels design</a></li>
                    <li><a href="/typography.html">Typography</a></li>
                    <li><a href="/buttons.html">Colors &amp; Buttons</a></li>
                    <li><a href="/components.html">Components</a></li>
                    <li><a href="/alerts.html">Alerts</a></li>
                    <li><a href="/modals.html">Modals</a></li>
                    <li><a href="/loading_buttons.html">Loading buttons</a></li>
                    <li><a href="/draggable.html">Draggable panels</a></li>
                    <li><a href="/code_editor.html">Code editor</a></li>
                    <li><a href="/email_template.html">Email template</a></li>
                    <li><a href="/nestable_list.html">List</a></li>
                    <li><a href="/tour.html">Tour</a></li>
                    <li><a href="/icons.html">Icons library</a></li>
                </ul>
            </li>
            <li class="active">
                <a href="/profile.html#"><span class="nav-label">App views</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/contacts.html">Contacts</a></li>
                    <li><a href="/projects.html">Projects</a></li>
                    <li><a href="/project.html">Project detail</a></li>
                    <li><a href="/app_plans.html">App plans</a></li>
                    <li><a href="/social_board.html">Social board</a></li>
                    <li><a href="/faq.html">FAQ</a></li>
                    <li><a href="/timeline.html">Timeline</a></li>
                    <li><a href="/notes.html">Notes</a></li>
                    <li class="active"><a href="/profile.html">Profile</a></li>
                    <li><a href="/mailbox.html">Mailbox</a></li>
                    <li><a href="/mailbox_compose.html">Email compose</a></li>
                    <li><a href="/mailbox_view.html">Email view</a></li>
                    <li><a href="/blog.html">Blog</a></li>
                    <li><a href="/blog_details.html">Blog article</a></li>
                    <li><a href="/forum.html">Forum</a></li>
                    <li><a href="/forum_details.html">Forum details</a></li>
                    <li><a href="/gallery.html">Gallery</a></li>
                    <li><a href="/calendar.html">Calendar</a></li>
                    <li><a href="/invoice.html">Invoice</a></li>
                    <li><a href="/file_manager.html">File manager</a></li>
                    <li><a href="/chat_view.html">Chat view</a></li>
                    <li><a href="/search.html">Search view</a></li>
                </ul>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Charts</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/chartjs.html">ChartJs</a></li>
                    <li><a href="/flot.html">Flot charts</a></li>
                    <li><a href="/inline.html">Inline graphs</a></li>
                    <li><a href="/chartist.html">Chartist</a></li>
                    <li><a href="/c3.html">C3 Charts</a></li>
                </ul>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Box transitions</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/overview.html"><span class="label label-success pull-right">Start</span> Overview </a>  </li>
                    <li><a href="/transition_two.html">Columns from up</a></li>
                    <li><a href="/transition_one.html">Columns custom</a></li>
                    <li><a href="/transition_three.html">Panels zoom</a></li>
                    <li><a href="/transition_four.html">Rows from down</a></li>
                    <li><a href="/transition_five.html">Rows from right</a></li>
                </ul>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Common views</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/login.html">Login</a></li>
                    <li><a href="/register.html">Register</a></li>
                    <li><a href="/error_one.html">Error 404</a></li>
                    <li><a href="/error_two.html">Error 505</a></li>
                    <li><a href="/lock.html">Lock screen</a></li>
                    <li><a href="/password_recovery.html">Passwor recovery</a></li>
                </ul>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Tables</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/tables_design.html">Tables design</a></li>
                    <li><a href="/datatables.html">Data tables</a></li>
                    <li><a href="/footable.html">Foo Table</a></li>

                </ul>
            </li>
            <li>
                <a href="/widgets.html"> <span class="nav-label">Widgets</span> <span class="label label-success pull-right">Special</span></a>
            </li>
            <li>
                <a href="/profile.html#"><span class="nav-label">Forms</span><span class="fa arrow"></span> </a>
                <ul class="nav nav-second-level">
                    <li><a href="/forms_elements.html">Forms elements</a></li>
                    <li><a href="/forms_extended.html">Forms extended</a></li>
                    <li><a href="/text_editor.html">Text editor</a></li>
                    <li><a href="/wizard.html">Wizard</a></li>
                    <li><a href="/validation.html">Validation</a></li>
                </ul>
            </li>
            <li>
                <a href="/options.html"> <span class="nav-label">Layout options</span></a>
            </li>
            <li>
                <a href="/grid_system.html"> <span class="nav-label">Grid system</span></a>
            </li>
            <li>
                <a href="/landing_page.html"> <span class="nav-label">Landing page</span></a>
            </li>
            <li>
                <a href="/package.html"> <span class="nav-label">Package</span></a>
            </li>

        </ul>
    </div>
</aside>

<!-- Main Wrapper -->
<div id="wrapper">

<div class="normalheader ">
    <div class="hpanel">
        <div class="panel-body">
            <a class="small-header-action" href="/profile.html">
                <div class="clip-header">
                    <i class="fa fa-arrow-up"></i>
                </div>
            </a>

            <div id="hbreadcrumb" class="pull-right m-t-lg">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="/index.html">Dashboard</a></li>
                    <li>
                        <span>App views</span>
                    </li>
                    <li class="active">
                        <span>Profile </span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                Profile
            </h2>
            <small>Show user data in clear profile design</small>
        </div>
    </div>
</div>

<div class="content">

<div class="row">
    <div class="col-lg-4">
        <div class="hpanel hgreen">
            <div class="panel-body">
                <div class="pull-right text-right">
                    <div class="btn-group">
                        <i class="fa fa-facebook btn btn-default btn-xs"></i>
                        <i class="fa fa-twitter btn btn-default btn-xs"></i>
                        <i class="fa fa-linkedin btn btn-default btn-xs"></i>
                    </div>
                </div>
                <img alt="logo" class="img-circle m-b m-t-md" src="/images/profile.jpg">
                <h3><a href="/profile.html">{{.Npc.Name}}</a></h3>
                <div class="text-muted font-bold m-b-xs"></div>
                <p>
                    {{.Npc.Id}}
                </p>
                <div class="progress m-t-xs full progress-small">
                    <div style="width: 65%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="65" role="progressbar" class=" progress-bar progress-bar-success">
                        <span class="sr-only">35% Complete (success)</span>
                    </div>
                </div>
            </div>
            <div class="border-right border-left">
                <section id="map">
                    <div id="map1" style="height: 200px"></div>
                </section>
            </div>
            <div class="panel-body">
                <dl>
                    <dt>Description lists</dt>
                    <dd>A description list is perfect for defining terms.</dd>
                    <dt>Euismod</dt>
                    <dd>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
                    <dd>Donec id elit non mi porta gravida at eget metus.</dd>
                    <dt>Malesuada porta</dt>
                    <dd>Etiam porta sem malesuada magna mollis euismod.</dd>
                </dl>
            </div>
            <div class="panel-footer contact-footer">
                <div class="row">
                    <div class="col-md-4 border-right">
                        <div class="contact-stat"><span>Projects: </span> <strong>200</strong></div>
                    </div>
                    <div class="col-md-4 border-right">
                        <div class="contact-stat"><span>Messages: </span> <strong>300</strong></div>
                    </div>
                    <div class="col-md-4">
                        <div class="contact-stat"><span>Views: </span> <strong>400</strong></div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="col-lg-8">
        <div id="row">
            <div class="hpanel">
                <div class="panel-heading">
                    <div class="panel-tools">
                        <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                        <a class="closebox"><i class="fa fa-times"></i></a>
                    </div>
                    Spawn Location
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                    <table cellpadding="1" cellspacing="1" class="table">
                        <thead>
                        <tr>
                            <th>ZoneID</th>                        
                        </tr>
                        </thead>
                        <tbody>
                        {{range $key, $value := .Npc.SpawnsIn}}
                        <tr>
                            <td><a href="/zone/{{$value.ZoneId}}">{{$value.ZoneShortName}}</a></td>         
                        </tr>
                        {{end}}
                        </tbody>
                    </table>
                    </div>

                </div>
                <div class="panel-footer">
                    Total Count
                </div>
            </div>
            <div class="hpanel">
                <div class="panel-heading">
                    <div class="panel-tools">
                        <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                        <a class="closebox"><i class="fa fa-times"></i></a>
                    </div>
                   Items Dropped
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                    <table cellpadding="1" cellspacing="1" class="table">
                        <thead>
                        <tr>
                            <th>ItemId</th>
                            <th>Charges</th>
                        </tr>
                        </thead>
                        <tbody>
                        {{range $key, $value := .Npc.Drops.LootDrops}}
                        <tr>
                            <td><a href="/item/{{$value.ItemId}}">{{$value.ItemName}}</a></td>
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
    </div>
</div>

</div>
    <!-- Right sidebar -->
    <div id="right-sidebar" class="animated fadeInRight">

        <div class="p-m">
            <button id="sidebar-close" class="right-sidebar-toggle sidebar-button btn btn-default m-b-md"><i class="pe pe-7s-close"></i>
            </button>
            <div>
                <span class="font-bold no-margins"> Analytics </span>
                <br>
                <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.</small>
            </div>
            <div class="row m-t-sm m-b-sm">
                <div class="col-lg-6">
                    <h3 class="no-margins font-extra-bold text-success">300,102</h3>

                    <div class="font-bold">98% <i class="fa fa-level-up text-success"></i></div>
                </div>
                <div class="col-lg-6">
                    <h3 class="no-margins font-extra-bold text-success">280,200</h3>

                    <div class="font-bold">98% <i class="fa fa-level-up text-success"></i></div>
                </div>
            </div>
            <div class="progress m-t-xs full progress-small">
                <div style="width: 25%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="25" role="progressbar"
                     class=" progress-bar progress-bar-success">
                    <span class="sr-only">35% Complete (success)</span>
                </div>
            </div>
        </div>
        <div class="p-m bg-light border-bottom border-top">
            <span class="font-bold no-margins"> Social talks </span>
            <br>
            <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.</small>
            <div class="m-t-md">
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="/images/a1.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">John Novak</span>
                            <small class="text-muted">21.03.2015</small>
                            <div class="social-content small">
                                Injected humour, or randomised words which don't look even slightly believable.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="/images/a3.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">Mark Smith</span>
                            <small class="text-muted">14.04.2015</small>
                            <div class="social-content">
                                Many desktop publishing packages and web page editors.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="social-talk">
                    <div class="media social-profile clearfix">
                        <a class="pull-left">
                            <img src="/images/a4.jpg" alt="profile-picture">
                        </a>

                        <div class="media-body">
                            <span class="font-bold">Marica Morgan</span>
                            <small class="text-muted">21.03.2015</small>

                            <div class="social-content">
                                There are many variations of passages of Lorem Ipsum available, but the majority have
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="p-m">
            <span class="font-bold no-margins"> Sales in last week </span>
            <div class="m-t-xs">
                <div class="row">
                    <div class="col-xs-6">
                        <small>Today</small>
                        <h4 class="m-t-xs">$170,20 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                    <div class="col-xs-6">
                        <small>Last week</small>
                        <h4 class="m-t-xs">$580,90 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <small>Today</small>
                        <h4 class="m-t-xs">$620,20 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                    <div class="col-xs-6">
                        <small>Last week</small>
                        <h4 class="m-t-xs">$140,70 <i class="fa fa-level-up text-success"></i></h4>
                    </div>
                </div>
            </div>
            <small> Lorem Ipsum is simply dummy text of the printing simply all dummy text.
                Many desktop publishing packages and web page editors.
            </small>
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