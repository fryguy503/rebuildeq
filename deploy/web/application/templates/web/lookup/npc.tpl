<div class="col-sm-12 col-md-11 center-column mt25">
{if !empty($focus)}
  <div class="row">
    <div class="col-md-4">
      <div class="panel">
          <div class="panel-heading">
             <span class="panel-title">{$focus->clean_name}</span></a>
          </div>    
          <div class="panel-body">
            <p class="">           
              {$focus->race}   
              {$focus->level}
            </p>
          </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel">
        <div class="panel-heading">
             <span class="panel-title">Image</span>
          </div> 
          <div class="panel-body">
            <p class="">
              <div class="text-center">
                <img class="margin-top img-responsive" src="image" alt="title" data-sr="enter left, hustle 20px" width="429" height="320px">
              </div>
            </p>
          </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel">
        <div class="panel-heading">
             <span class="panel-title">Spawns</span>
          </div> 
          <div class="panel-body">
            <p class="">
              <div class="text-center">
                <img class="margin-top img-responsive" src="image" alt="title" data-sr="enter left, hustle 20px" width="429" height="320px">
              </div>
            </p>
          </div>
      </div>
    </div>
  </div>

{if !empty($items)}

  <div class="row">
  <div class="panel">
  <div class="panel-heading"><span class="panel-title">{if !empty($focus)}Drops for {$focus->clean_name}{/if}</span></div>
        <table class="table table-striped">
        <thead>
          <tr>
          <th>Item</th>
          <th>Era</th>
          </tr>
        </thead>
        <tbody>

          {foreach from=$items item=item key=c}
          <tr>
            <td><a itemtooltip="{$item->entry->item_id}" href="/lookup/item/{$item->entry->item_id}"><span class="image-icon icon-{$item->entry->icon}"></span></a><a itemtooltip="{$item->entry->item_id}" href="/lookup/item/{$item->entry->item_id}">  {$item->entry->name}</a></td>
            <td>{$item->entry->era}</td>
           
          </tr>
          {/foreach}
        </tbody>
        </table>
        </div>
  </div>
{/if}
{else}

<div class="admin-form">
  <div class="panel heading-border">
    <div class="panel-body bg-dark dark">
      <form method="get" action="/lookup/npc/" id="form-ui">
        <div class="section-divider mb40" id="spy1">
          <span>NPC search</span>
        </div>

        <div class="row">
          <div class="col-md-offset-2 col-md-8">
            <div class="section">
              <label class="field prepend-icon">
                <input type="text" name="name" id="name" class="gui-input" placeholder="NPC Name">
                <label for="name" class="field-icon">
                  <i class="fa fa-user"></i>
                </label>
              </label>
            </div>
          </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="button btn-primary">Search</button>
        </div>
      </form>
    </div>
  </div>
</div>
{/if}
</div>

  