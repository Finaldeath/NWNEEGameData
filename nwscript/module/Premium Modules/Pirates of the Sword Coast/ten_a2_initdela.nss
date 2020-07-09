//::///////////////////////////////////////////////
//:: ten_a2_initdela
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have Vengaul or Honey Pea init with the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
//#include "_inc_cutscene"
#include "_inc_generic"

void CutsceneModeFailSafe();

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetEnteringObject();
    object oSpeaker = GetLocalObject(GetArea(oSelf), "NPC_BANDIT");
    int iDoOnce = GetLocalInt(oSelf, "ten_a2_initdela");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce != TRUE))
    {
        SetLocalInt(oSelf, "ten_a2_initdela", TRUE);

        // don't want other players to interrupt
        SetLocalInt(oSpeaker, "NO_TALKIE", TRUE);
        AssignCommand(oSpeaker, ClearAllActions(TRUE));
        AssignCommand(oSpeaker, ActionStartConversation(oPC));
        // briefly put the pc in cutscene mode so we can ensure that
        // this conversation fires
        SetCutsceneMode(oPC);
        AssignCommand(oPC, ClearAllActions(TRUE));
        // this is a failsafe
        SetLocalInt(oPC, "ten_a2_initdela_cutscene_check", TRUE);
        DelayCommand(20.0, AssignCommand(oPC, CutsceneModeFailSafe()));
    }
}

// JE: This is a failsafe measure, to make absolutely sure that the player
// can't get stuck in cutscene mode, if for some weird reason the main
// scripting fails
// This function is run on the PC in question.
void CutsceneModeFailSafe()
{
    // if this variable is still set, that's bad - kick the player out
    // of cutscene mode
    if(GetLocalInt(OBJECT_SELF, "ten_a2_initdela_cutscene_check"))
    {
        SetCutsceneMode(OBJECT_SELF, FALSE);
    }
}
