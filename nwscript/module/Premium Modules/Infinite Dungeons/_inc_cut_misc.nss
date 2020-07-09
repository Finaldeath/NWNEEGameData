//::///////////////////////////////////////////////
//:: Miscellaneous cutscene function include file
//:: _inc_cut_level2.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the include file for miscellaneous
    cutscene functions and constants. It should
    not be directly included, include
    "_inc_cutscene" instead.

    Direct includes:
      - _inc_generic: Generic functions
    Indirect includes:
      - _inc_array: Array functions
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////
#include "_inc_generic"

const int CS_DELAY_TYPE_UNDEFINED = 0;
const int CS_DELAY_TYPE_TOTAL = 1;
const int CS_DELAY_TYPE_INCREMENTED = 2;

// If a global delay type has not been set using cs_SetDefaultDelayType(),
// cutscenes will use the delay type specified here.
const int CS_DEFAULT_DELAY_TYPE = CS_DELAY_TYPE_TOTAL;

const int CS_FADE_TYPE_NONE = 0;
const int CS_FADE_TYPE_BLACK = 1;
const int CS_FADE_TYPE_FROM_BLACK = 2;
const int CS_FADE_TYPE_TO_BLACK = 3;

const int CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_DAY = 0x00000001;
const int CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_NIGHT = 0x00000002;
const int CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_DAY = 0x00000004;
const int CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_NIGHT = 0x00000008;
const int CS_AREA_FLAG_AMBIENT_SOUND_PLAY = 0x00000010;
const int CS_AREA_FLAG_MUSIC_CHANGE_DAY = 0x00000020;
const int CS_AREA_FLAG_MUSIC_CHANGE_NIGHT = 0x00000040;
const int CS_AREA_FLAG_MUSIC_PLAY = 0x00000080;
const int CS_AREA_FLAG_MUSIC_BATTLE_CHANGE = 0x00000100;
const int CS_AREA_FLAG_MUSIC_BATTLE_PLAY = 0x00000200;
const int CS_AREA_FLAG_FOG_COLOR_DAY = 0x00000400;
const int CS_AREA_FLAG_FOG_COLOR_NIGHT = 0x00000800;
const int CS_AREA_FLAG_FOG_AMOUNT_DAY = 0x00001000;
const int CS_AREA_FLAG_FOG_AMOUNT_NIGHT = 0x00002000;
const int CS_AREA_FLAG_WEATHER = 0x00004000;
const int CS_AREA_FLAG_SKYBOX = 0x00008000;

const int CS_FLAG_POSITION = 0x00000001;
const int CS_FLAG_FACING = 0x00000002;
const int CS_FLAG_DESTROYED = 0x00000004;
const int CS_FLAG_ANIMATION = 0x00000008;
const int CS_FLAG_DOOR_OPEN_STATE = 0x00000010;
const int CS_FLAG_OBJECT_LOCK_STATE = 0x00000020;
const int CS_FLAG_EFFECT = 0x00000040;
const int CS_FLAG_VFX = 0x00000080;
const int CS_FLAG_USER_DEFINED_EVENT = 0x00000100;
const int CS_FLAG_SOUND = 0x00000200;
const int CS_FLAG_SOUND_VOLUME = 0x00000400;
const int CS_FLAG_CUTSCENE_GHOST_EFFECT = 0x00000800;
const int CS_FLAG_PLOT = 0x00001000;
const int CS_FLAG_IMMORTAL = 0x00002000;
const int CS_FLAG_CREATURE_APPEARANCE = 0x00004000;

const int CS_DOOR_OPEN = 1;
const int CS_DOOR_CLOSED = 2;

const int CS_OBJECT_LOCKED = 1;
const int CS_OBJECT_UNLOCKED = 2;

const int CS_DAYNIGHT_DAY = 1;
const int CS_DAYNIGHT_NIGHT = 2;

const int CS_SOUND_PLAY = 1;
const int CS_SOUND_STOP = 2;

const int CS_OPTION_ASSOCIATE_INVISIBILITY = 1;
const int CS_OPTION_ASSOCIATE_INVISIBILITY_HENCHMEN = 2;
const int CS_OPTION_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION = 3;
const int CS_OPTION_ASSOCIATE_INVISIBILITY_FAMILIAR = 4;
const int CS_OPTION_ASSOCIATE_INVISIBILITY_DOMINATED = 5;
const int CS_OPTION_ASSOCIATE_INVISIBILITY_SUMMONED = 6;
//const int CS_OPTION_ALL_PCS = 7;
const int CS_OPTION_RESTORE_PC_LOCATION = 8;
const int CS_OPTION_REMOVE_PC_POLYMORPH = 9;
const int CS_OPTION_REMOVE_PC_FAMILIAR_POSSESSION = 10;
const int CS_OPTION_REMOVE_PC_BLINDNESS_DARKNESS = 11;

const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY = TRUE;
const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_HENCHMEN = FALSE;
const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION = FALSE;
const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_FAMILIAR = FALSE;
const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_DOMINATED = FALSE;
const int CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_SUMMONED = FALSE;
//const int CS_OPTIONDEFAULT_ALL_PCS = FALSE;
const int CS_OPTIONDEFAULT_RESTORE_PC_LOCATION = FALSE;
const int CS_OPTIONDEFAULT_REMOVE_PC_POLYMORPH = TRUE;
const int CS_OPTIONDEFAULT_REMOVE_PC_FAMILIAR_POSSESSION = TRUE;
const int CS_OPTIONDEFAULT_REMOVE_PC_BLINDNESS_DARKNESS = TRUE;

//const string CS_CAMERA_TAG_POSITION = "cs_camera_pos_";
//const string CS_CAMERA_TAG_FOCUS = "cs_camera_focus_";
// JE: Feb. 7, 2006
// changed these tags so that the system works nicely with Peter's clean-up
// scripting for Infinite Dungeons. This is a module-specific change, and was
// NOT applied to the generic system.
const string CS_CAMERA_TAG_POSITION = "ID1_STATIC_cs_camera_pos_";
const string CS_CAMERA_TAG_FOCUS = "ID1_STATIC_cs_camera_focus_";

const string CS_INVISIBLE_OBJECT_RESREF = "plc_invisobj";
const string CS_INVISIBLE_OBJECT_TAG = "cs_EffectObject";
const string CS_EFFECT_LOCATION_TAG = "cs_EffectLocation";

const string CS_APPLY_VFX_SCRIPT = "_cs_applyvfx";

// variable name constants
const string CS_VAR_AREA_B_CUTSCENE_STARTED = "cs_bCutsceneStarted";
const string CS_VAR_AREA_S_END_SCRIPT = "cs_sEndScript";
const string CS_VAR_AREA_O_EFFECT_OBJECT = "cs_oEffectObject";
const string CS_VAR_AREA_N_ACTOR_NUM = "cs_nActorNum";
const string CS_VAR_AREA_N_CAMERA_MODE = "cs_nCameraMode";
const string CS_VAR_AREA_O_ARRAY_PC = "cs_oPC";
const string CS_VAR_AREA_N_NUM_PC = "cs_nNumPC";
const string CS_VAR_AREA_O_VISIBLE_PC = "cs_oVisiblePC";
const string CS_VAR_AREA_N_CUT_NUMBER = "cs_nCutNumber";
const string CS_VAR_AREA_B_ABORTABLE = "cs_bAbortable";
const string CS_VAR_AREA_B_CUTSCENE_ABORTED = "cs_bCutsceneAborted";
const string CS_VAR_AREA_B_CUTSCENE_ENDED = "cs_bCutsceneEnded";
const string CS_VAR_AREA_F_TOTAL_DELAY = "cs_fTotalDelay";
const string CS_VAR_AREA_L_CAMERA_LOCATION = "cs_lCameraLocation";
const string CS_VAR_AREA_F_CAMERA_DIRECTION = "cs_fCameraDirection";
const string CS_VAR_AREA_F_CAMERA_DISTANCE = "cs_fCameraDistance";
const string CS_VAR_AREA_F_CAMERA_PITCH = "cs_fCameraPitch";
const string CS_VAR_AREA_F_CAMERA_HEIGHT = "cs_fCameraHeight";
const string CS_VAR_AREA_CUTSCENE_SCRIPT_PREFIX = "cs_";
const string CS_VAR_AREA_OPTION = "cs_option";
const string CS_VAR_AREA_B_FADED = "cs_bFaded";
const string CS_VAR_AREA_F_MOVEMENT_RATE = "cs_fRate";
const string CS_VAR_AREA_N_DAYNIGHT = "cs_nDayNight";
const string CS_VAR_AREA_O_ARRAY_ACTOR = "cs_oActor";
const string CS_VAR_AREA_L_END_CAMERA_LOCATION = "cs_e_lCameraLocation";
const string CS_VAR_AREA_F_END_CAMERA_DIRECTION = "cs_e_fCameraDirection";
const string CS_VAR_AREA_F_END_CAMERA_DISTANCE = "cs_e_fCameraDistance";
const string CS_VAR_AREA_F_END_CAMERA_PITCH = "cs_e_fCameraPitch";
const string CS_VAR_AREA_N_END_DAYNIGHT = "cs_e_nDayNight";
const string CS_VAR_AREA_N_AMBIENT_SOUND_DAY = "cs_nAmbientSoundDay";
const string CS_VAR_AREA_N_AMBIENT_SOUND_NIGHT = "cs_nAmbientSoundNight";
const string CS_VAR_AREA_N_PLAY_AMBIENT = "cs_nPlayAmbient";
const string CS_VAR_AREA_N_AMBIENT_SOUND_VOLUME_DAY = "cs_nAmbientSoundVolumeDay";
const string CS_VAR_AREA_N_AMBIENT_SOUND_VOLUME_NIGHT = "cs_nAmbientSoundVolumeNight";
const string CS_VAR_AREA_N_MUSIC_BATTLE_TRACK = "cs_nMusicBattleTrack";
const string CS_VAR_AREA_N_PLAY_BATTLE = "cs_nPlayBattle";
const string CS_VAR_AREA_N_MUSIC_TRACK_DAY = "cs_nMusicTrackDay";
const string CS_VAR_AREA_N_MUSIC_TRACK_NIGHT = "cs_nMusicTrackNight";
const string CS_VAR_AREA_N_PLAY_MUSIC = "cs_nPlayMusic";
const string CS_VAR_AREA_N_FOG_AMOUNT_DAY = "cs_nFogAmount_Day";
const string CS_VAR_AREA_N_FOG_AMOUNT_NIGHT = "cs_nFogAmount_Night";
const string CS_VAR_AREA_N_FOG_COLOR_DAY = "cs_nFogColor_Day";
const string CS_VAR_AREA_N_FOG_COLOR_NIGHT = "cs_nFogColor_Night";
const string CS_VAR_AREA_N_SKYBOX = "cs_nSkyBox";
const string CS_VAR_AREA_N_WEATHER = "cs_nWeather";
const string CS_VAR_AREA_N_DELAY_TYPE = "cs_DelayType";
const string CS_VAR_AREA_B_END_FADED = "cs_e_bFaded";

const string CS_VAR_MODULE_DELAY_TYPE = "cs_g_DelayType";

const string CS_VAR_VFX_N_DURATION_TYPE = "nDurationType";
const string CS_VAR_VFX_O_TARGET = "oTarget";
const string CS_VAR_VFX_F_DURATION = "fDuration";
const string CS_VAR_VFX_N_VISUAL_EFFECT_ID = "nVisualEffectId";
const string CS_VAR_VFX_N_MISS_EFFECT = "nMissEffect";

const string CS_VAR_OBJECT_N_FLAGS = "cs_nFlags";
const string CS_VAR_OBJECT_N_PLAY = "cs_nPlay";
const string CS_VAR_OBJECT_B_IS_ACTOR = "cs_bIsActor";
const string CS_VAR_OBJECT_L_END_LOCATION = "cs_lEndLoc";
const string CS_VAR_OBJECT_F_END_FACING = "cs_fEndFacing";
const string CS_VAR_OBJECT_N_ANIM_ANIMATION = "cs_Anim_nAnimation";
const string CS_VAR_OBJECT_F_ANIM_SPEED = "cs_Anim_fSpeed";
const string CS_VAR_OBJECT_F_ANIM_DURATION = "cs_Anim_fDuration";
const string CS_VAR_OBJECT_N_USER_DEFINED_EVENT_NUMBER = "cs_nUserDefinedEventNumber";
const string CS_VAR_OBJECT_N_PLOT_FLAG = "cs_nPlotFlag";
const string CS_VAR_OBJECT_B_IMMORTAL = "cs_bImmortal";
const string CS_VAR_OBJECT_N_APPEARANCE_TYPE = "cs_nAppearanceType";
const string CS_VAR_OBJECT_N_END_LOCK_STATE = "cs_nEndObjectLockState";
const string CS_VAR_OBJECT_N_END_DOOR_OPEN_STATE = "cs_nEndDoorOpenState";
const string CS_VAR_OBJECT_F_END_VECTOR_X = "cs_fEndLocX";
const string CS_VAR_OBJECT_F_END_VECTOR_Y = "cs_fEndLocY";
const string CS_VAR_OBJECT_F_END_VECTOR_Z = "cs_fEndLocZ";
const string CS_VAR_OBJECT_N_SOUND_VOLUME = "cs_nSoundVolume";

const string CS_VAR_CAMERAWP_F_HEIGHT = "fHeight";
const string CS_VAR_CAMERAWP_F_PITCH = "fPitch";
const string CS_VAR_CAMERAWP_F_DISTANCE = "fDistance";
const string CS_VAR_CAMERAWP_F_MOVEMENT_SPEED = "fMovementSpeed";
const string CS_VAR_CAMERAWP_N_FACING_SPEED = "nFacingSpeed";
const string CS_VAR_CAMERAWP_F_FACING_TIME = "fFacingTime";

// misc cutscene function, usually does not need to be called directly
/**/int csm_CutsceneAborted(int nCutNumber=1, object oArea=OBJECT_SELF);

/**/void csm_CameraSetEndLocation(location lLoc, object oArea);
/**/void csm_CameraSetEndFacing(float fDirection, float fDistance, float fPitch, object oArea);
/**/void csm_CameraSetEndHeight(float fHeight, object oArea);
/**/void csm_CameraSetEndFade(int nFadeType, object oArea);

/**/float csm_AdjustDelay(float fDelay, object oArea);

// misc cutscene function. Wasn't intended to be called directly, but there's no harm in
// doing so. Simply removes all effects from oObject, or just visual effects if
// bJustVisual is TRUE.
void csm_RemoveEffects(object oObject, int bJustVisual=FALSE);

/**/void csm_SetFlag(int nFlag, object oObject);
/**/void csm_ClearFlag(int nFlag, object oObject);

// misc cutscene function. Not intended to be called directly, but if you find a use for
// it there should be no harm.
int csm_GetLastCutsceneNumber(object oArea=OBJECT_SELF);

/**/void csm_AddActor(object oObject, object oArea);

/**/void csm_RemoveFlaggedEffects(object oObject);

/**/void csm_CameraSetEndDayNightSetting(int nDayNight, object oArea);

/**/int csm_GetOption(int nOption, object oArea=OBJECT_SELF);
/**/int csm_GetOptionDefaultValue(int nOption);

//================================================

int csm_CutsceneAborted(int nCutNumber=-1, object oArea=OBJECT_SELF)
{
    if(nCutNumber==-1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    return GetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_ABORTED+IntToString(nCutNumber));
}

void csm_CameraSetEndLocation(location lLoc, object oArea)
{
    SetLocalLocation(oArea, CS_VAR_AREA_L_END_CAMERA_LOCATION, lLoc);
}

void csm_CameraSetEndFacing(float fDirection, float fDistance, float fPitch, object oArea)
{
    SetLocalFloat(oArea, CS_VAR_AREA_F_END_CAMERA_DIRECTION, fDirection);
    // only set these variables if we're actually changing them
    if (fDistance > -0.01) SetLocalFloat(oArea, CS_VAR_AREA_F_END_CAMERA_DISTANCE, fDistance);
    if (fPitch > -0.01) SetLocalFloat(oArea, CS_VAR_AREA_F_END_CAMERA_PITCH, fPitch);
}

// I never actually use this anywhere. I don't think I need it, but I'll keep
// it around just in case.
void csm_CameraSetEndHeight(float fHeight, object oArea)
{
    SetLocalFloat(oArea, "cs_e_fCameraHeight", fHeight);
}

void csm_CameraSetEndFade(int nFadeType, object oArea)
{
    if( (nFadeType==CS_FADE_TYPE_NONE) || (nFadeType==CS_FADE_TYPE_FROM_BLACK) )
        SetLocalInt(oArea, CS_VAR_AREA_B_END_FADED, FALSE);
    else SetLocalInt(oArea, CS_VAR_AREA_B_END_FADED, TRUE);
}

float csm_AdjustDelay(float fDelay, object oArea)
{
    int nDelayType = GetLocalInt(oArea, CS_VAR_AREA_N_DELAY_TYPE);

    // If CS_DELAY_TYPE_TOTAL, just return fDelay, no need to adjust it.
    if(nDelayType==CS_DELAY_TYPE_TOTAL) return fDelay;

    float fOldDelay = GetLocalFloat(oArea, CS_VAR_AREA_F_TOTAL_DELAY);
    float fNewDelay = fOldDelay + fDelay;
    SetLocalFloat(oArea, CS_VAR_AREA_F_TOTAL_DELAY, fNewDelay);
    return fNewDelay;
}

void csm_RemoveEffects(object oObject, int bJustVisual=FALSE)
{
    effect e = GetFirstEffect(oObject);
    while(GetIsEffectValid(e))
    {
        if(bJustVisual==FALSE || GetEffectType(e)==EFFECT_TYPE_VISUALEFFECT)
            RemoveEffect(oObject, e);
        e = GetNextEffect(oObject);
    }
}

void csm_SetFlag(int nFlag, object oObject)
{
    int nOldFlag = GetLocalInt(oObject, CS_VAR_OBJECT_N_FLAGS);
    SetLocalInt(oObject, CS_VAR_OBJECT_N_FLAGS, nFlag | nOldFlag);
}

void csm_ClearFlag(int nFlag, object oObject)
{
    int nOldFlag = GetLocalInt(oObject, CS_VAR_OBJECT_N_FLAGS);
    SetLocalInt(oObject, CS_VAR_OBJECT_N_FLAGS, (nFlag ^ 0xFFFFFFFF) & nOldFlag);
}

// misc cutscene function. Not intended to be called directly, but if you find a use for
// it there should be no harm.
int csm_GetLastCutsceneNumber(object oArea=OBJECT_SELF)
{
    return GetLocalInt(oArea, CS_VAR_AREA_N_CUT_NUMBER);
}

void csm_AddActor(object oObject, object oArea)
{
    // If I'm about to give the object a command, they had better damn well be
    // commandable! Technically, this isn't really what this function is for,
    // but whatever, it works.
    SetCommandable(TRUE, oObject);

    if(!GetLocalInt(oObject, CS_VAR_OBJECT_B_IS_ACTOR))
    {
        int nActorNum = GetLocalInt(oArea, CS_VAR_AREA_N_ACTOR_NUM);
        SetObjectArray(oArea, CS_VAR_AREA_O_ARRAY_ACTOR, nActorNum, oObject);
        SetLocalInt(oArea, CS_VAR_AREA_N_ACTOR_NUM, nActorNum+1);
        SetLocalInt(oObject, CS_VAR_OBJECT_B_IS_ACTOR, TRUE);
    }
}

void csm_RemoveFlaggedEffects(object oObject)
{
    effect e = GetFirstEffect(oObject);
    while(GetIsEffectValid(e))
    {
        if(GetTag(GetEffectCreator(e))==CS_INVISIBLE_OBJECT_TAG) DelayCommand(0.05, RemoveEffect(oObject, e));
        e = GetNextEffect(oObject);
    }
}

void csm_CameraSetEndDayNightSetting(int nDayNight, object oArea)
{
    SetLocalInt(oArea, CS_VAR_AREA_N_END_DAYNIGHT, nDayNight);
}

int csm_GetOption(int nOption, object oArea=OBJECT_SELF)
{
    int nValue = GetLocalInt(oArea, CS_VAR_AREA_OPTION+IntToString(nOption));
    if(nValue == 0)
    {
        nValue = GetLocalInt(GetModule(), CS_VAR_AREA_OPTION+IntToString(nOption));
        if(nValue == 0)
        {
            nValue = csm_GetOptionDefaultValue(nOption);
        }
    }
    if(nValue==2) nValue = 0;
    return nValue;
}

int csm_GetOptionDefaultValue(int nOption)
{
    int nValue;
    switch(nOption)
    {
        case CS_OPTION_ASSOCIATE_INVISIBILITY:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY; break;
        case CS_OPTION_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION; break;
        case CS_OPTION_ASSOCIATE_INVISIBILITY_DOMINATED:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_DOMINATED; break;
        case CS_OPTION_ASSOCIATE_INVISIBILITY_FAMILIAR:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_FAMILIAR; break;
        case CS_OPTION_ASSOCIATE_INVISIBILITY_HENCHMEN:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_HENCHMEN; break;
        case CS_OPTION_ASSOCIATE_INVISIBILITY_SUMMONED:
            nValue = CS_OPTIONDEFAULT_ASSOCIATE_INVISIBILITY_SUMMONED; break;
        //case CS_OPTION_ALL_PCS:
        //    nValue = CS_OPTIONDEFAULT_ALL_PCS; break;
        case CS_OPTION_RESTORE_PC_LOCATION:
            nValue = CS_OPTIONDEFAULT_RESTORE_PC_LOCATION; break;
        case CS_OPTION_REMOVE_PC_POLYMORPH:
            nValue = CS_OPTIONDEFAULT_REMOVE_PC_POLYMORPH; break;
        case CS_OPTION_REMOVE_PC_FAMILIAR_POSSESSION:
            nValue = CS_OPTIONDEFAULT_REMOVE_PC_FAMILIAR_POSSESSION; break;
        case CS_OPTION_REMOVE_PC_BLINDNESS_DARKNESS:
            nValue = CS_OPTIONDEFAULT_REMOVE_PC_BLINDNESS_DARKNESS; break;
    }
//    if(nValue==FALSE) nValue = 2;
    return nValue;
}

