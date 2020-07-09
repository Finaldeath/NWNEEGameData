void main()
{
    if (GetLocalInt(GetModule(), "bLevelsSelectedPermanently") == TRUE)
    {
        SetLocalInt(GetModule(), "bLevelPlayers", TRUE);
    }

    object oPC = GetFirstPC();
    int nXP;
    while (oPC != OBJECT_INVALID)
    {
        nXP = GetXP(oPC);
        if (nXP < 10000)
        {
            GiveXPToCreature(oPC, 10000 - nXP);
        }
        oPC = GetNextPC();
    }
}
