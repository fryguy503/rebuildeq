
<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
    <div class="panel">
    <div class="panel-heading"><span class="panel-title">Card Augments</span></div>
    <div class="panel-body">
      <p>
  Rebuild EQ introduces a new style of augmenting inspired by Ragnarok Online. When you consider an NPC, you will see special tags associated with them, such as Dark Elf, Summoned, etc. These represent what the creature has a chance to drop.
      </p>
    </div>
    </div>


    <div class="panel">
    <div class="panel-heading">
      <div class="panel-title hidden-xs">
        <span class="glyphicon glyphicon-tasks"></span>Cards
      </div>
    </div>
        <table class="table footable table-striped">
        <thead>
          <tr>
          {*<th>Picture</th>*}
          <th>Card Name</th>
          <th>Slot</th>
          <th>Lore</th>
          </tr>
        </thead>
        <tbody>
          {foreach from=$cards item=card key=c}
          <tr>
           {* <td><img src="/images/cards/{$card->id}.png" alt="{$card->name}" class="img-responsive" height="150px"></td>*}

            <td>{$card->name}</td>
            <td>{if $card->slots == 131072}Chest{/if}
            {if $card->slots == 8192}Weapon{/if}
            {if $card->slots == 98304}Finger{/if}
            {if $card->slots == 262144}Legs{/if}
            </td>
            <td>{$card->lore}</td>
          </tr>
          {/foreach}
        </tbody>
        </table>
    </div>
</div>
</div>
   