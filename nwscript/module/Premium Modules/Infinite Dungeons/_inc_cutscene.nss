//::///////////////////////////////////////////////
//:: Main cutscene include file
//:: _inc_cutscene.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the main cutscene include file. This
    usually is the only file that needs to be
    included for cutscene scripts.

    Direct includes:
      - _inc_cut_level1.nss: High-level cutscene functions
    Indirect includes:
      - _inc_cut_level2.nss: Low-level cutscene functions
      - _inc_cut_misc: Miscellaneous cutscene functions
      - _inc_generic: Generic functions
      - _inc_array: Array functions
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////

/*
  The following scripts need to be recompiled if any changes
  are made to any of the cutscene system include files:
    _cs_applyvfx
    _cs_area_onenter
    _cs_oncsabort
*/

#include "_inc_cut_level1"

// Starts cutscene.
// Places all players in the area into cutscene mode,
// and executes the cutscene script.
// fDelay: Starts the cutscene after the specified amount of time.
//         Suggestion: Use cs_PreCutsceneFade() just before calling cs_StartCutscene, and then
//         set fDelay to a couple of seconds, to allow the screen to fade out before the
//         cutscene really starts.
// bAbortable: Is the cutscene abortable? Dependent on OnCutsceneAborted scripting.
// bRemoveAOEs: If TRUE, removes all area of effect objects from the area. Generally a good
//              idea so you don't have NPC's walking into a Glyph of Warding or something.
// sCSScript: Cutscene script. It is generally a good idea to put the actual cutscene scripting
//            into a separate script. Specify the script name here. If none is specified, it
//            will see if there is a script with the name "cs_AreaTag", where "AreaTag" is the
//            first 13 characters of the area's tag, and will execute that if it exists.
// sEndScript: Script to run when cutscene ends, or is aborted.
// (note: Both scripts run on the oArea object)
// nCutNumber: Cutscene number. Different areas can re-use the same numbers. Must be greater than zero.
// oArea: The area to run the cutscene. If OBJECT_SELF is not an area object, it will try GetArea(OBJECT_SELF).
void cs_StartCutscene(string sCSScript, string sEndScript="", float fDelay=0.0, int bAbortable=FALSE, int bRemoveAOEs=TRUE, int nCutNumber=1, object oArea=OBJECT_SELF);

// Ends cutscene
// bStopFade: If TRUE, a StopFade() is applied to all PC cameras.
//            TRUE by default to ensure no PC gets stuck on a black screen.
// bFadeFromBlack, fSpeed: If bFadeFromBlack=TRUE, a FadeFromBlack() is applied
//                         to all PC camera's, with the specified fSpeed.
//                         These are ignored if bStopFade=TRUE.
void cs_EndCutscene(float fDelay, int bStopFade=TRUE, int bFadeFromBlack=FALSE, float fSpeed=FADE_SPEED_MEDIUM, int nCutNumber=-1, object oArea=OBJECT_SELF);

void cs_AbortCutscene(int nCutNumber=1, object oArea=OBJECT_SELF);

// This function should be placed at the top of the area OnEnter script, for each area
// that runs a cutscene. It should not be used anywhere else.
void cs_AreaOnEnter(object oEnterer);

// This function is called from the module OnCutsceneAbort event.
// It should not be used anywhere else.
void cs_ModuleOnCutsceneAbort(object oLastPCToCancelCutscene);

// Sets various options for cutscenes. Use before starting the cutscene.
// It is not recommended that this function be used during a cutscene.
// nOptionToSet: CS_OPTION_*
// bValue: TRUE or FALSE. Or -1 to revert to default value, as set by
//         cs_SetOptionDefault(), or the internal default if a user-defined
//         default has not been set.
void cs_SetOption(int nOptionToSet, int bValue, object oArea=OBJECT_SELF);

// Sets the default value for various options for cutscenes.
// All cutscenes will use the new value, unless areas are overriden
// using cs_SetOption().
// nOptionToSet: CS_OPTION_*
// bNewDefaultValue: TRUE or FALSE. Or -1 to reset to internal default.
void cs_SetOptionDefault(int nOptionToSet, int bNewDefaultValue);

//======================================

// Starts cutscene.
void cs_StartCutscene(string sCSScript, string sEndScript="", float fDelay=0.0, int bAbortable=FALSE, int bRemoveAOEs=TRUE, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    // Don't start another cutscene if one is currently running.
    // Bad things happen. Like henchmen staying invisible.
    if(GetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED))
    {
        SendMessageToPC(GetFirstPC(), "_inc_cutscene.nss: ERROR - cs_StartCutscene() called while current cutscene still active");
        return;
    }

    // make sure the object is actually an area object
    // done the goofy way since there is no OBJECT_TYPE_AREA...
    // if not an area object, use GetArea(oArea)
    if(GetArea(oArea) != oArea)
    {
        oArea = GetArea(oArea);

    }
    // if given area isn't valid, stop now
    if(!GetIsObjectValid(oArea)) return;

    if(nCutNumber < 1) return;

    SetLocalString(oArea, CS_VAR_AREA_S_END_SCRIPT, sEndScript);

    // Set up effect object. Used for applying effects in the cutscene. This makes the
    // effects easier to track, and therefore easier to remove.
    vector vTemp;
    vTemp.x = 1.0;
    vTemp.y = 1.0;
    vTemp.z = 1.0;
    object oEffectObject = CreateObject(OBJECT_TYPE_PLACEABLE, CS_INVISIBLE_OBJECT_RESREF, Location(oArea, vTemp, 0.0), FALSE, CS_INVISIBLE_OBJECT_TAG);
    SetLocalObject(oArea, CS_VAR_AREA_O_EFFECT_OBJECT, oEffectObject);

    // Initialize actor array index (actor is a broad term meaning any object involved in the cutscene)
    SetLocalInt(oArea, CS_VAR_AREA_N_ACTOR_NUM, 0);

    // Place all players in the area into cutscene mode.
    // Put them into an array. First PC is number 0.
    // If there are 4 PC's, CS_VAR_AREA_N_NUM_PC will be 4, numbered 0 to 3.
    int nNumPC = 0;
    object oPC = GetFirstPC();
    SetLocalInt(oArea, CS_VAR_AREA_N_CAMERA_MODE, CAMERA_MODE_TOP_DOWN);

    int bRestorePCLocations = csm_GetOption(CS_OPTION_RESTORE_PC_LOCATION, oArea);
    while(GetIsObjectValid(oPC))
    {
        // only use PC if in the right area, and is not a DM
        if((GetArea(oPC) == oArea) && (!GetIsDM(oPC)))
        {
            if(bRestorePCLocations==1) StorePCLocations(0, oPC);
            SetObjectArray(oArea, CS_VAR_AREA_O_ARRAY_PC, nNumPC, oPC);
            csll_ApplyPCCutsceneEffects(oPC, oArea, fDelay);
            nNumPC++;
        }
        oPC = GetNextPC();
    }
    SetLocalInt(oArea, CS_VAR_AREA_N_NUM_PC, nNumPC);
    SetLocalObject(oArea, CS_VAR_AREA_O_VISIBLE_PC, OBJECT_INVALID);


    string sCutNumber = IntToString(nCutNumber);
    SetLocalInt(oArea, CS_VAR_AREA_N_CUT_NUMBER, nCutNumber);
    SetLocalInt(oArea, CS_VAR_AREA_B_ABORTABLE, FALSE);
    DelayCommand(fDelay+0.1, SetLocalInt(oArea, CS_VAR_AREA_B_ABORTABLE, bAbortable));
    //DelayCommand(fDelay, SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED, TRUE));
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED, TRUE);
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_ABORTED+sCutNumber, FALSE);
    //DelayCommand(fDelay, SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED+sCutNumber, TRUE));
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED+sCutNumber, TRUE);
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_ENDED+sCutNumber, FALSE);

    // Set delay type variables
    int nGlobalDelayType = GetLocalInt(GetModule(), CS_VAR_MODULE_DELAY_TYPE);
    if (nGlobalDelayType == CS_DELAY_TYPE_UNDEFINED)
        cs_SetDelayType(CS_DEFAULT_DELAY_TYPE, oArea);
    else cs_SetDelayType(nGlobalDelayType, oArea);
    SetLocalFloat(oArea, CS_VAR_AREA_F_TOTAL_DELAY, 0.0);

    // set some default camera values, just in case
    SetLocalLocation(oArea, CS_VAR_AREA_L_CAMERA_LOCATION, GetLocation(GetObjectArray(oArea, CS_VAR_AREA_O_ARRAY_PC, 0)));
    SetLocalFloat(oArea, CS_VAR_AREA_F_CAMERA_DIRECTION, 0.0);
    SetLocalFloat(oArea, CS_VAR_AREA_F_CAMERA_DISTANCE, 10.0);
    SetLocalFloat(oArea, CS_VAR_AREA_F_CAMERA_PITCH, 30.0);
    SetLocalFloat(oArea, CS_VAR_AREA_F_CAMERA_HEIGHT, 0.0);
    cs_CameraSetMovementRate(0.0, 1.0);

    // Remove all area-of-effect objects. Generally a good idea.
    if(bRemoveAOEs)
    {
        object oAOE = GetFirstObjectInArea(oArea);
        while(GetIsObjectValid(oAOE))
        {
            if(GetObjectType(oAOE)==OBJECT_TYPE_AREA_OF_EFFECT) DestroyObject(oAOE, 0.2);
            oAOE = GetNextObjectInArea(oArea);
        }
    }

    // Execute cutscene script
    if(sCSScript=="") DelayCommand(fDelay+0.05, ExecuteScript(CS_VAR_AREA_CUTSCENE_SCRIPT_PREFIX+GetTag(oArea), oArea));
    else DelayCommand(fDelay+0.05, ExecuteScript(sCSScript, oArea));
}

// Ends cutscene
void cs_EndCutscene(float fDelay, int bStopFade=TRUE, int bFadeFromBlack=FALSE, float fSpeed=FADE_SPEED_MEDIUM, int nCutNumber=-1, object oArea=OBJECT_SELF)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(!GetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED)) return;
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_EndCutscene(bStopFade, bFadeFromBlack, fSpeed, nCutNumber, oArea));
}

void cs_AbortCutscene(int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(!GetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED)) return;
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED, FALSE);

    csll_CameraDoFade(CS_FADE_TYPE_BLACK, FADE_SPEED_FASTEST, nCutNumber, oArea);
    SetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_ABORTED+IntToString(nCutNumber), TRUE);

   // int bFaded = GetLocalInt(oArea, "cs_e_bFaded");
    DelayCommand(1.0, csll_EndCutscene(FALSE, TRUE, FADE_SPEED_MEDIUM, nCutNumber, oArea, TRUE));
}

// This function should be placed at the top of the area OnEnter script, for each area
// that runs a cutscene. It should not be used anywhere else.
void cs_AreaOnEnter(object oEnterer)
{
    csll_AreaOnEnter(oEnterer);
    // Do one extra call to this function. I'm still getting the odd case of
    // some PC's not being put into the cutscene when they should be in
    // multiplayer in certain circumstances. Hopefully this hack will help
    // fix this. Note that if the first call actually worked, the second call
    // will still work ok - there are checks to make sure a PC doesn't get
    // added to a cutscene more than once.
    DelayCommand(2.0, csll_AreaOnEnter(oEnterer));
}

// This function is called from the module OnCutsceneAbort event.
// It should not be used anywhere else.
void cs_ModuleOnCutsceneAbort(object oLastPCToCancelCutscene)
{
    object oArea = GetArea(oLastPCToCancelCutscene);
    int bAbortable = GetLocalInt(oArea, CS_VAR_AREA_B_ABORTABLE);
    int bCutsceneStarted = GetLocalInt(oArea, CS_VAR_AREA_B_CUTSCENE_STARTED);
    int nCutNumber = GetLocalInt(oArea, CS_VAR_AREA_N_CUT_NUMBER);
    int bCutsceneAborted = csm_CutsceneAborted(nCutNumber, oArea);
    // some fail-safe checking
    if (bAbortable && bCutsceneStarted && !bCutsceneAborted) cs_AbortCutscene(nCutNumber, oArea);
}

void cs_SetOption(int nOptionToSet, int bValue, object oArea=OBJECT_SELF)
{
    if(bValue == -1)
    {
        DeleteLocalInt(oArea, CS_VAR_AREA_OPTION+IntToString(nOptionToSet));
        return;
    }

    // I don't want to store variables set to 0 - otherwise, how do I know whether they've
    // been set or not? So I convert FALSE values to 2.
    if(bValue==0) bValue = 2;

    // set nOptionToSet to bSetValue
    SetLocalInt(oArea, CS_VAR_AREA_OPTION+IntToString(nOptionToSet), bValue);
}

// nOptionToSet: CS_OPTION_*
// bNewDefaultValue: TRUE or FALSE. Or -1 to reset to internal default.
void cs_SetOptionDefault(int nOptionToSet, int bNewDefaultValue)
{
    if(bNewDefaultValue == -1)
    {
        DeleteLocalInt(GetModule(), CS_VAR_AREA_OPTION+IntToString(nOptionToSet));
        return;
    }

    // I don't want to store variables set to 0 - otherwise, how do I know whether they've
    // been set or not? So I convert FALSE values to 2.
    if(bNewDefaultValue==0) bNewDefaultValue = 2;

    SetLocalInt(GetModule(), CS_VAR_AREA_OPTION+IntToString(nOptionToSet), bNewDefaultValue);
}

/*
Description of options:

Associate Invisibility options:
    CS_OPTION_ASSOCIATE_INVISIBILITY:
      Default: TRUE
        If TRUE, all associates are given cutscene invisibility for the duration of the cutscene.
        If TRUE, this option overrides all other ASSOCIATE_INVISIBILITY_* options.
        If FALSE, the system falls back to the other ASSOCIATE_INVISIBILITY_* options.

    CS_OPTION_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION:
      Default: FALSE
        CS_OPTION_ASSOCIATE_INVISIBILITY, when TRUE, overrides this option.
        If TRUE, animal companions are given cutscene invisibility for the duration of the cutscene.
        If FALSE, animal companions are visible during the cutscene.

    CS_OPTION_ASSOCIATE_INVISIBILITY_DOMINATED:
      Default: FALSE
        CS_OPTION_ASSOCIATE_INVISIBILITY, when TRUE, overrides this option.
        If TRUE, dominated creatures are given cutscene invisibility for the duration of the cutscene.
        If FALSE, dominated creatures are visible during the cutscene.

    CS_OPTION_ASSOCIATE_INVISIBILITY_FAMILIAR:
      Default: FALSE
        CS_OPTION_ASSOCIATE_INVISIBILITY, when TRUE, overrides this option.
        If TRUE, familiars are given cutscene invisibility for the duration of the cutscene.
        If FALSE, familiars are visible during the cutscene.

    CS_OPTION_ASSOCIATE_INVISIBILITY_HENCHMEN:
      Default: FALSE
        CS_OPTION_ASSOCIATE_INVISIBILITY, when TRUE, overrides this option.
        If TRUE, henchmen are given cutscene invisibility for the duration of the cutscene.
        If FALSE, henchmen are visible during the cutscene.

    CS_OPTION_ASSOCIATE_INVISIBILITY_SUMMONED:
      Default: FALSE
        CS_OPTION_ASSOCIATE_INVISIBILITY, when TRUE, overrides this option.
        If TRUE, summoned creatures are given cutscene invisibility for the duration of the cutscene.
        If FALSE, summoned creatures are visible during the cutscene.

PC options:
    CS_OPTION_RESTORE_PC_LOCATION:
      Default: FALSE
        If TRUE, the original location of the PC's in the cutscene is restored, when the cutscene ends.
        If FALSE, the PC's remain where the cutscene camera ends up.

    CS_OPTION_REMOVE_PC_POLYMORPH:
      Default: TRUE
        If TRUE, all PC's added to the cutscene will have all polymorph effects removed.
        If FALSE, does nothing.

    CS_OPTION_REMOVE_PC_FAMILIAR_POSSESSION:
      Default: TRUE
        If TRUE, all PC's added to the cutscene will automatically unpossess their familiar.
        If FALSE, does nothing.
*/
