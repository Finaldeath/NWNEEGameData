//::///////////////////////////////////////////////
//:: cut_a1_escapeb
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has stolen the wood and is working
    to build a raft with Edgrimm.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// oVO1: "To be marooned on an island"
// oVO2: "with none but a maddened dwarf and his illusions to aid ye"
// oVO3: "be a fate worse than death itself."
// oVO4: "Aye, their actions were clumsy"
// oVO5: "and their intellect left much to be desired"
// oVO6: "but, with time, all things be possible"
// oVO7: "and, before long, the raft was built."
const float f_VO_LENGTH_1 = 2.7;  // pp1_allendry022
const float f_VO_LENGTH_2 = 4.36; // pp1_allendry033
const float f_VO_LENGTH_3 = 2.87; // pp1_allendry024
const float f_VO_LENGTH_4 = 3.1; // 2.99 + pause -- pp1_allendry034
const float f_VO_LENGTH_5 = 3.43; // pp1_allendry026
const float f_VO_LENGTH_6 = 4.47; // pp1_allendry035
const float f_VO_LENGTH_7 = 3.07; // pp1_allendry028

void ApplyVFXToObject (int iVFX, object oTarget);
void CreatePlacable(string sPlacable);
void DestroySacredWood();

void main()
{
    object oVO1 = GetObjectByTag("pp1_allendry022");
    object oVO2 = GetObjectByTag("pp1_allendry033");
    object oVO3 = GetObjectByTag("pp1_allendry024");
    object oVO4 = GetObjectByTag("pp1_allendry034");
    object oVO5 = GetObjectByTag("pp1_allendry026");
    object oVO6 = GetObjectByTag("pp1_allendry035");
    object oVO7 = GetObjectByTag("pp1_allendry028");

    object oPC = GetLocalObject(OBJECT_SELF, "A1_ECSPC");

    object oWPPC1 = GetWaypointByTag("A1CUT_PC1");
    object oWPPC1_2 = GetWaypointByTag("A1CUT_PC1_2");
    object oWPPC2 = GetWaypointByTag("A1CUT_PC2");
    object oWPPC2_2 = GetWaypointByTag("A1CUT_PC2_2");
    object oWPPC3 = GetWaypointByTag("A1CUT_PC3");
    object oWPPC3_2 = GetWaypointByTag("A1CUT_PC3_2");
    object oWPPC4 = GetWaypointByTag("A1CUT_PC4");
    object oWPPC4_2 = GetWaypointByTag("A1CUT_PC4_2");

    object oWPGarm = GetWaypointByTag("A1CUT_NPC1");
    object oWPGarm2 = GetWaypointByTag("A1CUT_NPC1_2");
    object oWPEdgrim = GetWaypointByTag("A1CUT_NPC2");
    object oWPEdgrim2 = GetWaypointByTag("A1CUT_NPC2_2");
    object oWPEdgrim3 = GetWaypointByTag("A1CUT_NPC2_3");

    object oWPIllusion1 = GetWaypointByTag("A1CUT_NPCSPW1");
    object oWPIllusion1Spwn = GetWaypointByTag("A1CUT_NPCSPW1A");
    object oWPIllusion1B = GetWaypointByTag("A1CUT_NPCSPW1B");
    object oWPIllusion1C = GetWaypointByTag("A1CUT_NPCSPW1C");
    object oWPIllusion1D = GetWaypointByTag("A1CUT_NPCSPW1D");

    object oWPIllusion2 = GetWaypointByTag("A1CUT_NPCSPW2");
    object oWPIllusion2Spwn = GetWaypointByTag("A1CUT_NPCSPW2A");
    object oWPIllusion2B = GetWaypointByTag("A1CUT_NPCSPW2B");
    object oWPIllusion2C = GetWaypointByTag("A1CUT_NPCSPW2C");
    object oWPIllusion2D = GetWaypointByTag("A1CUT_NPCSPW2D");

    object oWPIllusion3 = GetWaypointByTag("A1CUT_NPCSPW3");
    object oWPIllusion3Spwn = GetWaypointByTag("A1CUT_NPCSPW3A");
    object oWPIllusion3B = GetWaypointByTag("A1CUT_NPCSPW3B");
    object oWPIllusion3C = GetWaypointByTag("A1CUT_NPCSPW3C");
    object oWPIllusion3D = GetWaypointByTag("A1CUT_NPCSPW3D");

    object oWPIllusion4 = GetWaypointByTag("A1CUT_NPCSPW4");
    object oWPIllusion4Spwn = GetWaypointByTag("A1CUT_NPCSPW4A");
    object oWPIllusion4B = GetWaypointByTag("A1CUT_NPCSPW4B");
    object oWPIllusion4C = GetWaypointByTag("A1CUT_NPCSPW4C");
    object oWPIllusion4D = GetWaypointByTag("A1CUT_NPCSPW4D");

    location lPC1 = GetLocation(oWPPC1);
    location lPC2 = GetLocation(oWPPC2);
    location lPC3 = GetLocation(oWPPC3);
    location lPC4 = GetLocation(oWPPC4);

    location lGarm = GetLocation(oWPGarm);
    location lEdgrim = GetLocation(oWPEdgrim);

    location lIll1Spwn = GetLocation(oWPIllusion1Spwn);
    location lIll2Spwn = GetLocation(oWPIllusion2Spwn);
    location lIll3Spwn = GetLocation(oWPIllusion3Spwn);
    location lIll4Spwn = GetLocation(oWPIllusion4Spwn);

    effect eCutGhost = EffectCutsceneGhost();

    object oPCClone1 = cs_CopyPC(lPC1, FALSE, cs_GetPCNumber(oPC));
    object oPCClone2, oPCClone3, oPCClone4;

    if (cs_GetPCNumber(oPC) != 2)
        oPCClone2 = cs_CopyPC(lPC2, FALSE, 2);
    else
        oPCClone2 = cs_CopyPC(lPC2, FALSE, 1);

    if (cs_GetPCNumber(oPC) != 3)
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 3);
    else
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 2);

    if (cs_GetPCNumber(oPC) != 4)
        oPCClone4 = cs_CopyPC(lPC2, FALSE, 4);
    else
        oPCClone4 = cs_CopyPC(lPC2, FALSE, 3);

    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutgarm", lGarm);
    object oEdgrimm = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutedgrimm", lEdgrim);

    object oIllution1 = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutillusion1", lIll1Spwn);
    object oIllution2 = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutillusion2", lIll2Spwn);
    object oIllution3 = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutillusion3", lIll3Spwn);
    object oIllution4 = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutillusion4", lIll4Spwn);

    object oVFXTarg1 = GetObjectByTag("a1_cut_vfxtarg1");
    object oVFXTarg2 = GetObjectByTag("a1_cut_vfxtarg2");
    object oVFXTarg3 = GetObjectByTag("a1_cut_vfxtarg3");
    object oVFXTarg4 = GetObjectByTag("a1_cut_vfxtarg4");
    object oVFXTarg5 = GetObjectByTag("a1_cut_vfxtarg5");

//------------------------------------------------------------------------------
    float fDelay;

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_SoundObjectPlay(7.3, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    cs_SoundObjectPlay(f_VO_LENGTH_2, oVO3);
    cs_ResetDelay();

    cs_CameraUseCameraWaypoint(0.5, 10);
    cs_CameraSetFacing(0.25, 95.0f, 5.0f, 60.0f, CAMERA_TRANSITION_TYPE_SNAP);
    cs_CameraSetFacing(0.25, 115.0f, 9.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK);

    cs_ActionPlayAnimation(0.0, oGarm, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0f, 4.0f);
    cs_ActionPlayAnimation(3.0, oEdgrimm, ANIMATION_LOOPING_CONJURE1, 1.0f, 2.0f);
    //cs_PlaySound(4.0f, oPC, "a1_cutwhistle");

    cs_JumpToLocation(2.0, oIllution1, GetLocation(oWPIllusion1));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3, oVFXTarg1);
    cs_JumpToLocation(0.2, oIllution2, GetLocation(oWPIllusion2));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3, oVFXTarg2);
    cs_JumpToLocation(0.2, oIllution3, GetLocation(oWPIllusion3));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3, oVFXTarg3);
    cs_JumpToLocation(0.2, oIllution4, GetLocation(oWPIllusion4));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3, oVFXTarg4);

    cs_ActionSetFacingPoint(0.4, oIllution1, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution2, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution3, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution4, GetPosition(oEdgrimm));

    cs_ActionPlayAnimation(0.5, oEdgrimm, ANIMATION_FIREFORGET_READ, 1.0f, 1.0f);
    cs_ActionPlayAnimation(2.1, oEdgrimm, ANIMATION_FIREFORGET_VICTORY1, 1.0f, 1.0f);

    cs_ActionMoveToObject(2.1, oIllution1, oWPIllusion1B, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution2, oWPIllusion2B, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution3, oWPIllusion3B, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution4, oWPIllusion4B, TRUE, 0.0f);

    cs_ActionPlayAnimation(1.1, oIllution1, ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f);
    cs_ActionPlayAnimation(0.0, oIllution2, ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f);
    cs_ActionPlayAnimation(0.0, oIllution3, ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f);
    cs_ActionPlayAnimation(0.0, oIllution4, ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f);

    cs_CameraDoFade(2.1, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_chiseling1");
    cs_PlaySound(0.0, cs_GetPCObject(), "as_cv_sawing1");
    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_woodbreak1");

    fDelay = cs_GetDelay();
    DelayCommand(fDelay, CreatePlacable("a1_cutplc1b"));
    DelayCommand(fDelay, DestroySacredWood());
    cs_CameraSetFacing(0.0, 95.0f, 5.0f, 60.0f, CAMERA_TRANSITION_TYPE_SNAP);
    cs_JumpToLocation(0.0, oIllution1, GetLocation(oWPIllusion1));
    cs_JumpToLocation(0.0, oIllution2, GetLocation(oWPIllusion2));
    cs_JumpToLocation(0.0, oIllution3, GetLocation(oWPIllusion3));
    cs_JumpToLocation(0.0, oIllution4, GetLocation(oWPIllusion4));
    cs_CameraSetFacing(1.3, 115.0f, 9.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

    cs_ActionPlayAnimation(0.5, oGarm, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0f, 4.0f);

    cs_ActionSetFacingPoint(1.0, oIllution1, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution2, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution3, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution4, GetPosition(oEdgrimm));

    cs_ActionPlayAnimation(0.4, oEdgrimm, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 2.0f);

    cs_ActionMoveToObject(2.0, oIllution1, oWPIllusion1B, FALSE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution2, oWPIllusion2B, FALSE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution3, oWPIllusion3B, FALSE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution4, oWPIllusion4B, FALSE, 0.0f);

    cs_CameraDoFade(1.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_chiseling2");
    cs_PlaySound(0.0, cs_GetPCObject(), "as_cv_sawing2");
    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_woodbreak2");

    DelayCommand(cs_GetDelay(), CreatePlacable("a1_cutplc2b"));
    cs_CameraSetFacing(0.0, 95.0f, 5.0f, 60.0f, CAMERA_TRANSITION_TYPE_SNAP);
    cs_JumpToLocation(0.0, oIllution1, GetLocation(oWPIllusion1));
    cs_JumpToLocation(0.0, oIllution2, GetLocation(oWPIllusion2));
    cs_JumpToLocation(0.0, oIllution3, GetLocation(oWPIllusion3));
    cs_JumpToLocation(0.0, oIllution4, GetLocation(oWPIllusion4));
    cs_CameraSetFacing(1.3, 115.0f, 9.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

    cs_ActionPlayAnimation(2.0, oEdgrimm, ANIMATION_FIREFORGET_READ);

    cs_ActionSetFacingPoint(1.0, oIllution1, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution2, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution3, GetPosition(oEdgrimm));
    cs_ActionSetFacingPoint(0.2, oIllution4, GetPosition(oEdgrimm));

    cs_ActionPlayAnimation(0.9, oEdgrimm, ANIMATION_LOOPING_PAUSE_TIRED, 1.0f, 4.0f);

    cs_ActionPlayAnimation(4.5, oEdgrimm, ANIMATION_LOOPING_CONJURE1, 1.0f, 4.0f);

    cs_JumpToLocation(3.0, oIllution1, GetLocation(oWPIllusion1Spwn));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_UNSUMMON, oVFXTarg1);
    cs_JumpToLocation(0.2, oIllution2, GetLocation(oWPIllusion2Spwn));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_UNSUMMON, oVFXTarg2);
    cs_JumpToLocation(0.2, oIllution3, GetLocation(oWPIllusion3Spwn));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_UNSUMMON, oVFXTarg3);
    cs_JumpToLocation(0.2, oIllution4, GetLocation(oWPIllusion4Spwn));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_UNSUMMON, oVFXTarg4);

    cs_ActionPlayAnimation(0.4, oEdgrimm, ANIMATION_FIREFORGET_READ, 0.5f);

    fDelay = cs_GetDelay();
    cs_SoundObjectPlay(0.0, oVO4);
    cs_SoundObjectPlay(f_VO_LENGTH_4, oVO5);
    cs_ResetDelay(-1.0, fDelay);

    cs_ActionPlayAnimation(3.0, oEdgrimm, ANIMATION_LOOPING_CONJURE1, 1.0f, 3.5f);

    cs_ApplyVFXToObject(3.0, DURATION_TYPE_PERMANENT, VFX_FNF_SUMMONDRAGON, oVFXTarg5);
    DelayCommand(cs_GetDelay()+0.2, CreatePlacable("a1_cutraft"));

    cs_ActionPlayAnimation(2.0, oEdgrimm, ANIMATION_FIREFORGET_VICTORY2);
    cs_ActionPlayAnimation(0.1, oPCClone1, ANIMATION_FIREFORGET_VICTORY3);
    cs_ActionPlayAnimation(0.1, oPCClone2, ANIMATION_FIREFORGET_VICTORY2);
    cs_ActionPlayAnimation(0.0, oPCClone4, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.1, oPCClone3, ANIMATION_FIREFORGET_VICTORY3);
    cs_ActionPlayAnimation(0.2, oWPGarm, ANIMATION_FIREFORGET_VICTORY1);

    cs_CameraDoFade(2.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);
    fDelay = cs_GetDelay();
    cs_SoundObjectPlay(0.0, oVO6);
    cs_SoundObjectPlay(f_VO_LENGTH_6, oVO7);
    cs_ResetDelay(-1.0, fDelay);
    cs_CameraUseCameraWaypoint(1.7, 20);

    cs_ApplyEffectToObject(0.1, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone2);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone3);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone4);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oGarm);

    cs_JumpToLocation(0.1, oPCClone1, GetLocation(oWPPC1_2));
    cs_JumpToLocation(0.0, oPCClone2, GetLocation(oWPPC2_2));
    cs_JumpToLocation(0.0, oPCClone3, GetLocation(oWPPC3_2));
    cs_JumpToLocation(0.0, oPCClone4, GetLocation(oWPPC4_2));

    cs_JumpToLocation(0.0, oGarm, GetLocation(oWPGarm2));
    cs_JumpToLocation(0.0, oEdgrimm, GetLocation(oWPEdgrim2));

    cs_JumpToLocation(0.0, oIllution1, GetLocation(oWPIllusion1C));
    cs_JumpToLocation(0.0, oIllution2, GetLocation(oWPIllusion2C));
    cs_JumpToLocation(0.0, oIllution3, GetLocation(oWPIllusion3C));
    cs_JumpToLocation(0.0, oIllution4, GetLocation(oWPIllusion4C));
    cs_CameraSetFacing(0.5, 65.0f, 15.0f, 75.0f, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

// end, on raft

    cs_ActionMoveToObject(0.0, oIllution2, oWPIllusion2D, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution3, oWPIllusion3D, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution4, oWPIllusion4D, TRUE, 0.0f);
    cs_ActionMoveToObject(0.3, oEdgrimm, oWPEdgrim3, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oIllution1, oWPIllusion1D, TRUE, 0.0f);

    cs_ActionPlayAnimation(0.5, oEdgrimm, ANIMATION_FIREFORGET_GREETING);
    cs_ActionPlayAnimation(0.0, oIllution1, ANIMATION_FIREFORGET_GREETING);
    cs_ActionPlayAnimation(0.0, oIllution2, ANIMATION_FIREFORGET_GREETING);
    cs_ActionPlayAnimation(0.0, oIllution3, ANIMATION_FIREFORGET_GREETING);
    cs_ActionPlayAnimation(0.0, oIllution4, ANIMATION_FIREFORGET_GREETING);


    cs_CameraDoFade(6.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_SLOWEST);

    cs_SoundObjectStop(3.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_SoundObjectStop(0.0, oVO7);

    cs_EndCutscene(0.1, FALSE);
}

void ApplyVFXToObject (int iVFX, object oTarget)
{
    location lLoc = GetLocation(oTarget);
    effect eVFX = EffectVisualEffect(iVFX);

    //SendMessageToPC(GetFirstPC(), "ApplyVFXToObject Fired: VFX = '"
    //    + IntToString(iVFX) + "' Target = '" + GetTag(oTarget));

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lLoc, 3.0f);
}

void CreatePlacable(string sPlaceable)
{
    object oArea = OBJECT_SELF;
    string sOld = GetLocalString(oArea, "sPlaceable");
    object oDestroy, oTarget, oNew;
    location lTarget;

    oDestroy = GetObjectByTag(sOld);
    oTarget = GetObjectByTag("A1CUT_RAFT");
    lTarget = GetLocation(oTarget);

    DestroyObject(oDestroy);
    oNew = CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lTarget);
    SetLocalString(oArea, "sPlaceable", GetTag(oNew));
}

void DestroySacredWood()
{
    object oWood;

    oWood = GetObjectByTag("a1plc_sacwood", 0);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 1);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 2);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 3);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 4);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 5);
    DestroyObject(oWood);
}
