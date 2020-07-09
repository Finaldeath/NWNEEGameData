//::///////////////////////////////////////////////
//:: cut_a3_seige3
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawn Sahaugin and start the trapped sequence.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string sGarmString1 = "Ssservantsss of the warmblood goddesss!";
const string sSahaugin1 = "Lung-things still below, glub glub!";
const string sSahaugin2 = "Glub glub? I'll deal with them and see that they're disposed of...";
const string sSahaugin3 = "Bore the holes, glub glub, and send this shipwreck to the deeps!";
const string sNisarString1 = "Damned fish! Man the bilge pump and patch the holes, Cap'n! We'll keep 'em occupied!";

void CreateHole(location lTarg);

void main()
{
    string sNPCTag;

    effect eDamage = EffectDamage(1000);

    object oArea = OBJECT_SELF;
    object oModule = GetModule();
    object oLadder = GetObjectByTagInArea("a3_seigeladder");

    object oRealNisar = GetObjectByTagInArea("a2_hench_nisar");
    object oRealGarm = GetObjectByTagInArea("a1_hench_garm");

    // K2 - In responce to 746 I am insuring that the real garm
    // and nisar are not immortal during the fight.
    SetImmortal(oRealNisar, FALSE);
    SetImmortal(oRealGarm, FALSE);

    object oNisar = GetObjectByTag("A3_SGCUT_NISAR");
    object oGarm = GetObjectByTag("A3_SGCUT_GARM");

    object oWPSpwnShgn1 = GetObjectByTagInArea("A3_SPAWNSSAHAUGIN1");
    object oWPSpwnShgn2 = GetObjectByTagInArea("A3_SPAWNSSAHAUGIN2");
    object oWPSpwnShgn3 = GetObjectByTagInArea("A3_SPAWNSSAHAUGIN3");

    object oWPShgn1 = GetObjectByTagInArea("A3_SEIGESAHAUGIN1");
    object oWPShgn2 = GetObjectByTagInArea("A3_SEIGESAHAUGIN2");
    object oWPShgn3 = GetObjectByTagInArea("A3_SEIGESAHAUGIN3");

    effect eAppear1 = EffectDisappearAppear(GetLocation(oWPShgn1));
    effect eAppear2 = EffectDisappearAppear(GetLocation(oWPShgn2));
    effect eAppear3 = EffectDisappearAppear(GetLocation(oWPShgn3));

    object oWPHole1 = GetObjectByTagInArea("A3_HOLEWAYPNT1");
    object oWPHole2 = GetObjectByTagInArea("A3_HOLEWAYPNT2");
    object oWPHole3 = GetObjectByTagInArea("A3_HOLEWAYPNT3");
    object oWPHole4 = GetObjectByTagInArea("A3_HOLEWAYPNT4");

    object oWPPlayer1_3 = GetObjectByTag("A3_SEIGE_PC1_3");
    object oWPPlayer2_3 = GetObjectByTag("A3_SEIGE_PC2_3");
    object oWPPlayer3_3 = GetObjectByTag("A3_SEIGE_PC3_3");
    object oWPPlayer4_3 = GetObjectByTag("A3_SEIGE_PC4_3");

    object oPCCopy1 = GetLocalObject(oArea, "a3_oPCCopy1");
    object oPCCopy2 = GetLocalObject(oArea, "a3_oPCCopy2");
    object oPCCopy3 = GetLocalObject(oArea, "a3_oPCCopy3");
    object oPCCopy4 = GetLocalObject(oArea, "a3_oPCCopy4");

    object oSahaugin1 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutseiges",
        GetLocation(oWPSpwnShgn1));
    object oSahaugin2 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutseiges",
        GetLocation(oWPSpwnShgn2));
    object oSahaugin3 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutseiges",
        GetLocation(oWPSpwnShgn3));

    //Actual cutscene stuff!
    cs_ApplyEffectToObject(0.5f, DURATION_TYPE_TEMPORARY, eAppear1, oSahaugin1, 2.6f);
    cs_ApplyEffectToObject(0.5f, DURATION_TYPE_TEMPORARY, eAppear2, oSahaugin2, 2.5f);
    cs_ApplyEffectToObject(0.5f, DURATION_TYPE_TEMPORARY, eAppear3, oSahaugin3, 2.4f);

    cs_CameraSetFacing(1.0f, 130.0f, 9.0f, 50.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_ApplyEffectToObject(1.0f, DURATION_TYPE_INSTANT, eDamage, oLadder);
    cs_ActionPlayAnimation(3.0f, oSahaugin2, ANIMATION_FIREFORGET_TAUNT);

    cs_ActionSpeakString(4.0f, oGarm, sGarmString1);
    cs_ActionSpeakString(7.0f, oSahaugin2, sSahaugin1);
    cs_ActionPlayAnimation(7.0f, oSahaugin1, ANIMATION_LOOPING_TALK_FORCEFUL);

    cs_ActionSpeakString(10.0f, oSahaugin3, sSahaugin2);
    cs_ActionSpeakString(14.0f, oSahaugin1, sSahaugin3);
    cs_ActionSpeakString(18.0f, oNisar, sNisarString1);

    DelayCommand(21.0f, CreateHole(GetLocation(oWPHole1)));

    cs_CameraDoFade(22.7, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(23.0f, 4);
    cs_CameraDoFade(23.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);
    DelayCommand(23.0f, CreateHole(GetLocation(oWPHole2)));

    cs_CameraDoFade(25.7, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(26.0f, 5);
    cs_CameraDoFade(26.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);
    DelayCommand(26.0f, CreateHole(GetLocation(oWPHole3)));

    cs_CameraDoFade(28.7, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(29.0f, 6);
    cs_CameraDoFade(29.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);
    DelayCommand(29.0f, CreateHole(GetLocation(oWPHole4)));

    cs_CameraDoFade(32.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_DestroyObject(32.0f, oSahaugin1);
    cs_DestroyObject(32.0f, oSahaugin2);
    cs_DestroyObject(32.0f, oSahaugin3);

    cs_JumpToObject(32.0f, oRealNisar, oNisar);
    cs_JumpToObject(32.0f, oRealGarm, oGarm);

    cs_DestroyObject(33.0f, oNisar);
    cs_DestroyObject(33.0f, oGarm);

    cs_JumpToObject(34.0f, cs_GetPCObject(0), oWPPlayer1_3);
    cs_JumpToObject(34.0f, cs_GetPCObject(1), oWPPlayer2_3);
    cs_JumpToObject(34.0f, cs_GetPCObject(2), oWPPlayer3_3);
    cs_JumpToObject(34.0f, cs_GetPCObject(3), oWPPlayer4_3);

    cs_DestroyObject(34.5f, oPCCopy1);
    cs_DestroyObject(34.5f, oPCCopy2);
    cs_DestroyObject(34.5f, oPCCopy3);
    cs_DestroyObject(34.5f, oPCCopy4);

    //DelayCommand(35.0f, ExecuteScript("exe_a3_sgstrt", OBJECT_SELF));
    cs_EndCutscene(35.0f, TRUE, TRUE, FADE_SPEED_FASTEST);
}

void CreateHole(location lTarg)
{
    effect eWater = EffectVisualEffect(137);
    object oHole = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_seigehole", lTarg);

    DelayCommand(0.2f, AssignCommand(oHole, PlaySound("as_cv_sawing1")));
    DelayCommand(0.5f, AssignCommand(oHole, PlaySound("as_cv_sawing2")));
    DelayCommand(1.5f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWater, oHole));
}
