{{template "header" .}}

{{template "navigation" .}}


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
                    {{range $key, $value := .Characters}}
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