//::///////////////////////////////////////////////
//:: tcl_a2_docksewr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player uses the grate in spindrift to get
    to the sewers area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void main()
{
    object oGrate = OBJECT_SELF;
    object oUser = GetClickingObject();
    object oTarget = GetWaypointByTag("a2_sewers_docks");

    location lTarget = GetLocation(oTarget);

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, JumpToLocation(lTarget));
        SetLocalInt(oTarget, "SEWER_ENABLED", TRUE);
        SetMapPinEnabled(oTarget, TRUE);
    }
}
