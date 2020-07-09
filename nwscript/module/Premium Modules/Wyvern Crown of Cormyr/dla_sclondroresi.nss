// September 2005
// B W-Husey
// Opposed Bluff check made by the PC vs Londro
#include "cu_functions"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = GetSkillRank(SKILL_BLUFF, OBJECT_SELF)+d20();
  if (GetSkillCheckSucceeded(oPC,SKILL_BLUFF,iDC))    return TRUE;
  return FALSE;
}

