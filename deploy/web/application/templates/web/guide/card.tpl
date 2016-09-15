{include file="../_header.tpl"}
  
<div id="intro">
 <section id="pricing" class="dark">
  <div class="container">

  <div class="row" style="margin-top:60px;">
      <div class="col-md-8 col-md-offset-2">
        <div class="row">
        
                <h2>Card Augments</h2>
            <p>      
               Rebuild EQ introduces a new style of augmenting inspired by Ragnarok Online. When you consider an NPC, you will see special tags associated with them, such as Dark Elf, Summoned, etc. These represent what the creature has a chance to drop.
               </p>
       </div>
    </div>
  </div>
  </div>
  </section>
</div>



<section id="featured2" class="featured">
  <div class="col-md-8 col-md-offset-2">
    <div class="row">
      <table class="table table-striped">
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
</section>

    <section id="gallery">
        <div class="row">
          <div class="col-sm-12 text-center">
            <div class="vertical-align">
              <h2>Apply for Beta today</h2>
              <p>Join discord and talk to the GMs to apply for the beta.</p>
              <a class="btn btn-lg btn-primary signup" href="/chat" role="button">Apply For Beta</a></p>
            </div>
          </div>
        </div>
      </div>

    </section>

  </div>
    
{*include file="../_footer.tpl"*}