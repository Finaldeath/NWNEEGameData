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

const string CS_CAMERA_TAG_POSITION = "cs_camera_pos_";
const string CS_CAMERA_TAG_FOCUS = "cs_camera_focus_";

// misc cutscene function, usually does not need to be called directly
int csm_CutsceneAborted(int nCutNumber=1, object oArea=OBJECT_SELF);

// misc cutscene function, usually does not need to be called directly
void csm_CameraSetEndLocation(location lLoc, object oArea);
// misc cutscene function, usually does not need to be called directly
void csm_CameraSetEndFacing(float fDirection, float fDistance, float fPitch, object oArea);
// misc cutscene function, usually does not need to be called directly
void csm_CameraSetEndHeight(float fHeight, object oArea);
// misc cutscene function, usually does not need to be called directly
void csm_CameraSetEndFade(int nFadeType, object oArea);

// misc cutscene function, I do not recommend calling it directly
float csm_AdjustDelay(float fDelay, object oArea);

// misc cutscene function. Wasn't intended to be called directly, but there's no harm in
// doing so. Simply removes all effects from oObject, or just visual effects if
// bJustVisual is TRUE.
void csm_RemoveEffects(object oObject, int bJustVisual=FALSE);

// misc cutscene function. I do not recommend calling it directly.
void csm_SetFlag(int nFlag, object oObject);
// misc cutscene function. I do not recommend calling it directly.
void csm_ClearFlag(int nFlag, object oObject);

// misc cutscene function. Not intended to be called directly, but if you find a use for
// it there should be no harm.
int csm_GetLastCutsceneNumber(object oArea=OBJECT_SELF);

// misc cutscene function. I do not recommend calling it directly.
void csm_AddActor(object oObject, object oArea);

// misc cutscene function. I do not recommend calling it directly.
void csm_RemoveFlaggedEffects(object oObject);

// misc cutscene function, usually does not need to be called directly
void csm_CameraSetEndDayNightSetting(int nDayNight, object oArea);

// misc cutscene function, usually does not need to be called directly
int csm_GetOption(int nOption, object oArea=OBJECT_SELF);
// misc cutscene function, usually does not need to be called directly
int csm_GetOptionDefaultValue(int nOption);

//================================================

int csm_CutsceneAborted(int nCutNumber=-1, object oArea=OBJECT_SELF)
{
    if(nCutNumber==-1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    return GetLocalInt(oArea, "cs_bCutsceneAborted"+IntToString(nCutNumber));
}

void csm_CameraSetEndLocation(location lLoc, object oArea)
{
    SetLocalLocation(oArea, "cs_e_lCameraLocation", lLoc);
}

void csm_CameraSetEndFacing(float fDirection, float fDistance, float fPitch, object oArea)
{
    SetLocalFloat(oArea, "cs_e_fCameraDirection", fDirection);
    SetLocalFloat(oArea, "cs_e_fCameraDistance", fDistance);
    SetLocalFloat(oArea, "cs_e_fCameraPitch", fPitch);
}

void csm_CameraSetEndHeight(float fHeight, object oArea)
{
    SetLocalFloat(oArea, "cs_e_fCameraHeight", fHeight);
}

void csm_CameraSetEndFade(int nFadeType, object oArea)
{
    if( (nFadeType==CS_FADE_TYPE_NONE) || (nFadeType==CS_FADE_TYPE_FROM_BLACK) )
        SetLocalInt(oArea, "cs_e_bFaded", FALSE);
    else SetLocalInt(oArea, "cs_e_bFaded", TRUE);
}

float csm_AdjustDelay(float fDelay, object oArea)
{
    int nDelayType = GetLocalInt(oArea, "cs_DelayType");

    // If CS_DELAY_TYPE_TOTAL, just return fDelay, no need to adjust it.
    if(nDelayType==CS_DELAY_TYPE_TOTAL) return fDelay;

    float fOldDelay = GetLocalFloat(oArea, "cs_fTotalDelay");
    float fNewDelay = fOldDelay + fDelay;
    SetLocalFloat(oArea, "cs_fTotalDelay", fNewDelay);
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
    int nOldFlag = GetLocalInt(oObject, "cs_nFlags");
    SetLocalInt(oObject, "cs_nFlags", nFlag | nOldFlag);
}

void csm_ClearFlag(int nFlag, object oObject)
{
    int nOldFlag = GetLocalInt(oObject, "cs_nFlags");
    SetLocalInt(oObject, "cs_nFlags", (nFlag ^ 0xFFFFFFFF) & nOldFlag);
}

// misc cutscene function. Not intended to be called directly, but if you find a use for
// it there should be no harm.
int csm_GetLastCutsceneNumber(object oArea=OBJECT_SELF)
{
    return GetLocalInt(oArea, "cs_nCutNumber");
}

void csm_AddActor(object oObject, object oArea)
{
    // If I'm about to give the object a command, they had better damn well be
    // commandable! Technically, this isn't really what this function is for,
    // but whatever, it works.
    SetCommandable(TRUE, oObject);

    if(!GetLocalInt(oObject, "cs_bIsActor"))
    {
        int nActorNum = GetLocalInt(oArea, "cs_nActorNum");
        SetObjectArray(oArea, "cs_oActor", nActorNum, oObject);
        SetLocalInt(oArea, "cs_nActorNum", nActorNum+1);
        SetLocalInt(oObject, "cs_bIsActor", TRUE);
    }
}

void csm_RemoveFlaggedEffects(object oObject)
{
    effect e = GetFirstEffect(oObject);
    while(GetIsEffectValid(e))
    {
        if(GetTag(GetEffectCreator(e))=="cs_EffectObject") DelayCommand(0.05, RemoveEffect(oObject, e));
        e = GetNextEffect(oObject);
    }
}

void csm_CameraSetEndDayNightSetting(int nDayNight, object oArea)
{
    SetLocalInt(oArea, "cs_e_nDayNight", nDayNight);
}

int csm_GetOption(int nOption, object oArea=OBJECT_SELF)
{
    int nValue = GetLocalInt(oArea, "cs_option"+IntToString(nOption));
    if(nValue == 0)
    {
        nValue = GetLocalInt(GetModule(), "cs_option"+IntToString(nOption));
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

