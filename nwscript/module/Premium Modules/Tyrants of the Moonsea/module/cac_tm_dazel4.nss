//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel4
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Add journal entry, remove cutscene mode then
//       apply knockdown to Dazel.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oDazel = GetObjectByTag("DeputyDazel");
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("LocktowerRescue", 93, oPC);
    SetLocalInt(OBJECT_SELF, "nStunned", 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectKnockdown(), oDazel);
    SetPlotFlag(OBJECT_SELF, TRUE);
    SetCutsceneMode(oPC, FALSE);
}
