<div class="col-sm-12 col-md-11 center-column mt25">


{if !empty($items)}
  <div class="row">
  <div class="panel-heading"><span class="panel-title">{if !empty($focus)}Drops for {$focus->clean_name}{/if}</span></div>
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

</div>

  