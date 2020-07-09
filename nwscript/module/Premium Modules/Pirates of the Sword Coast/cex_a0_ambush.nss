//::///////////////////////////////////////////////
//:: cex_a0_ambush
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has met Dela and has heard of her
    shop in the alley way by the docks
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oExit = GetObjectByTag("WP_DELAEXIT");
    object oWayPoint = GetWaypointByTag("MP_DELACON");
    int iAmbush = GetLocalInt(oModule, "A0_AMBUSH");
    int iDoOnce = GetLocalInt(oModule, "cex_a0_ambush");

    if ((iAmbush == 10) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cex_a0_ambush", TRUE);
        SetLocalInt(OBJECT_SELF, "NO_TALKIE", TRUE);

        ActionMoveToObject(oExit, FALSE, 0.3f);
        ActionDoCommand(DestroyObject(OBJECT_SELF));
        CreateObject(OBJECT_TYPE_CREATURE, "a0_dela", GetLocation(oWayPoint));
    }
}
