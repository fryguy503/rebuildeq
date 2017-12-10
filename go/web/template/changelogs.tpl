{{template "header" .}}

{{template "navigation" .}}

<!-- Main Wrapper -->
<div id="wrapper">


    <div class="normalheader small-header">
        <div class="hpanel">
            <div class="panel-body">
                
                <div id="hbreadcrumb" class="pull-right m-t-lg">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="/dashboard">Dashboard</a></li>                        
                        <li class="active">
                            <span>Changelog</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    Changelog
                </h2>
                <small>Patch notes</small>
            </div>
        </div>
    </div>

<div class="content">



<div class="row" >
<div class="col-lg-12">
<!--
<div class="hpanel">
    <div class="panel-body">
        <div class="text-muted small pull-right text-right">
            Proin eu tempus tortor, vitae bibendum est. Nam placerat hendrerit rhoncus<br/>
            Last modyfication by: <span class="font-bold">Mike Smith</span>
            21.03.2015, 06:45 pm
        </div>
        <div class="form-inline">
            Search topic: <input class="form-control" type="text">
        </div>

    </div>

</div>
-->

<div class="hpanel forum-box">

    <div class="panel-heading  hbuilt">
                <span class="pull-right">
                    <i class="fa fa-clock-o"> </i> Last modification: 10.12.2015, 10:22 am
                </span>
        Ordered By Date Descending
    </div>

    {{range $key, $value := .Changelogs}}
    <div class="panel-body">
        <div class="row">
            <div class="col-md-1">
                <a href="/changelog/{{$value.Id}}"><img class="img-fluid img-thumbnail float-left" src="{{$value.Image}}"></a>
            </div>
            <div class="col-md-8 forum-heading">
                <a href="/changelog/{{$value.Id}}"><h4>{{$value.Title}}</h4></a>
                <div class="desc">{{ printf "%.125s" $value.Body }}</div>
            </div>
            <div class="col-md-3 forum-info">
                <span class="number">{{$value.Date}}</span>
            </div>
        </div>
    </div>
    {{end}}

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
                            <img src="images/a1.jpg" alt="profile-picture">
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
                            <img src="images/a3.jpg" alt="profile-picture">
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
                            <img src="images/a4.jpg" alt="profile-picture">
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
