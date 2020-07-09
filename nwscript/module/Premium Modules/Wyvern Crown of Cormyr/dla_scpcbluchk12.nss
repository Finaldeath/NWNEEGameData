// April 2004
// B W-Husey
// Bluff 12

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 12;
  int iBonus = GetSkillRank(SKILL_BLUFF, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
