<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
    <div class="panel">
    <div class="panel-heading"><span class="image-icon icon-{$focus->icon}"></span><span class="panel-title">{$focus->Name}</span></div>
    <div class="panel-body">
      <p>
    Item stats here
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
        <th>Zone</th>
        </tr>
      </thead>
      <tbody>

        {foreach from=$npcs item=zones}
        {foreach from=$zones item=npc}
        <tr>
          <td><a href="/lookup/npc/{$npc->zone_id}/{$npc->npc_id}">{$npc->clean_name}</a></td>
          <td>{$npc->level}</td>
          <td><a href="/zone/{$npc->zone_id}">{$npc->long_name}</a></td>          
        </tr>
        {/foreach}
        {/foreach}
      </tbody>
      </table>
</div>
{/if}
</div>

  