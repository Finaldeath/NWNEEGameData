// April 2004
// B W-Husey
// Intimidate 23

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 23;
  int iBonus = GetSkillRank(SKILL_INTIMIDATE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
