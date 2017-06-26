<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<script src="/js/builds/skillManager.js"></script>
<link href="/css/builds/builds.css" rel="stylesheet" type="text/css">

	  <div class="container">
		<div class="col-sm-12 col-md-11 center-column mt25">
	<div class="row">
	{if !empty($errorMessage)}
	<div class="row">
            <div class="panel alert-danger">
                <div class="panel-body">
                <p {*style="color: #FF5533;"*}>{$errorMessage}</p>			    
                </div>
            </div>
    </div>
    {/if}
    {if empty($character)}
	<div class="row">
	    <div class="panel">
	        <div class="panel-heading">
	           <span class="panel-title">Select a Class </span>
	        </div>    
	        <div class="panel-body">
		     <div class="row">
				<div class="form-group">
					<a href="/builds/bard"><img class="classicon {if !empty($class) AND $class eq 'bard'}classicon-active{/if}" src="/images/classicons/brd.png" alt="Bard"/></a>
					<a href="/builds/cleric"><img class="classicon {if !empty($class) AND $class eq 'cleric'}classicon-active{/if}" src="/images/classicons/clr.png"/></a>
					<a href="/builds/druid"><img class="classicon {if !empty($class) AND $class eq 'druid'}classicon-active{/if}" src="/images/classicons/dru.png"/></a>
					<a href="/builds/enchanter"><img class="classicon {if !empty($class) AND $class eq 'enchanter'}classicon-active{/if}" src="/images/classicons/enc.png"/></a>
					<a href="/builds/magician"><img class="classicon {if !empty($class) AND $class eq 'magician'}classicon-active{/if}" src="/images/classicons/mag.png"/></a>
					<a href="/builds/monk"><img class="classicon {if !empty($class) AND $class eq 'monk'}classicon-active{/if}" src="/images/classicons/mnk.png"/></a>
					<a href="/builds/necromancer"><img class="classicon {if !empty($class) AND $class eq 'necromancer'}classicon-active{/if}" src="/images/classicons/nec.png"/></a>
					<a href="/builds/paladin"><img class="classicon {if !empty($class) AND $class eq 'paladin'}classicon-active{/if}" src="/images/classicons/pal.png"/></a>
					<a href="/builds/ranger"><img class="classicon {if !empty($class) AND $class eq 'ranger'}classicon-active{/if}" src="/images/classicons/rng.png"/></a>
					<a href="/builds/rogue"><img class="classicon {if !empty($class) AND $class eq 'rogue'}classicon-active{/if}" src="/images/classicons/rog.png"/></a>
					<a href="/builds/shadowknight"><img class="classicon {if !empty($class) AND $class eq 'shadowknight'}classicon-active{/if}" src="/images/classicons/shd.png"/></a>
					<a href="/builds/shaman"><img class="classicon {if !empty($class) AND $class eq 'shaman'}classicon-active{/if}" src="/images/classicons/shm.png"/></a>
					<a href="/builds/warrior"><img class="classicon {if !empty($class) AND $class eq 'warrior'}classicon-active{/if}" src="/images/classicons/war.png"/></a>
					<a href="/builds/wizard"><img class="classicon {if !empty($class) AND $class eq 'wizard'}classicon-active{/if}" src="/images/classicons/wiz.png"/></a>
		        </div>
			</div>
			<div class="row">				
		    	{if !empty($class)}
		    	<p>
		          <label class="control-label">{$classDescription}</label><br>
		         Required Level To Obtain: <span class="charLevel">0</span>
		        </p>					
		        {/if}
			</div>
			</div>
		</div>
	</div>
	{else}
	<div class="row">
        <div class="panel">
            <div class="panel-heading">
               <span class="panel-title">{$character->name} {if !empty($character->guildName)}&lt;{$character->guildName}&gt;{/if}</span>
            </div>    
            <div class="panel-body">
				<div class="row">
					<p>
						<label class="control-label">Level {$character->level} {$fullName}</label><br>
						<span class="charPointsLeft">0</span> points left to spend.
						<div style="display: none"><span class="charLevel">1</span></div>
					</p>
				</div>
			</div>
		</div>
	</div>
			{/if}

{if (!empty($class))}
	<div class="row">
            <div class="panel">
                <div class="panel-heading">
                   <span class="panel-title">Spend Points {if !empty($character)}(<span class="charPointsLeft">0</span> remaining){/if}</span>
                </div>    
                <div class="panel-body">	
			<img unselectable="on" class="portrait" src="/images/monograms/{$monogram}.gif" style="left: 30%;margin-left: -30%;">
			<div class="treeCollection">
			<div class="treewrapper green">
				<div class="bglayer gray"></div>
				<div class="bglayer color" style="height: 80px;"></div>
				<div class="tree" id="tree-1">
					<div class="tier" data-level="0" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 0}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						
						{$id = 1}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}

						{$id = 2}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="1" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 3}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}					
						{/if}
						{$id = 4}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}	
						{/if}
						{$id = 5}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
					</div>
					<div class="tier" data-level="2" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 6}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 7}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 8}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}					
					</div>
					<div class="tier" data-level="3" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 9}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 10}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{else}{$push = "push1"}
						{/if}
						{$id = 11}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{/if}	
					</div>
					<div class="tier" data-level="4" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 12}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 13}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 14}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{/if}
					</div>
					<div class="tier" data-level="5" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 15}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 16}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 17}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}					
					</div>				
					<div class="totalPoints">
						<span class="totalPoints">0</span>
					</div>
					<legend class="build-legend">{$styles[0]}</legend>
				</div>
			</div>

			<div class="treewrapper blue">
				<div class="bglayer gray"></div>
				<div class="bglayer color" style="height: 80px;"></div>
				<div class="tree" id="tree-2">
					<div class="tier" data-level="0" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 18}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 19}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 20}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="1" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 21}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 22}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 23}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}			
						
					</div>
					<div class="tier" data-level="2" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 24}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 25}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 26}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}	
					</div>
					<div class="tier" data-level="3" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 27}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 28}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 29}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}	
					</div>
					<div class="tier" data-level="4" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 30}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 31}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 32}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="5" data-invested="0" data-total="0">					
						{$push = ""}
						{$id = 33}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 34}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 35}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="column3 totalPoints">
						<span class="totalPoints">0</span>
					</div>
					<legend class="build-legend">{$styles[1]}</legend>
				</div>
			</div>

			<div class="treewrapper red">
				<div class="bglayer gray"></div>
				<div class="bglayer color" style="height: 80px;"></div>
				<div class="tree" id="tree-3" unselectable="on">
					<div class="tier" data-level="0" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 36}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 37}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 38}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="1" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 39}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 40}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 41}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="2" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 42}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 43}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 44}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="3" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 45}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 46}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 47}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="4" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 48}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 49}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 50}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="tier" data-level="5" data-invested="0" data-total="0">
						{$push = ""}
						{$id = 51}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 52}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{$push = ""}
						{else}{$push = "push1"}
						{/if}
						{$id = 53}
						{if !empty($skills[$id])}
						<div class="skill {$push}" data-points="0" id="skill-{$id}" data-max="5"><img src="{$skills[$id]->image}">
							<div class="description"><h2>{$skills[$id]->title}</h2>{$skills[$id]->desc}</div>
							<div class="points" style="visibility: visible;">0/5</div>
						</div>
						{/if}
					</div>
					<div class="column3 totalPoints">
						<span class="totalPoints">0</span>
					</div>
					<legend class="build-legend">{$styles[2]}</legend>
				</div>
			</div>
			</div>
		</div>
		</div>
	</div>



	<div class="row">

            <div class="panel">
                <div class="panel-heading">
                   <span class="panel-title">{$class|capitalize} Skills</span>
                </div>
                <div class="panel-body">
                <table class="table footable table-striped">
			      <thead>
			        <tr>
				        <th>Icon</th>
				        <th>Name</th>
				        <th>Description</th>
			        </tr>
			      </thead>
      				<tbody>
  			      	{foreach from=$skills item=skill key=s}
  			      	<tr>
				       	<td><a href="/builds/{$class}/skill/{$s}"><img src="{$skill->image}"/></a></td>
				       	<td>{$skill->title}</td>
				       	<td>{$skill->desc|strip_tags|truncate:150}</td>
			       	</tr>
		          	{/foreach}
		        	</tbody>
		        </table>
			</div>
		</div>
</div>

			
			<script type="text/javascript">
			var classLevel = 60;
			var isTest = true;
			var session = "";
			{if !empty($hash)}
			var initialHash = "{$hash}";

			{/if}
			{if !empty($character)}
			classLevel = {$character->level};
			isTest = false;
			session = "{$session}";
			{/if}
			</script>
{/if}			
		</div>
	  </div>
</div>