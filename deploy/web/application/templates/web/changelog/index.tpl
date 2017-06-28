
<div class="col-sm-12 col-md-11 center-column mt25">
{foreach from=$entries item=entry}
  <div class="row">
    <div class="col-md-8">
      <div class="panel">
          <div class="panel-heading">
             <a href="/changelog/entry/{$entry->title|replace:" ":"-"}"><span class="panel-icon {$entry->icon}"></span>
             <span class="panel-title">{$entry->title}</span></a>
             <div class="panel-header-menu pull-right mr10 text-muted fs12"> {$entry->date|date_format:"%Y-%m-%d"} </div>
          </div>
          <div class="panel-body">
            <p class="">
              {$entry->body|nl2br}
            </p>
          </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel">
        <div class="panel-heading">
        <span class="panel-icon {$entry->icon}"></span>
             <span class="panel-title">{$entry->image_caption}</span>
          </div> 
          <div class="panel-body">
            <p class="">
              <div class="text-center">
                <img class="margin-top img-responsive" src="{$entry->image}" alt="{$entry->image_caption}" data-sr="enter left, hustle 20px" width="429" height="320px">
              </div>
            </p>
          </div>
      </div>
    </div>
  </div>
{/foreach}
</div>