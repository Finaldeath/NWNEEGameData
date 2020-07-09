//::///////////////////////////////////////////////
//:: nw_g0_convplac
//::
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cause a placeable object to start a
    conversation with the PC.

    Use this script as the OnUsed event
    of a Placeable object that is flagged as
    Useable, Has NO Inventory, and is NOT Static.
*/
//:://////////////////////////////////////////////
//:: Created By: Sydney Tang
//:: Created On: Aug 08, 2002
//:://////////////////////////////////////////////

void main()
{
    //Prevent possessed familiars from activating them.
    object oUser = GetLastUsedBy();
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You'd best not touch anything until your master arrives.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        ActionStartConversation(oUser);
    }
}
