// April 2004
// B W-Husey
// Persuade 18

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 18;
  int iBonus = GetSkillRank(SKILL_PERSUADE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
