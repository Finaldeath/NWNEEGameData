//::///////////////////////////////////////////////
//:: cut_a1garmwin
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Garm defeats the player and initiates dialog.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sShoutString = "I have you now fool!";

// remove ALL effect
void RemoveEffects (object oPC);

void main()
{
    object oWayCam = GetWaypointByTag("a1_endfghtcam");
    object oWayPC01 = GetWaypointByTag("a1_fghtend01");
    object oWayPC02 = GetWaypointByTag("a1_fghtend02");
    object oWayGrm01 = GetWaypointByTag("a1_garmend01");

    location lCam = GetLocation(oWayCam);
    location lPC1 = GetLocation(oWayPC01);
    location lPC2 = GetLocation(oWayPC02);
    location lGrm = GetLocation(oWayGrm01);

    object oGarm = GetObjectByTag("a1_garmclone");
    object oPC = OBJECT_SELF;
    object oClone = CopyObject(oPC, lPC1, OBJECT_INVALID, "A1PC_CLONE");

    float fCamFace = GetFacing(oWayCam);
    float fPCFace = GetFacing(oWayPC02);
    float fGrmFace = GetFacing(oWayGrm01);

    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);

    FadeToBlack(oPC, FADE_SPEED_FAST);
    SetCutsceneMode(oPC, TRUE);

    DelayCommand(1.0f, AssignCommand(oPC, RemoveEffects(oPC)));
    DelayCommand(1.0f, AssignCommand(oGarm, RemoveEffects(oGarm)));
    DelayCommand(1.0f, AssignCommand(oClone, RemoveEffects(oClone)));

    DelayCommand(1.4f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPC));
    DelayCommand(1.4f, AssignCommand(oPC, JumpToLocation(lCam)));
    DelayCommand(1.4f, AssignCommand(oGarm, JumpToLocation(lGrm)));
    DelayCommand(1.4f, AssignCommand(oClone, JumpToLocation(lPC2)));

    DelayCommand(1.6f, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(1.6f, AssignCommand(oGarm, SurrenderToEnemies()));
    DelayCommand(1.6f, AssignCommand(oGarm, ClearAllActions(TRUE)));
    DelayCommand(1.6f, AssignCommand(oClone, ClearAllActions(TRUE)));

    DelayCommand(1.8f, SetCameraFacing(fCamFace, 8.0f, 75.0f, CAMERA_TRANSITION_TYPE_SNAP));
    DelayCommand(1.8f, AssignCommand(oGarm, SetFacing(fGrmFace)));
    DelayCommand(1.8f, AssignCommand(oClone, SetFacing(fPCFace)));

    DelayCommand(2.0f, AssignCommand(oClone,
        PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0f, 5.0f)));

    DelayCommand(4.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oClone));
    DelayCommand(3.7f, AssignCommand(oPC, FadeFromBlack(oPC)));

    DelayCommand(4.5f, AssignCommand(oGarm, SpeakString(sShoutString)));
    DelayCommand(6.5f, AssignCommand(oClone, PlayVoiceChat(VOICE_CHAT_NEARDEATH, oClone)));

    DelayCommand(8.7f, AssignCommand(oPC, ActionStartConversation(oGarm, "a1_garmsurr")));
}


void RemoveEffects (object oPC)
{
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
        DelayCommand(0.1f, RemoveEffect(oPC, eEffect));
        eEffect = GetNextEffect(oPC);
    }
}
