//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_bennart5
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Finishes Locktower Rescue "good" journal and
//       awards 2,000 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Update journal and award full quest completion xp
    AddJournalQuestEntry("LocktowerRescue", 104, oPC);
    nXP = GetJournalQuestExperience("LocktowerRescue");
    GiveXPToCreature(oPC, nXP);
}
