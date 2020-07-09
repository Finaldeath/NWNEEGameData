// April 2004
// B W-Husey
// Intimidate 12
#include "cu_functions"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 12;
  if (GetSkillCheckSucceeded(oPC,SKILL_INTIMIDATE,iDC))    return TRUE;
  return FALSE;
}
