// November 2005
// B W-Husey
// Bluff 20

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 20;
  int iBonus = GetSkillRank(SKILL_BLUFF, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}
