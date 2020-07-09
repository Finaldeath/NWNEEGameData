// April 2004
// B W-Husey
// Concentration 11

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 11;
  int iBonus = GetSkillRank(SKILL_CONCENTRATION, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
