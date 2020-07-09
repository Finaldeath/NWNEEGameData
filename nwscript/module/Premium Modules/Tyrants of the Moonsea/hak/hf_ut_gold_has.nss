// conversation condition: does the player have the gold?
//   HF_GOLD_AMOUNT - amount of gold to check for

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nGoldRequired = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    int nPlayerGold = GetGold(oPC);
    if (nPlayerGold >= nGoldRequired)
        return TRUE;
    return FALSE;
}

