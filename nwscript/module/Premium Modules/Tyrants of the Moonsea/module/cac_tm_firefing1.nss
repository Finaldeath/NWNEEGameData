//Firefingers tells PC about Maganus
void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Update journal and give quest completion xp
    if(GetLocalInt(OBJECT_SELF, "nFirefingersXPGiven") == 0)
    {
        AddJournalQuestEntry("Thentia", 20, oPC);
        nXP = GetJournalQuestExperience("Thentia");
        GiveXPToCreature(oPC, nXP);
        SetLocalInt(OBJECT_SELF, "nFirefingersXPGiven", 1);
    }
    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
