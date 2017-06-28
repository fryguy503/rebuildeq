<div class="col-sm-12 col-md-11 center-column mt25">

{if !empty($errorMessage)}
<div class="row">
        <div class="panel alert-danger">
            <div class="panel-body">
            <p {*style="color: #FF5533;"*}>{$errorMessage}</p>          
            </div>
        </div>
</div>
{/if}

{if empty($focus) AND empty($items)}
{* item search *}
<div class="row">
<div class="admin-form">
  <div class="panel heading-border">
    <div class="panel-body bg-dark dark">
      <form method="get" action="/lookup/item/" id="form-ui">
        <div class="section-divider mb40" id="spy1">
          <span>Item search</span>
        </div>

        <div class="row">
          <div class="col-md-offset-2 col-md-8">
          * Only items that drop in game are discovered
            <div class="section">
              <label class="field prepend-icon">
                <input type="text" name="name" id="name" class="gui-input" placeholder="Item Name">
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
</div>


{else if !empty($items)}
{* item search results *}
  
  <div class="row">
  <div class="panel-heading">
       <span class="panel-title">{$resultMessage}</span></a>
    </div>    
    <div class="table-responsive"> 
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
          
          <td><a href="/lookup/item/{$item->id}"><span class="image-icon icon-{$item->icon}"></span></a><a href="/lookup/item/{$item->id}">{$item->Name}</a></td>
          <td>{$item->era}</td>
        </tr>
        {/foreach}
      </tbody>
      </table>
      </div>
    </div>
{else}
{* single item result *}
  <div class="row">
      <div class="panel">
      <div class="panel-heading"><span class="image-icon icon-{$focus->icon}"></span><span class="panel-title">{$focus->Name}</span></div>
      <div class="panel-body">
        <p>
          {include file="../_item_stats.tpl"}
        </p>
      </div>
      </div>
    </div>

  {if !empty($npcs)}
    <div class="row">
    <div class="panel-heading">Mobs that drop {$focus->Name}</div>
          <table class="table table-striped">
          <thead>
            <tr>
            
            <th>Name</th>
            <th>Level</th>
            <th>Quest</th>
            <th>Zone</th>
            </tr>
          </thead>
          <tbody>

            {foreach from=$npcs item=zones}
            {foreach from=$zones item=npc}
            <tr>
              <td><a href="/lookup/npc/{$npc->zone_id}/{$npc->npc_id}">{$npc->clean_name}</a></td>
              <td>{$npc->level}</td>
              <td>{if $npc->is_quest_reward == 1}Quest Reward{else if $npc->is_quest_item == 1}Quest Item{/if}</td>
              <td><a href="/lookup/zone/{$npc->zone_id}">{$npc->long_name}</a></td>          
            </tr>
            {/foreach}
            {/foreach}
          </tbody>
          </table>
    </div>
    {/if}

    {if !empty($quests)}
    <div class="row">
    <div class="panel-heading">Quests involving {$focus->Name}</div>
          <table class="table table-striped">
          <thead>
            <tr>
            
            <th>Name</th>
            <th>Level</th>
            <th>Quest</th>
            <th>Zone</th>
            </tr>
          </thead>
          <tbody>

            {foreach from=$quests item=zones}
            {foreach from=$zones item=npc}
            <tr>
              <td><a href="/lookup/npc/{$npc->zone_id}/{$npc->npc_id}">{$npc->clean_name}</a></td>
              <td>{$npc->level}</td>
              <td>{if $npc->is_quest_reward == 1}Quest Reward{else if $npc->is_quest_item == 1}Quest Item{/if}</td>
              <td><a href="/lookup/zone/{$npc->zone_id}">{$npc->long_name}</a></td>          
            </tr>
            {/foreach}
            {/foreach}
          </tbody>
          </table>
    </div>
    {/if}
  </div>
{/if}
</div>

  