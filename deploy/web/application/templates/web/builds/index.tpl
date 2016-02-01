{include file="../_header.tpl"}
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<script src="/js/builds/skillManager.js"></script>
<link href="/css/builds/builds.css" rel="stylesheet" type="text/css">
  <div class="container">

	<div class="row" style="margin-top:60px;">

		<div class="row">
	        	<ul class="breadcrumb">
	          		<li><a href="/builds">Builds</a></li>
	          		<li class="active">{$fullName}</li>
	        	</ul>
	    </div>

	     <div class="row">
			<form class="well bs-component">
				<div class="form-group">
					<a href="/builds/bard"><img class="classicon" src="/images/classicons/brd.png"/></a>
					<a href="/builds/cleric"><img class="classicon" src="/images/classicons/clr.png"/></a>
					<a href="/builds/druid"><img class="classicon" src="/images/classicons/dru.png"/></a>
					<a href="/builds/enchanter"><img class="classicon" src="/images/classicons/enc.png"/></a>
					<a href="/builds/magician"><img class="classicon" src="/images/classicons/mag.png"/></a>
					<a href="/builds/monk"><img class="classicon" src="/images/classicons/mnk.png"/></a>
					<a href="/builds/necromancer"><img class="classicon" src="/images/classicons/nec.png"/></a>
					<a href="/builds/paladin"><img class="classicon" src="/images/classicons/pal.png"/></a>
					<a href="/builds/ranger"><img class="classicon" src="/images/classicons/rng.png"/></a>
					<a href="/builds/rogue"><img class="classicon" src="/images/classicons/rog.png"/></a>
					<a href="/builds/shadowknight"><img class="classicon" src="/images/classicons/shd.png"/></a>
					<a href="/builds/shaman"><img class="classicon" src="/images/classicons/shm.png"/></a>
					<a href="/builds/warrior"><img class="classicon" src="/images/classicons/war.png"/></a>
					<a href="/builds/wizard"><img class="classicon" src="/images/classicons/wiz.png"/></a>
		        </div>
		    </form>
		</div>

	    <div class="row">
			<form class="well bs-component">
				<div class="form-group">
				<p>
		          <label class="control-label">{$classDescription}</label><br>
		         Required Level To Obtain: <span class="charLevel">1</span>
		          </p>
		        </div>
		    </form>
		</div>

  		<div class="row">
			<form class="well bs-component">
				<div class="form-group">
		<img unselectable="on" class="portrait" src="/images/monograms/{$monogram}.gif" style="left: 30%;margin-left: -30%;">
		<div class="treeCollection">
		<div class="treewrapper green">
			<div class="bglayer gray"></div>
			<div class="bglayer color" style="height: 80px;"></div>
			<div class="tree">
				<div class="tier" data-level="0" data-invested="0" data-total="0">
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-0.png">
						<div class="description"><h2>Soul Link</h2>Improves lifetap damage by <em data-base="+4">+4</em>% and a <em data-base="+1">+1</em>% chance to critical heal<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-1.png">
						<div class="description"><h2>Gouging Skin</h2>When attacked, causes a <em data-base="+6">+6</em> point damage shield and <em data-base="+20">+20</em> hate<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="1" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-2.png">
						<div class="description"><h2>Shroud of Death</h2>Shroud of Pain grants an additional <em data-base="+10">+10</em> AC to group<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-3.png">
						<div class="description"><h2>Hungering Aura</h2>Improves lifetaps by <em data-base="+6">+6</em>% healing for each enemy attacking you with a maximum of <em data-base="+1">+1</em> enemies<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="2" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-4.png">
						<div class="description"><h2>Voice of Fear</h2>Voices causes <em data-base="+20">+20</em>% additional hate<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-5.png">
						<div class="description"><h2>Scarab Skin</h2>Improves melee mitigation by <em data-base="+6">+6</em>%<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>

					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-6.png">
						<div class="description"><h2>Ichor Flesh</h2>Causes guard spells to last for an additional <em data-base="+100">+200</em> hitpoints<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					*}
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-7.png">
						<div class="description"><h2>Deathbringer</h2>Improves pet by increasing level by <em data-base="+6">+6</em>, HP by <em data-base="+200">+200</em>, and AC by <em data-base="+40">+40</em><span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description push1"><h2>Zevfeer's Feast</h2>Improves Zevfeer's Bite to give an additional <em data-base="+100">+100</em>% health and an additional <em data-base="+100">+100</em> mana<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="3" data-invested="0" data-total="0">
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description"><h2>Sworn Enemy</h2>Causes intense hatred of target, where any spell damage dealt causes an additional <em data-base="+400">+400</em> hate<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					{*<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-10.png">
						<div class="description"><h2>Relentless</h2>Causes heal over times effects on self to last <em data-base="+2">+2</em> tick<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/1</div>
					</div>
					*}
				</div>
				<div class="tier" data-level="4" data-invested="0" data-total="0">
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description"><h2>Banshee's Mirror</h2>Improves Damage Mitigation by <em data-base="+6">+6</em>% for <em data-base="+30">30</em> seconds <span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					
				</div>
				<div class="tier" data-level="5" data-invested="0" data-total="0">
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-10.png">
						<div class="description"><h2>Aura of Vampirism</h2>Grants the entire group <em data-base="+4">+4</em>% spell vampirism and <em data-base="+10">+10</em>% melee vampirism<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>				
				<div class="totalPoints">
					<span class="totalPoints">0</span>
				</div>
				<legend>{$styles[0]}</legend>
			</div>
		</div>

		<div class="treewrapper blue">
			<div class="bglayer gray"></div>
			<div class="bglayer color" style="height: 80px;"></div>
			<div class="tree">
				<div class="tier" data-level="0" data-invested="0" data-total="0">
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-0.png">
						<div class="description"><h2>Festering Spear</h2>Improve spears by <em data-base="+10">+10</em>% and a <em data-base="+1">+1</em>% chance to critical blast<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-1.png">
						<div class="description"><h2>Festering Wounds</h2>Improves DoT damage by <em data-base="+4">+4</em>%<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="1" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-2.png">
						<div class="description"><h2>Shroud of Anger</h2>All attack modifiers are improved by <em data-base="+5">+5</em>%<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}					
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-3.png">
						<div class="description"><h2>Rotten Core</h2>Increases attack by <em data-base="+8">+8</em>% for a short duration each time a target dies nearby with a maximum of <em data-base="+1">+1</em> enemies<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="2" data-invested="0" data-total="0">
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-4.png">
						<div class="description"><h2>Lingering Pain</h2>All direct damage spells have a <em data-base="+4">+4</em>% chance to cause bonus damage over time<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-5.png">
						<div class="description"><h2>Blood Oath</h2>Increases damage by <em data-base="+10">+10</em>%, while decreasing healing effects by -<em data-base="10">10</em>%, AC by -<em data-base="10">10</em>, and all resistances by -<em data-base="20">20</em>.<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					
				</div>
				<div class="tier" data-level="3" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-6.png">
						<div class="description"><h2>Cold Flesh</h2>Lowers hatred by <em data-base="400">400</em> when attacked by an enemy<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}					
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-7.png">
						<div class="description"><h2>Gift of Urash</h2>Increases all skill modifiers by <em data-base="+5">+5</em>%, stacks up to <em data-base="1">1</em> times<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="4" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description"><h2>Undying Hatred</h2>Upon feigning, creates a shadow image that continues fighting for <em data-base="10">10</em> seconds<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description"><h2>No Remorse</h2>Improves chance of proc effects by <em data-base="+4">+4</em>%<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-10.png">
						<div class="description"><h2>Unholy Focus</h2>Causes all direct damage spells to be <em data-base="+10">+10</em>% more unresistable<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/1</div>
					</div>
				</div>
				<div class="tier" data-level="5" data-invested="0" data-total="0">					
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-10.png">
						<div class="description"><h2>Reaper of Souls</h2>Grants an empowered pet that backstabs and causes <em data-base="+10">+10</em>% melee vampirism returning <em data-base="+2">+2</em>% of damage as healing to it's owner<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-gunlust-9.png">
						<div class="description"><h2>Bash of Death</h2>Causes a harm touch chance when bashing a target, damage is improved based on stacks of Gift of Urash by <em data-base="+20">+20</em>% damage<span class="perLevel"> per level</span>.</div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="column3 totalPoints">
					<span class="totalPoints">0</span>
				</div>
				<legend>{$styles[1]}</legend>
			</div>
		</div>

		<div class="treewrapper red">
			<div class="bglayer gray"></div>
			<div class="bglayer color" style="height: 80px;"></div>
			<div class="tree" unselectable="on">
				<div class="tier" data-level="0" data-invested="0" data-total="0">
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-0.png">
						<div class="description"><h2>Embrace Death</h2><span>Grants you the ability to use Feign Death, as well as causes the ability to heal you for <em data-base="+2">+2</em>% maximum health on use<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-1.png">
						<div class="description"><h2>Darkness</h2><span>All darkness spells now decreation an additional <em data-base="+4">+4</em>% movement speed<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: visible;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="1" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-2.png">
						<div class="description"><h2>Siphon Soul</h2><span>Siphon strength now grants group bonuses damage by <em data-base="+2">2</em>%<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-3.png">
						<div class="description"><h2>Empathetic Soul</h2><span>Improves Dark Empathy by granting an additional <em data-base="+40">+40</em> hitpoints healed and <em data-base="+0.5">+0.5</em>% max mana <span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="2" data-invested="0" data-total="0">
					{*<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-4.png">
						<div class="description"><h2>Reanimation</h2><span>Casts a new pet instantly, with a <em data-base="20">20</em> second reuse timer<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-6.png">
						<div class="description"><h2>Death Whisper</h2><span>Target has a <em data-base="20">20</em>% chance to be silenced for <em data-base="4">4</em> seconds<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-7.png">
						<div class="description"><h2>Embrace Shadow</h2><span>Each time you feign death, grants a <em data-base="20">20</em>% chance<span class="perLevel"> per level</span> to instantly be invisible to both living and undead creatures.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="3" data-invested="0" data-total="0">
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-8.png">
						<div class="description"><h2>Crippling Pain</h2><span>Shroud of Pain causes target to deal <em data-base="1">1</em>% less maximum damage<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="4" data-invested="0" data-total="0">
					<div class="skill" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-9.png">
						<div class="description"><h2>Nightmare</h2><span>Fear now causes target to freeze in panic and lasta an additional <em data-base="4">4</em> seconds<span class="perLevel"> per level</span>.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
					{*
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-10.png">
						<div class="description"><h2>One With Death</h2><span>Improves mana regeneration by <em data-base="10">10</em> while feigning death. Grants a <em data-base="1">1</em>% chance for a burst of <em data-base="100">100</em> mana when casting feign death.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>*}
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-9.png">
						<div class="description"><h2>Mini Minion</h2><span>Causes your pet to summon a pet and attack target with a <em data-base="2">2</em>% chance <span class="perLevel"> per level</span> the target will not bring allies.</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="tier" data-level="5" data-invested="0" data-total="0">
					<div class="skill push1" data-points="0" data-max="5"><img src="/images/builds/icons/gunzerker-brawn-10.png">
						<div class="description"><h2>Cry of the Banshee</h2><span>Causes all nearby targets to be mesmerized for <em data-base="10">10</em> while feigning death. Grants a <em data-base="2">2</em>% chance for a burst of <em data-base="2">2</em> seconds, then forget all aggressions</span></div>
						<div class="points" style="visibility: hidden;">0/5</div>
					</div>
				</div>
				<div class="column3 totalPoints">
					<span class="totalPoints">0</span>
				</div>
				<legend>{$styles[2]}</legend>
			</div>
		</div>
		</div>



	</div>
  </div>
 </div>
		    </form>
		</div>
{*include file="../_footer.tpl"*}