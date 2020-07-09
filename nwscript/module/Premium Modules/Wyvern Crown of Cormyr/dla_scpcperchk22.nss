// April 2004
// B W-Husey
// Persuade 22

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 22;
  int iBonus = GetSkillRank(SKILL_PERSUADE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
