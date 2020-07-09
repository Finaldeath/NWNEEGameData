// January 2006
// B W-Husey
// Use of a combination of parry/disarm and strength to overpower Latim.
#include "cu_functions"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if (GetSkillCheckSucceeded(OBJECT_SELF,SKILL_PARRY,10)||GetHasFeat(FEAT_DISARM,oPC))
  {
    int nStrength = GetAbilityScore(oPC,ABILITY_STRENGTH)+d6();
    if (nStrength > 15)
    {
        return TRUE;
    }
    return FALSE;
  }
  return FALSE;
}
