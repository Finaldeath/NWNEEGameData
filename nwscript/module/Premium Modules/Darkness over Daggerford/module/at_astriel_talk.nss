// after the zhents attack cutscene there's a heartbeat which forces astriel
// .. to talk with the player. If the player talks first, we want to shut
// .. down that heartbeat.

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    // the "zhent bust down the door" cutscene is done already
    SetLocalInt(oArea, "Cutscene_Fired", 0);

    // activate flee to exit for an upcoming dialog
    SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", 64);
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "EXIT_pm_astriel2");
    SetLocalInt(OBJECT_SELF, "HF_EXIT_RUN", 1);

    // let the maid walk her waypoints again
    object oMaid = GetNearestObjectByTag("ac_inn_maid", oPC);
    SetLocalInt(oMaid, "no_banter", 0);
    SetLocalObject(oMaid, "waypoint", OBJECT_INVALID);

    // unlock the exit
    object oDoor2 = GetObjectByTag("dt_ar0101_rooms");
    SetLocked(oDoor2, FALSE);

    // autosave the game when the player enters daggerford town next
    SetLocalInt(oPC, "HF_DO_AUTOSAVE", 1);
}
