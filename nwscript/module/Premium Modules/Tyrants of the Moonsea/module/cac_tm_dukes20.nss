//Update Dukes journal entry and give quest completion xp
void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    if(GetLocalInt(OBJECT_SELF, "nDukesXPGiven") == 0)
    {
        AddJournalQuestEntry("ADatewiththeDukes", 20, oPC);
        nXP = GetJournalQuestExperience("ADatewiththeDukes");
        GiveXPToCreature(oPC, nXP);
        SetLocalInt(OBJECT_SELF, "nDukesXPGiven", 1);
    }
}
