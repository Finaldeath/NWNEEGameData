//Update journal at end of Kornah's tour if asked about Maganus
void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Update journal and award quest completion xp
    if(GetLocalInt(OBJECT_SELF, "nXPAwarded") == 0)
    {
        AddJournalQuestEntry("ZhentilKeep", 20, oPC);
        nXP = GetJournalQuestExperience("ZhentilKeep");
        GiveXPToCreature(oPC, nXP);
        SetLocalInt(OBJECT_SELF, "nXPAwarded", 1);
    }
}
