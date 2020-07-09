//::///////////////////////////////////////////////
//:: Vantabular's lighthouse portal
//:: pus_a2_vanportal
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If this is the portal in Vantabular's
    lighthouse, jump the player to the dungeon.
    If it's the portal in the dungeon, jump the
    player to the lighthouse.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9/05
//:://////////////////////////////////////////////

void main()
{
    string sDestTag;
    if(GetTag(OBJECT_SELF)=="a2_portal_lh")
    {
        sDestTag = "a2_portal_to_lh";
    }
    else
    {
        sDestTag = "a2_portal_lh";
    }

    object oDest = GetObjectByTag(sDestTag);
    object oUser = GetLastUsedBy();

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, ActionJumpToObject(oDest));
    }
}
