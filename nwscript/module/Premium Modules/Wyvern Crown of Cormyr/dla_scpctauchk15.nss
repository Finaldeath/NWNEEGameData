// April 2004
// B W-Husey
// Taunt 15

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 15;
  int iBonus = GetSkillRank(SKILL_TAUNT, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
