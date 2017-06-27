<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
    <div class="panel">
    <div class="panel-heading"><span class="panel-title">{if !empty($zone)}Drops for {$zone->name}{/if}</span></div>
    <div class="panel-body">
      <p>
      {if !empty($zone)}{$zone->description}{/if}
      </p>
    </div>
    </div>
</div>
        


{if !empty($items)}
<div class="row">
    <div class="table-responsive"> 
      <table class="table table-striped">
      <thead>
        <tr>
        <th>Item</th>
        <th>Era</th>
        <th>Quest</th>
        <th>NPCs</th>
        </tr>
      </thead>
      <tbody>

        {foreach from=$items item=item key=c}
        <tr>
          
          <td><a href="/lookup/item/{$item->entry->item_id}"><span class="image-icon icon-{$item->entry->icon}"></span></a><a href="/lookup/item/{$item->entry->item_id}">{$item->entry->name}</a></td>
          <td>{$item->entry->era}</td>
          <td>{if $item->entry->is_quest_reward == 1}Quest Reward{else if $item->entry->is_quest_item}Quest Item{/if}</td>
          <td>{foreach from=$item->npcs item=npc}
                <a href="/lookup/npc/{$zone->id}/{$npc->id}">{$npc->name}</a>{if count($item->npcs) > 1}, and {count($item->npcs)-1} more NPCs{/if}
                {break}
              {/foreach}
          </td>
        </tr>
        {/foreach}
      </tbody>
      </table>
      </div>
    </div>
{/if}
  </div>
</div>
</div>
   