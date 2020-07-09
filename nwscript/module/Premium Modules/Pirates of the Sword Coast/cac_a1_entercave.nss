//::///////////////////////////////////////////////
//:: Act 1: Enter the Jelly Cave via Conversation
//:: CAC_A1_EnterCave.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Transition the player into the Jelly Cave
     now that they've been warned of the dangers
     via conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 23, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    AssignCommand(oPC,JumpToObject(oTarget));
}
