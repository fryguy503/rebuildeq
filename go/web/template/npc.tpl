{{template "header" .}}

{{template "navigation" .}}

<!-- Main Wrapper -->
<div id="wrapper">

<div class="normalheader small-header">
    <div class="hpanel">
        <div class="panel-body">           

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
                    Spawns In
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
                   Drops
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                    <table cellpadding="1" cellspacing="1" class="table">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Charges</th>
                            <th>Chance</th>
                        </tr>
                        </thead>
                        <tbody>
                        {{range $key, $value := .Npc.Drops.LootDrops}}
                        <tr>
                            <td class="text-left"><a href="/item/{{$value.ItemId}}"><span class="item icon-{{$value.ItemIcon}}"></span></a>
                            <a href="/item/{{$value.ItemId}}">{{$value.ItemName}}</a></td>
                            <td><a href="/item/{{$value.ItemId}}">{{$value.ItemCharges}}</a></td>
                            <td><a href="/item/{{$value.ItemId}}">{{$value.Chance}}</a></td>
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

</div>