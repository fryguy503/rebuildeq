#REVISED: Angelox
#Zone: timorous
sub EVENT_SAY { 
if ($text=~/Hail/i){quest::say("Hello there. We have most the ships working again. do you need to [travel to Butcherblock] or [travel to Firiona]?."); }
if ($text=~/travel to butcherblock/i){quest::movepc(68,3168.92,851.92,11.66); }
if ($text=~/travel to firiona/i){quest::movepc(84, 1398, -4404, -102, 0); }
}