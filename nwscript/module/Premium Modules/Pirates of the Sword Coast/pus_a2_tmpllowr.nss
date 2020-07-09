//::///////////////////////////////////////////////
//:: pus_a2_tmpllowr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player uses the trapdoor in the temple
    to get to the underground temple
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void main()
{
    object oGrate = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oTarget = GetWaypointByTag("a2_bellow_temple");
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
    }
}
