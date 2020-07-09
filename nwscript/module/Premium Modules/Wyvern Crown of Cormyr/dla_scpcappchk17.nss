// April 2004
// B W-Husey
// Appraise 17

int StartingConditional()
{
  object oPC = GetPCSpeaker();

  int iDC = 17;
  int iBonus = GetSkillRank(SKILL_APPRAISE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
