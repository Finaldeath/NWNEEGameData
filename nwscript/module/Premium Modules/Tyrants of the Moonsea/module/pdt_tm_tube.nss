//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pdt_tm_tube
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Reward player with 100 xp for destroying tube.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_tool"
void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

RewardPartyXP(100, oPC, FALSE);

}
