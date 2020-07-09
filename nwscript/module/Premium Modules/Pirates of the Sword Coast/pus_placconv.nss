//::///////////////////////////////////////////////
//:: pus_placconv
//::
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cause a placeable object to start a
    conversation with the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
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
