//::///////////////////////////////////////////////
//:: Include file with some generic functions.
//:: _inc_generic.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 27, 2004
//:://////////////////////////////////////////////
#include "_inc_array"

const string ORIGINAL_PC_LOCATION_INC_GENERIC = "_inc_generic_original_pc_location";
const string PC_JUMP_LOCATION_INC_GENERIC = "_inc_generic_pc_jump_location";
const string PC_JUMP_RANGE_INC_GENERIC = "_inc_generic_pc_jump_range";
const string PC_JUMP_CUTSCENE_OK = "_inc_generic_pc_jump_cutscene_ok";
const string PC_JUMP_CAMERA_SETTINGS = "_inc_generic_pc_jump_camera_settings";
const string PC_JUMP_CAMERA_DIRECTION = "_inc_generic_pc_jump_camera_direction";
const string PC_JUMP_CAMERA_DISTANCE = "_inc_generic_pc_jump_camera_distance";
const string PC_JUMP_CAMERA_PITCH = "_inc_generic_pc_jump_camera_pitch";
const string PC_JUMP_CAMERA_HEIGHT = "_inc_generic_pc_jump_camera_height";
const string PC_JUMP_CAMERA_MOVEMENT_RATE = "_inc_generic_pc_jump_camera_moverate";
const string PC_JUMP_OLD_LOCATION = "_inc_generic_pc_jump_old_location";
const string PC_JUMP_NUM_ATTEMPTS = "_inc_generic_pc_jump_num_attempts";
const string PC_JUMP_MOVE_ASSOCIATES = "_inc_generic_pc_jump_move_associates";
const string PC_JUMP_MOVE_ASSOCIATES_OFFSET_ANGLE = "_inc_generic_pc_jump_offset_angle";

const string FORCE_JUMP_SCRIPT_INC_GENERIC = "_forcejump";

// Like GetObjectByTag, but only look in the area specified.
// nNth: The nth object with this tag, in the area (starts at 0).
object GetObjectByTagInArea(string sTag, object oArea=OBJECT_SELF, int nNth=0);

// Returns the nNth PC found in the specified oArea.
// Returns OBJECT_INVALID if there is no nNth PC in the area.
object GetPCInArea(object oArea=OBJECT_SELF, int nNth=0);

// Returns the angle between two objects. Think of it as the facing of oFirstObject,
// as it faces oSecondObject.
float GetFacingBetweenObjects(object oFirstObject, object SecondObject);

// Sets a global integer variable. Simply calls SetLocalInt with GetModule()
void SetGlobalInt(string sVarName, int nValue);
// Sets a global float variable. Simply calls SetLocalFloat with GetModule()
void SetGlobalFloat(string sVarName, float fValue);
// Sets a global object variable. Simply calls SetLocalObject with GetModule()
void SetGlobalObject(string sVarName, object oObject);
// Sets a global location variable. Simply calls SetLocalLocation with GetModule()
void SetGlobalLocation(string sVarName, location lLoc);
// Sets a global string variable. Simply calls SetLocalString with GetModule()
void SetGlobalString(string sVarName, string sValue);

// Gets a global integer variable. Simply calls GetLocalInt with GetModule()
int GetGlobalInt(string sVarName);
// Gets a global float variable. Simply calls GetLocalFloat with GetModule()
float GetGlobalFloat(string sVarName);
// Gets a global object variable. Simply calls GetLocalObject with GetModule()
object GetGlobalObject(string sVarName);
// Gets a global location variable. Simply calls GetLocalLocation with GetModule()
location GetGlobalLocation(string sVarName);
// Gets a global string variable. Simply calls GetLocalString with GetModule()
string GetGlobalString(string sVarName);

// A better ClearAllActions function. Seems to be more effective at stopping the
// creature in his tracks than the normal ClearAllActions function.
// Except it seems to change the creature's facing sometimes.
void ClearAllActionsBetter(object oCreature=OBJECT_SELF, int nClearCombatState=TRUE);

// Jumps PC's to the specified location.
// The current location of each PC is stored, so that it can be restored with
// RestorePCLocations().
// nParty: 0 = Only jump oPC.
//         1 = Jump oPC, and oPC's party.
//         2 = Jump all PC's (ignores oPC parameter).
// oPC: The specific PC to jump.
// fDistance: It will not jump any PC who is already within fDistance of lLoc.
// bNotInSameArea: It will not jump any PC who is in the same area as
//                 lLoc (overrides fDistance if TRUE).
// bIgnoreDMs: Does nothing with DM players.
// bMoveAssociates: Also jumps the PC's associates.
// Note: Even if the PC does not jump (because of either parameter above), their
//       original location is still stored.
void JumpPCsToLocation(location lLoc, int nParty=1, object oPC=OBJECT_INVALID, float fDistance=5.0f, int bNotInSameArea=FALSE, int bIgnoreDMs=TRUE, int bMoveAssociates=TRUE);

// To be used in conjunction with JumpAllPCsToLocation().
// This function jumps PC's back to the location that was stored
// with JumpPCsToLocation() or StorePCLocations().
// nParty: 0 = Restores the location of oPC.
//         1 = Restores the locations of oPC, and oPC's party.
//         2 = Restores the locations of all PC's (ignores oPC parameter).
// oPC: The specific PC to restore.
// fDistance: It will not jump any PC who is already within fDistance of
//            their original location.
// bNotInSameArea: It will not jump any PC who is in the same area as
//                 their original location (overrides fDistance if TRUE).
// bIgnoreDMs: Does nothing with DM players.
// bMoveAssociates: Also jumps the PC's associates.
void RestorePCLocations(int nParty=1, object oPC=OBJECT_INVALID, float fDistance=5.0f, int bNotInSameArea=FALSE, int bIgnoreDMs=TRUE, int bMoveAssociates=TRUE);

// Stores the location of PC's.
// To be used in conjunction with RestorePCLocations().
// nParty: 0 = Stores oPC's location.
//         1 = Stores the locations of oPC, and oPC's party.
//         2 = Stores the locations of all PC's.
// oPC: The specific PC to store the location of.
// bIgnoreDMs: Does nothing with DM players.
void StorePCLocations(int nParty=1, object oPC=OBJECT_INVALID, int bIgnoreDMs=TRUE);

// Sets the start location for the module, so that late joining players start
// where we want them to. Note that this requires custom OnEnter scripting to work.
// oStartLocation: Object (usually a waypoint) at which to set the start location.
void SetStartLocation(object oStartLocation);

// Will return the object set with SetStartLocation().
// If SetStartLocation has not yet been used, this will try to find a waypoint
// with the tag "startlocation1". If it cannot be found, it will return OBJECT_INVALID.
object GetStartLocation();

// GetIsPC will return TRUE if the object is a player or a DM.
// This function returns TRUE only if the object is a player (and not a DM).
int GetIsPCNotDM(object oPlayer);

//===========================================================

//::///////////////////////////////////////////////
//:: GetObjectByTagInArea()
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function is basically the same as
    GetObjectByTag(), but looks only in the area
    specified.

    A GetNearestObjectByTag() call can often
    achieve the same thing, but that assumes there
    is ready access to an object in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 27, 2004
//:://////////////////////////////////////////////
object GetObjectByTagInArea(string sTag, object oArea=OBJECT_SELF, int nNth=0)
{
    int nNthOverall=0;
    int nNthInArea=0;

    object oObject = GetObjectByTag(sTag, nNthOverall);
    while(GetIsObjectValid(oObject))
    {
        if(GetArea(oObject) == oArea)
        {
            if(nNthInArea == nNth) return oObject;
            nNthInArea++;
        }
        nNthOverall++;
        oObject = GetObjectByTag(sTag, nNthOverall);
    }
    return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: GetPCInArea
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the nNth PC in the specified area,
    or OBJECT_INVALID.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar. 7, 2004
//:://////////////////////////////////////////////
object GetPCInArea(object oArea=OBJECT_SELF, int nNth=0)
{
    object oPC = GetFirstPC();
    int nNthFound = 0;
    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC)==oArea)
        {
            if(nNthFound==nNth) return oPC;
            nNthFound++;
        }
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: GetFacingBetweenObjects()
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Returns the angle between two objects. Think of it as the facing
   of oFirstObject, as it faces oSecondObject.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar. 1, 2004
//:://////////////////////////////////////////////
float GetFacingBetweenObjects(object oFirstObject, object oSecondObject)
{
    vector v1 = GetPosition(oFirstObject);
    vector v2 = GetPosition(oSecondObject);
    return VectorToAngle(v2-v1);
}

void SetGlobalInt(string sVarName, int nValue)
{
    SetLocalInt(GetModule(), sVarName, nValue);
}

void SetGlobalFloat(string sVarName, float fValue)
{
    SetLocalFloat(GetModule(), sVarName, fValue);
}

void SetGlobalObject(string sVarName, object oObject)
{
    SetLocalObject(GetModule(), sVarName, oObject);
}

void SetGlobalLocation(string sVarName, location lLoc)
{
    SetLocalLocation(GetModule(), sVarName, lLoc);
}

void SetGlobalString(string sVarName, string sValue)
{
    SetLocalString(GetModule(), sVarName, sValue);
}

int GetGlobalInt(string sVarName)
{
    return GetLocalInt(GetModule(), sVarName);
}

float GetGlobalFloat(string sVarName)
{
    return GetLocalFloat(GetModule(), sVarName);
}

object GetGlobalObject(string sVarName)
{
    return GetLocalObject(GetModule(), sVarName);
}

location GetGlobalLocation(string sVarName)
{
    return GetLocalLocation(GetModule(), sVarName);
}

string GetGlobalString(string sVarName)
{
    return GetLocalString(GetModule(), sVarName);
}

void ClearAllActionsBetter(object oCreature=OBJECT_SELF, int nClearCombatState=TRUE)
{
    AssignCommand(oCreature, ClearAllActions(nClearCombatState));
    AssignCommand(oCreature, JumpToObject(oCreature));
}

void JumpPCsToLocation(location lLoc, int nParty=1, object oPC=OBJECT_INVALID, float fDistance=5.0f, int bNotInSameArea=FALSE, int bIgnoreDMs=TRUE, int bMoveAssociates=TRUE)
{
    object oJumpPC;
    if(nParty==2) oJumpPC = GetFirstPC();
    else if(nParty==1) oJumpPC = GetFirstFactionMember(oPC);
    else oJumpPC = oPC;

    location lOrig;
    int bJump;
    while(GetIsObjectValid(oJumpPC))
    {
        if(!bIgnoreDMs || !GetIsDM(oJumpPC))
        {
            lOrig = GetLocation(oJumpPC);
            SetLocalLocation(oJumpPC, ORIGINAL_PC_LOCATION_INC_GENERIC, lOrig);

            if(!bNotInSameArea || GetArea(oJumpPC)!=GetAreaFromLocation(lLoc))
            {
                SetLocalLocation(oJumpPC, PC_JUMP_LOCATION_INC_GENERIC, lLoc);
                SetLocalFloat(oJumpPC, PC_JUMP_RANGE_INC_GENERIC, fDistance);
                SetLocalInt(oJumpPC, PC_JUMP_MOVE_ASSOCIATES, bMoveAssociates);
                ExecuteScript(FORCE_JUMP_SCRIPT_INC_GENERIC, oJumpPC);
            }
        }

        if(nParty==2) oJumpPC = GetNextPC();
        else if(nParty==1) oJumpPC = GetNextFactionMember(oPC);
        else oJumpPC = OBJECT_INVALID;
    }
}

void RestorePCLocations(int nParty=1, object oPC=OBJECT_INVALID, float fDistance=5.0f, int bNotInSameArea=FALSE, int bIgnoreDMs=TRUE, int bMoveAssociates=TRUE)
{
    object oJumpPC;
    if(nParty==2) oJumpPC = GetFirstPC();
    else if(nParty==1) oJumpPC = GetFirstFactionMember(oPC);
    else oJumpPC = oPC;

    location lLoc;
    int bJump;
    while(GetIsObjectValid(oJumpPC))
    {
        if(!bIgnoreDMs || !GetIsDM(oJumpPC))
        {
            bJump = FALSE;
            lLoc = GetLocalLocation(oJumpPC, ORIGINAL_PC_LOCATION_INC_GENERIC);
            // in different area
            if(GetArea(oJumpPC)!=GetAreaFromLocation(lLoc))
            {
                bJump = TRUE;
            }
            // in same area
            else if(!bNotInSameArea && (GetDistanceBetweenLocations(lLoc, GetLocation(oJumpPC)) > fDistance))
            {
                bJump = TRUE;
            }

            if(bJump)
            {
                SetLocalLocation(oJumpPC, PC_JUMP_LOCATION_INC_GENERIC, lLoc);
                SetLocalFloat(oJumpPC, PC_JUMP_RANGE_INC_GENERIC, fDistance);
                SetLocalInt(oJumpPC, PC_JUMP_MOVE_ASSOCIATES, bMoveAssociates);
                ExecuteScript(FORCE_JUMP_SCRIPT_INC_GENERIC, oJumpPC);
            }
        }

        if(nParty==2) oJumpPC = GetNextPC();
        else if(nParty==1) oJumpPC = GetNextFactionMember(oPC);
        else oJumpPC = OBJECT_INVALID;
    }
}

// nParty: 0 = Stores oPC's location.
//         1 = Stores the locations of oPC, and oPC's party.
//         2 = Stores the locations of all PC's.
void StorePCLocations(int nParty=1, object oPC=OBJECT_INVALID, int bIgnoreDMs=TRUE)
{
    object oStorePC;
    if(nParty==2) oStorePC = GetFirstPC();
    else if(nParty==1) oStorePC = GetFirstFactionMember(oPC);
    else oStorePC = oPC;

    while(GetIsObjectValid(oStorePC))
    {
        if(!bIgnoreDMs || !GetIsDM(oStorePC))
        {
            SetLocalLocation(oStorePC, ORIGINAL_PC_LOCATION_INC_GENERIC, GetLocation(oStorePC));
            if(nParty==2) oStorePC = GetNextPC();
            else if(nParty==1) oStorePC = GetNextFactionMember(oPC);
            else oStorePC = OBJECT_INVALID;
        }
    }
}

void SetStartLocation(object oStartLocation)
{
    SetLocalObject(GetModule(), "_inc_generic_oStartLocation", oStartLocation);
}

object GetStartLocation()
{
    object oStartLocation = GetLocalObject(GetModule(), "_inc_generic_oStartLocation");
    if(!GetIsObjectValid(oStartLocation)) oStartLocation = GetWaypointByTag("startlocation1");
    return oStartLocation;
}

int GetIsPCNotDM(object oPlayer)
{
    return (GetIsPC(oPlayer)) & (!GetIsDM(oPlayer)) & (!GetIsDMPossessed(oPlayer));
}
