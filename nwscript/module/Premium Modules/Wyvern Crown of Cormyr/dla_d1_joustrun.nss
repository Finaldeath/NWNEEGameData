//::///////////////////////////////////////////////
//:: dla_d1_joustrun
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    This is for everything that happens in jousting.
    THis is the plan. Camera pans at PC then at opponent. Then the two
    ride to each other. Hit a trigger in the middle and then time freeze
    and then pick your option of where you wanna hit
    then animations will play! based on conversation choice.
*/
//:://////////////////////////////////////////////
//:: Created By: Takamura
//:: Created On: 1 November 2005
//:://////////////////////////////////////////////
//Gale 17 Jan 2006: Added support to multiple opponents

#include "dla_i0_joust"

void main()
{
    float fCueTime = 0.0;
    object oPC = GetPCSpeaker();
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    object oPCWPT = GetWaypointByTag("DLA_JOUST_PC_WPT2");
    object oOPWPT = GetWaypointByTag("DLA_JOUST_OP_WPT2");
//    object oRef = GetObjectByTag("DLA_JOUST_REF");

//    RemoveEffectsByCreator(oPC, oRef);

    // Start Battle Music
    MusicBattlePlay(GetArea(oPC));

    DLA_DoOutcome(oPC, oOP);
    DLA_DoOutcome(oOP, oPC);
    DLA_ScoreKeep(oPC, oOP);

    //Set the camera initially
    SetCameraMode(oPC, CAMERA_MODE_TOP_DOWN);
//    AssignCommand(oPC, SetCameraFacing(100.0, 8.0, 75.0, CAMERA_TRANSITION_TYPE_VERY_FAST));;
    //camera stuff
    DelayCommand(fCueTime+=4.0, AssignCommand(oPC, SetCameraFacing(100.0, 10.0, 75.0, CAMERA_TRANSITION_TYPE_VERY_FAST)));

    //move toward each other after fading out/in
    DelayCommand(fCueTime+=1.5, AssignCommand(oPC, ActionMoveToObject(oPCWPT, TRUE)));
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, ActionMoveToObject(oOPWPT, TRUE)));

    //more camera stuff
    DelayCommand(fCueTime+=0.5, AssignCommand(oPC, SetCameraFacing(250.0, 15.0, 80.0, CAMERA_TRANSITION_TYPE_MEDIUM)));
    //DelayCommand(8.0, SetCameraFacing(230.0, 15.0, 89.0, CAMERA_TRANSITION_TYPE_MEDIUM));

    //from this point on conversation will decide fate of battle via trigger

// Uncomment only for debugging
// SetCutsceneMode(oPC, FALSE);
}
