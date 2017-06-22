<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
<div class="panel">
                <div class="panel-heading">
                   <span class="panel-icon fa fa-map-marker"></span>
                   <span class="panel-title">Browse Zones ({sizeof($zones)})</span>
                </div>    
                <div class="panel-body">

<table class="table footable table-striped">
<thead>
  <th>Name</th><th>1</th><th>5</th><th>10</th><th>15</th><th>20</th><th>25</th><th>30</th><th>35</th><th>40</th><th>45</th><th>50</th><th>55</th><th>60</th>
</thead>
<tbody>
{foreach from=$zones item=zone}
  <tr>
  <td><a href="/lookup/zone/{$zone->zoneidnumber}">{$zone->long_name}</a><br></td>
  <td>{if ($zone->levels & 1) == 1}<span class="fa fa-check"></span>{/if}</td> 
  <td>{if ($zone->levels & 2) == 2}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 4) == 4}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 8) == 8}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 16) == 16}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 32) == 32}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 64) == 64}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 128) == 128}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 256) == 256}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 512) == 512}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 1024) == 1024}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 2048) == 2048}<span class="fa fa-check"></span>{/if}</td>
  <td>{if ($zone->levels & 4096) == 4096}<span class="fa fa-check"></span>{/if}</td>
  </tr>
  {/foreach}
</tbody>
</table>

                </div>
            </div>
</div>
</div>