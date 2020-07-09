// April 2004
// B W-Husey
// Persuade 8

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 8;
  int iBonus = GetSkillRank(SKILL_PERSUADE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
