// April 2004
// B W-Husey
// Bluff 16

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 16;
  int iBonus = GetSkillRank(SKILL_BLUFF, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
