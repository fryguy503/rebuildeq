<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
    <div class="panel">
    <div class="panel-heading"><span class="panel-title">{if !empty($zone)}Drops for {$zone->short_name}{/if}</span></div>
    <div class="panel-body">
      <p>
    Zone description here.
      </p>
    </div>
    </div>
</div>

{if !empty($items)}
<div class="row">
      <table class="table table-striped">
      <thead>
        <tr>
        <th>Icon</th>
        <th>Item</th>
        <th>Era</th>
        </tr>
      </thead>
      <tbody>

        {foreach from=$items item=item key=c}
        <tr>
          <td><span class="image-icon icon-{$item->entry->icon}"></span></td>
          <td><a href="/lookup/item/{$item->entry->item_id}">{$item->entry->name}</a></td>
          <td>{$item->entry->era}</td>
         
        </tr>
        {/foreach}
      </tbody>
      </table>
</div>
{/if}
</div>

  