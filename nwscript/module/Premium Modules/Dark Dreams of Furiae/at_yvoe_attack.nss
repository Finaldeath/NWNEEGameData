#include "NW_I0_GENERIC"

void main()
{
   object oPC = GetPCSpeaker();
   AdjustReputation(oPC,OBJECT_SELF,-100);
   DetermineCombatRound(oPC);
}
