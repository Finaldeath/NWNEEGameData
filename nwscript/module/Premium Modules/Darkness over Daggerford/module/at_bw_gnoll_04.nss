void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "nWH_SpokeGnolls", 2);   // spoke with shaman

    int j = 3;
    if (GetLocalInt(oPC, "nWH_OgreDeal") == 1)
    {
        // must decide which side to support
        j = 5;
    }
    AddJournalQuestEntry("j204", j, oPC);
}
