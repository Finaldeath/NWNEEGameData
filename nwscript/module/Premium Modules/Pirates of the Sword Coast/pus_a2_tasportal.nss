//::///////////////////////////////////////////////
//:: pus_a2_tasportal
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina's portal - goes from the area below
    the temple in Spindrift, to the dock.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 27, 2005
//:://////////////////////////////////////////////

void main()
{
    object oUser = GetLastUsedBy();

    object oDest = GetObjectByTag("a2_portal_from_below");

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else if(GetIsInCombat(oUser))
    {
        string sMessage = "You cannot use this portal while in combat.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, ActionJumpToObject(oDest));
    }
}
