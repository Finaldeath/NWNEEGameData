//::///////////////////////////////////////////////
//:: cut_garmfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This cutscene is the intro movie for the Garm
    Arena fight in the troglodyte stronghold.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string sRand01 = "For Laogzed!";
const string sRand02 = "Yesss, you look deliciousss, don't you...";
const string sRand03 = "Garm ssshall feassst tonight!";
const string sRand04 = "My sssteel ssshall end you!";

void main()
{
    object oArea = OBJECT_SELF;
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    object oGarm = GetObjectByTag("a1_garmfighter");
    object oDoor = GetObjectByTag("a1_fightgate");
    object oGuard = GetObjectByTag("a1_gateliz");

    object oWP_Pos01 = GetWaypointByTag("a1_fghtsrt01");
    object oWP_Pos02 = GetWaypointByTag("a1_fghtsrt02");
    object oWP_Pos03 = GetWaypointByTag("a1_fghtsrt03");

    object oWP_Garm = GetWaypointByTag("a1_garmstart");
    object oWP_Cam01 = GetWaypointByTag("a1_fcamera_pos_1");
    object oWP_Cam02 = GetWaypointByTag("a1_fcamera_pos_2");

    location lPos2 = GetLocation(oWP_Pos02);
    location lPos3 = GetLocation(oWP_Pos03);
    location lPCCopy = GetLocation(oWP_Pos01);
    location lGarmSpawn = GetLocation(oWP_Garm);

    int iRand = Random(4);
    int iLevel = 0;

    SetImmortal(oFighter, TRUE);
    oFighter = CopyObject(oFighter, lPCCopy);
    RemoveFromParty(oFighter);
    AssignCommand(oFighter, SetIsDestroyable(TRUE, FALSE, FALSE));

    oGarm = CopyObject(oGarm, lGarmSpawn, oGarm, "a1_garmclone");

    //GiveXPToCreature(oGarm, GetXP(oFighter));
    iLevel = GetHitDice(oGarm);
    while (iLevel < GetHitDice(oFighter))
    {
        iLevel = LevelUpHenchman(oGarm);
    }

    ForceRest(oGarm);

    cs_CameraActionJumpToObject(0.2, oWP_Cam01);
    cs_CameraSetFacing(0.5f, 0.0f, 8.0f, 80.0f, CAMERA_TRANSITION_TYPE_SNAP);

    cs_CameraSetFacing(1.0f, 20.0f, 12.0f, 65.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);
    cs_CameraActionMoveToObject(1.0, oWP_Cam02);
    cs_ActionMoveToLocation(1.0, oFighter, lPos2, TRUE);

    cs_ActionPlayAnimation(3.0f, oGarm, ANIMATION_FIREFORGET_VICTORY1, 1.0f, 6.0f);

    cs_ActionMoveToLocation(7.5, oFighter, lPos3);
    cs_ActionCloseDoor(7.5, oDoor, oDoor);
    cs_SetLocked(8.5, oDoor, TRUE);

    cs_ActionSetFacing(10.0f, oGarm, 270.0f);
    cs_ActionSetFacing(10.0f, oFighter, 90.0f);

    cs_ActionPlayAnimation(12.0f, oGarm, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 3.0f);
    cs_ActionPlayAnimation(15.0f, oGarm, ANIMATION_LOOPING_TALK_NORMAL, 1.0f, 2.0f);

    if (iRand == 0)
    {
        cs_SpeakString(12.0f, oGarm, sRand01);
        cs_PlayVoiceChat(15.0f, oFighter, VOICE_CHAT_BATTLECRY1);
    }
    else if (iRand == 1)
    {
        cs_SpeakString(12.0f, oGarm, sRand02);
        cs_PlayVoiceChat(15.0f, oFighter, VOICE_CHAT_BATTLECRY2);
    }
    else if (iRand == 2)
    {
        cs_SpeakString(12.0f, oGarm, sRand03);
        cs_PlayVoiceChat(15.0f, oFighter, VOICE_CHAT_BATTLECRY3);
    }
    else if (iRand == 3)
    {
        cs_SpeakString(12.0f, oGarm, sRand04);
        cs_PlayVoiceChat(15.0f, oFighter, VOICE_CHAT_TAUNT);
    }

    cs_CameraDoFade(17.0f, CS_FADE_TYPE_TO_BLACK);
    cs_DestroyObject(17.5f, oFighter);
    cs_EndCutscene(18.0f, FALSE, TRUE);
}
