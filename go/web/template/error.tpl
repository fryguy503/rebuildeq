{{template "header" .}}

{{template "navigation" .}}
<div class="color-line"></div>

<div class="back-link">
    <a href="/" class="btn btn-primary">Back to Dashboard</a>
</div>
<div class="error-container">
    <i class="pe-7s-way text-success big-icon"></i>
    <h1>{{.Site.Page}}</h1>
    <strong>Error while requesting {{.Url}}</strong>
    <p>
        {{.Site.Description}}
    </p>
    <a href="/" class="btn btn-xs btn-success">Go back to dashboard</a>
</div>