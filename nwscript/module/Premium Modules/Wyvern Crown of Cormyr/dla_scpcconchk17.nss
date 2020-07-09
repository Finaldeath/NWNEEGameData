// April 2004
// B W-Husey
// Concentration 17

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 17;
  int iBonus = GetSkillRank(SKILL_CONCENTRATION, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
