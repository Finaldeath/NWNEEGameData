// December 2005
// B W-Husey
// NPC attempts to bluff the PC, who resists if TRUE. (opposed roll of base 15)

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 15;
  int iBonus = GetSkillRank(SKILL_BLUFF, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}

