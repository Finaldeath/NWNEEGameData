//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric6
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Update journal entry. Remove cutscene mode.
//       ALL Bron's deputies now hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("LocktowerRescue", 80, oPC);

    AdjustReputation(oPC, OBJECT_SELF, -100);
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_SHOUT);
    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(90.0, 45.0, 50.0));
}
