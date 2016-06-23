{include file="../_header.tpl"}

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<link href="/css/builds/builds.css" rel="stylesheet" type="text/css">

<div id="intro">
 <section id="pricing" class="dark">
  <div class="container">

	<div class="row" style="margin-top:60px;">
	  	<div class="col-md-8 col-md-offset-2">
			    <div class="row">
					<a href="/builds/bard"><img class="classicon {if $class eq 'bard'}classicon-active{/if}" src="/images/classicons/brd.png"/></a>
					<a href="/builds/cleric"><img class="classicon {if $class eq 'cleric'}classicon-active{/if}" src="/images/classicons/clr.png"/></a>
					<a href="/builds/druid"><img class="classicon {if $class eq 'druid'}classicon-active{/if}" src="/images/classicons/dru.png"/></a>
					<a href="/builds/enchanter"><img class="classicon {if $class eq 'enchanter'}classicon-active{/if}" src="/images/classicons/enc.png"/></a>
					<a href="/builds/magician"><img class="classicon {if $class eq 'magician'}classicon-active{/if}" src="/images/classicons/mag.png"/></a>
					<a href="/builds/monk"><img class="classicon {if $class eq 'monk'}classicon-active{/if}" src="/images/classicons/mnk.png"/></a>
					<a href="/builds/necromancer"><img class="classicon {if $class eq 'necromancer'}classicon-active{/if}" src="/images/classicons/nec.png"/></a>
					<a href="/builds/paladin"><img class="classicon {if $class eq 'paladin'}classicon-active{/if}" src="/images/classicons/pal.png"/></a>
					<a href="/builds/ranger"><img class="classicon {if $class eq 'ranger'}classicon-active{/if}" src="/images/classicons/rng.png"/></a>
					<a href="/builds/rogue"><img class="classicon {if $class eq 'rogue'}classicon-active{/if}" src="/images/classicons/rog.png"/></a>
					<a href="/builds/shadowknight"><img class="classicon {if $class eq 'shadowknight'}classicon-active{/if}" src="/images/classicons/shd.png"/></a>
					<a href="/builds/shaman"><img class="classicon {if $class eq 'shaman'}classicon-active{/if}" src="/images/classicons/shm.png"/></a>
					<a href="/builds/warrior"><img class="classicon {if $class eq 'warrior'}classicon-active{/if}" src="/images/classicons/war.png"/></a>
					<a href="/builds/wizard"><img class="classicon {if $class eq 'wizard'}classicon-active{/if}" src="/images/classicons/wiz.png"/></a>		    
				</div>
		</div>
	</div>
	<div class="row" style="margin-bottom:300px">
	<h2>{$skill->title}</h2>
	<p>
		<img src="{$skill->image}"><br>
		{$skill->desc}
	</p>
  </div>
  </section>
  </div>