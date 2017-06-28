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
<form action="/" method="get">
 <table class="table table-striped">
    <tr>
     <td> <input id="onlyGear" {if $category=="gear"}disabled style="color: #666;"{/if} type="button" name="gear" value="Only Gear"></td>
     <td> <input id="onlyWeapon" {if $category=="weapon"}disabled style="color: #666;"{/if} type="button" name="weapon" value="Only Weapons"></td>
     <td> <input id="onlyItem" {if $category=="item"}disabled style="color: #666;"{/if} type="button" name="item" value="Only Items"></td>
     <td> <input id="onlyRemove" {if $category == ""}disabled style="color: #666;"{/if} type="button" name="item" value="Remove Filters"></td>
    </tr>
    <tr>
    <td colspan=4>Showing {if $totalPages != 1}page {$currentPage} of {$totalPages} {/if}({$count} results)</td>
    </tr>
    <tr>
    <td colspan=4>
     {if $totalPages > 1}
              
                <ul class="pagination pull-right" style="margin: 0px">
                {if $currentPage > 1}
                  <li><a href="?page={$currentPage-1}"><i class="fa fa-angle-left"></i> Previous</a></li>
                {/if}
                {assign var="i" value=0}
                {for $i=1 to $totalPages}
                  <li {if $i == $currentPage}class="active"{/if}><a href="?page={$i}">{$i}</a></li>
                {/for}                  
                  {if $currentPage < $totalPages}
                  <li class="next"><a href="?page={$currentPage+1}">Next <i class="fa fa-angle-right"></i></a></li>
                  {/if}
                </ul>
              
        {else}
        {/if}
    </td>
    </tr>
 </table>
 </form>
</div>
</div>
<div class="row">
<div class="panel">
<div class="panel-body">
    <div class="table-responsive"> 
      <table class="table table-striped">
      <thead>
        <tr>
        <th><a href="/lookup/zone/{$zone->id}/item/">Item</a></th>
        <th>Category</th>
        <th><a href="/lookup/zone/{$zone->id}/era/">Era</a></th>
        <th><a href="/lookup/zone/{$zone->id}/quest/">Quest</a></th>
        <th><a href="/lookup/zone/{$zone->id}/npc/">NPCs</a></th>
        </tr>
      </thead>
      <tbody>

        {foreach from=$items item=item key=c}
        <tr>
          <td><a itemtooltip="{$item->entry->item_id}" href="/lookup/item/{$item->entry->item_id}"><span class="image-icon icon-{$item->entry->icon}"></span></a><a itemtooltip="{$item->entry->item_id}" href="/lookup/item/{$item->entry->item_id}">{$item->entry->name}</a></td>
          <td>{$item->entry->category}</td>
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
      {if $totalPages > 1}
      <div class="panel-footer clearfix">
              <nav>
                <ul class="pagination pull-right">
                {if $currentPage > 1}
                  <li><a href="?page={$currentPage-1}"><i class="fa fa-angle-left"></i> Previous</a></li>
                {/if}
                {assign var="i" value=0}
                {for $i=1 to $totalPages}
                  <li {if $i == $currentPage}class="active"{/if}><a href="?page={$i}">{$i}</a></li>
                {/for}                  
                  {if $currentPage < $totalPages}
                  <li class="next"><a href="?page={$currentPage+1}">Next <i class="fa fa-angle-right"></i></a></li>
                  {/if}
                </ul>
              </nav>
            </div>
        {else}
        <br>
        {/if}
          </div>
          </div>
    </div>
{/if}
  </div>
</div>
</div>


 <script type="text/javascript">
 $(document).ready(function() {
    $('#onlyWeapon').click(function() {
      window.location.replace("/lookup/zone/{$zone->id}/?category=weapon"); 
    });
    $('#onlyGear').click(function() {
      window.location.replace("/lookup/zone/{$zone->id}/?category=gear"); 
    });
    $('#onlyItem').click(function() {
      window.location.replace("/lookup/zone/{$zone->id}/?category=item"); 
    });
    $('#onlyRemove').click(function() {
      window.location.replace("/lookup/zone/{$zone->id}/"); 
    });
 })
 </script>
   