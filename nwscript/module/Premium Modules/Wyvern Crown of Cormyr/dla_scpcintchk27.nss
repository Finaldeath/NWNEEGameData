// April 2004
// B W-Husey
// Intimidate 27

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 27;
  int iBonus = GetSkillRank(SKILL_INTIMIDATE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
