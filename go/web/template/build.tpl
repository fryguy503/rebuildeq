{{template "header" .}}

{{template "navigation" .}}

<!-- Main Wrapper -->
<div id="wrapper">

<div class="normalheader ">
    <div class="hpanel">
        <div class="panel-body">
            <a class="small-header-action" href="components.html">
                <div class="clip-header">
                    <i class="fa fa-arrow-up"></i>
                </div>
            </a>

            <div id="hbreadcrumb" class="pull-right m-t-lg">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="index.html">Dashboard</a></li>
                    <li>
                        <span>Interface</span>
                    </li>
                    <li class="active">
                        <span>Components</span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                Components
            </h2>
            <div class="row">
                <div class="form-group">
                    <a href="/build/bard"><img class="classicon {if $class eq 'bard'}classicon-active{/if}" src="/images/classicons/brd.png"/></a>
                    <a href="/build/cleric"><img class="classicon {if $class eq 'cleric'}classicon-active{/if}" src="/images/classicons/clr.png"/></a>
                    <a href="/build/druid"><img class="classicon {if $class eq 'druid'}classicon-active{/if}" src="/images/classicons/dru.png"/></a>
                    <a href="/build/enchanter"><img class="classicon {if $class eq 'enchanter'}classicon-active{/if}" src="/images/classicons/enc.png"/></a>
                    <a href="/build/magician"><img class="classicon {if $class eq 'magician'}classicon-active{/if}" src="/images/classicons/mag.png"/></a>
                    <a href="/build/monk"><img class="classicon {if $class eq 'monk'}classicon-active{/if}" src="/images/classicons/mnk.png"/></a>
                    <a href="/build/necromancer"><img class="classicon {if $class eq 'necromancer'}classicon-active{/if}" src="/images/classicons/nec.png"/></a>
                    <a href="/build/paladin"><img class="classicon {if $class eq 'paladin'}classicon-active{/if}" src="/images/classicons/pal.png"/></a>
                    <a href="/build/ranger"><img class="classicon {if $class eq 'ranger'}classicon-active{/if}" src="/images/classicons/rng.png"/></a>
                    <a href="/build/rogue"><img class="classicon {if $class eq 'rogue'}classicon-active{/if}" src="/images/classicons/rog.png"/></a>
                    <a href="/build/shadowknight"><img class="classicon {if $class eq 'shadowknight'}classicon-active{/if}" src="/images/classicons/shd.png"/></a>
                    <a href="/build/shaman"><img class="classicon {if $class eq 'shaman'}classicon-active{/if}" src="/images/classicons/shm.png"/></a>
                    <a href="/build/warrior"><img class="classicon {if $class eq 'warrior'}classicon-active{/if}" src="/images/classicons/war.png"/></a>
                    <a href="/build/wizard"><img class="classicon {if $class eq 'wizard'}classicon-active{/if}" src="/images/classicons/wiz.png"/></a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="content">

<div class="row">
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="panel-heading hbuilt">
                <div class="panel-tools">
                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                    <a class="closebox"><i class="fa fa-times"></i></a>
                </div>
            </div>
            <div class="panel-body">
                <div class="text-center m-b-md">
                    <h3>{{if .Character}}{{.Character.Name}}{{else}}{{.Info.FullName}}{{end}}</h3>
                    <small>{{.Info.Description}}</small><br/>
                </div>
                {{range $key, $value := .Skills}}                    
                    {{if $value.Title}}
                    {{$key}} {{$value.Title}}<br>
                    {{else}}
                    {{$key}} N/A<br>
                    {{end}}
                {{end}}

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
