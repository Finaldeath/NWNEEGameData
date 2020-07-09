//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_bennart3
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: See below for comments.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    //Define objects in script

    object oPC = GetPCSpeaker();
    object oLashan = GetObjectByTag("Lashan");
    object oGrimswold = GetObjectByTag("DeputyGrimswold");

    object oTarget;
    object oSpawn;
    location lTarget;

    // Create blood at the spot Lashan was standing for atmosphere
    oTarget = GetWaypointByTag("WP_Lashans_Blood");
    lTarget = GetLocation(oTarget);
    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "bloodstain", lTarget);

    // Destroy Lashan and Grimswold in Swords' Meet
    DestroyObject(oLashan, 0.0);
    DestroyObject(oGrimswold, 0.1);

    // Update journal and enable map note for Bennart's House
    AddJournalQuestEntry("LocktowerRescue", 100, oPC);
}
