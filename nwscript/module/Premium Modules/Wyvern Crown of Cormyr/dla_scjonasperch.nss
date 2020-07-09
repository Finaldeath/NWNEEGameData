// January 2006
// B W-Husey
// Jonas uses persuade
#include "cu_functions"
int StartingConditional()
{
  object oHench = GetObjectByTag("Jonas");
  int iDC = 12;
  if (GetSkillCheckSucceeded(oHench,SKILL_PERSUADE,iDC))    return TRUE;
  return FALSE;
}
