//::///////////////////////////////////////////////
//:: ten_a0_initmbsh
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Get the Dela NPC to init dialog with the first
    Player charater that enters the Seedy Tavern.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oDela = GetObjectByTag("a0_delashop");
    int iDoOnce = GetLocalInt(OBJECT_SELF, "ten_a0_initmbsh");

    // if it's a player but not a DM and this hasn't fired before
    // make dela initiate dialog with the charater.
    if (((GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) != TRUE))
        && (iDoOnce != TRUE))
    {
        SetLocalInt(OBJECT_SELF, "ten_a0_initmbsh", TRUE);

        AssignCommand(oDela, ActionForceMoveToObject(oPC));
        AssignCommand(oDela, ActionStartConversation(oPC));
    }
}
