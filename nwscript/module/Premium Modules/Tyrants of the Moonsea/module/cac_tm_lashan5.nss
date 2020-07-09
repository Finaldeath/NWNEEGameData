//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_lashan5
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Finishes Lowertower Rescue evil path and
//       award 1,000 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    //Update journal and award half quest completion xp
    AddJournalQuestEntry("LocktowerRescue", 105, oPC);
    nXP = GetJournalQuestExperience("LocktowerRescue") / 2;
    GiveXPToCreature(oPC, nXP);
}
