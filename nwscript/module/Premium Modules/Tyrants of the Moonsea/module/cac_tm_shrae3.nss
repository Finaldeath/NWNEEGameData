//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_shrae3
// DATE: October 30, 2005
// AUTH: Luke Scull
// NOTE: Finish Evil Beneath Voonlar quest, award
//       2500 xp, and set int.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("EvilBeneathVoonlar", 60, oPC);

    GiveXPToCreature(oPC, GetJournalQuestExperience("EvilBeneathVoonlar"));

    SetLocalInt(oPC, "shrazguldead", 2);
}
