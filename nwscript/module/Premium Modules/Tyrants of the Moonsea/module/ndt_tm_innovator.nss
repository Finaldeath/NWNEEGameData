//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_innovator
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Finish Madmen and Villains journal entry,
//       award 3,500 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    int nXP;

    object oPC = GetFirstPC();

    //Update journal and award quest completion xp
    AddJournalQuestEntry("CrazedOldMan", 40, oPC);
    nXP = GetJournalQuestExperience("CrazedOldMan");
    GiveXPToCreature(oPC, nXP);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
