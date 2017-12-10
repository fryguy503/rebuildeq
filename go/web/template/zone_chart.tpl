{{template "header" .}}

{{template "navigation" .}}


<!-- Main Wrapper -->
<div id="wrapper">

<div class="normalheader small-header">
    <div class="hpanel">
        <div class="panel-body">           

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
                List of Zones
            </h2>
            <small>Examples of various designs of tables.</small>
        </div>
    </div>
</div>

<div class="content">

<div class="row">
    <div class="col-lg-12">
        <div class="hpanel">
            <div class="panel-heading  hbuilt">
                <div class="panel-tools">
                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                    <a class="closebox"><i class="fa fa-times"></i></a>
                </div>
                Zone Chart
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                <table cellpadding="1" cellspacing="1" class="table table-bordered table-striped">
                    <thead>
                    <tr class="text-center">
                        <th>Name</th>
                        <th>1</th>
                        <th>5</th>
                        <th>10</th>
                        <th>15</th>
                        <th>20</th>
                        <th>25</th>
                        <th>30</th>
                        <th>35</th>
                        <th>40</th>
                        <th>45</th>
                        <th>50</th>
                        <th>55</th>
                        <th>60</th>
                    </tr>
                    </thead>
                    <tbody>
                    {{range $key, $value := .Zones}}
                    <tr>
                        <td class="text-left"><a href="/zone/{{$value.Id}}">{{$value.Name}}</a></td>
                        <td>{{if iszonelevel 1 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 5 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 10 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 15 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 20 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 25 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 30 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 35 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 40 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 45 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 50 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 55 $value.Levels}}X{{end}}</td>
                        <td>{{if iszonelevel 60 $value.Levels}}X{{end}}</td>                        
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