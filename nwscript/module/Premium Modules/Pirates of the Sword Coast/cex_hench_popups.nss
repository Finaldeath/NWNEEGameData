//::///////////////////////////////////////////////
//:: Henchmen Popups: Conversation Exit / Abort
//:: cex_hench_popups.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Make the henchrun to the player once they've
     said their line.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: May 9, 2005
//:://////////////////////////////////////////////

void main()
{

    object oHench = GetLastSpeaker();
    object oPC = GetMaster(oHench);
    object oTrigger = GetLocalObject(OBJECT_SELF, "oPopUpTrigger");

    //Move the henchman to the player.
    AssignCommand(oHench, ActionMoveToObject(oPC, TRUE));

    //Flag the DoOnce on the trigger.
    SetLocalInt(oTrigger, "bFireOnce", TRUE);

    //Clear oPopUpTrigger to avoid future confusion.
    SetLocalObject(OBJECT_SELF, "oPopUpTrigger", OBJECT_INVALID);
}
