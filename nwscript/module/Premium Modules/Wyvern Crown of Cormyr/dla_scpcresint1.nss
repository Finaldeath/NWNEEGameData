// December 2005
// B W-Husey
// NPC attempts to intimidate the PC, who resists if TRUE.

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iDC = 21;
  int iBonus = GetSkillRank(SKILL_INTIMIDATE, oPC);
  if( Random(20)+ iBonus >= iDC)
  {
    return TRUE;
  }
  return FALSE;
}

