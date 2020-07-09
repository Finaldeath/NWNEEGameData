//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel7
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Dazel leaves cell, cutscene mode removed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetFirstPC();
    object oWaypoint = GetObjectByTag("WP_Dazel_Flee");

    SetCutsceneMode(oPC, FALSE);
    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(oWaypoint, FALSE);

    DestroyObject(OBJECT_SELF, 5.0);
}
