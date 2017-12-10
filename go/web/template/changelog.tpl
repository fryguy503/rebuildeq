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
                        <li>
                            <a href="/changelogs"><span>Changelog</span></a>
                        </li>
                        <li class="active">
                            <span>{{.Changelog.Title}}</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    {{.Changelog.Title}}
                </h2>
                <small>Last modified: {{.Changelog.Date}}</small>
            </div>
        </div>
    </div>

<div class="content">



<div class="row" >
<div class="col-lg-12">

<div class="hpanel forum-box">


<div class="panel-body">
    
    <div class="media">
        <div class="media-body text-left">
            {{.Body}}
        </div>
    </div>
    <br/>
    <div class="text-center"><img src="{{.Changelog.Image}}"/></div>
</div>

</div>