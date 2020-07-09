//::///////////////////////////////////////////////
//:: Name: Level Generator Include File
//:: FileName:inc_levelgen
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This include file holds all the functions for making the random dungeon floor layouts.
*/
//:://////////////////////////////////////////////
//:: Created By: Elidrin
//:: Created On: 04-14-05
//:://////////////////////////////////////////////
#include "inc_id_misctools"



//////////////////////////START CONSTANTS/////////////////////////

// Modify later to look at module variables.
const int LEVEL_SIZE                    = 10;


                ////////LEVEL GEN CONSTANTS////////
const int CHANCE_OF_4_WAY_EXIT          = 30;
const int CHANCE_OF_3_WAY_EXIT          = 50;
const int CHANCE_OF_2_WAY_EXIT          = 20;
const int CHANCE_OF_DEAD_END            = 0;

const string RESTRICTIONS_TRANSITION    = "Restrictions";
const int RESTRICTED_ACCESS_NONE        = 0;

const int WALL_INVALID                  = 0;
const int WALL_NORTH                    = 1;
const int WALL_EAST                     = 2;
const int WALL_SOUTH                    = 4;
const int WALL_WEST                     = 8;
/* Values no longer used
const int RESTRICTION_NORTH             = 16;
const int RESTRICTION_EAST              = 32;
const int RESTRICTION_SOUTH             = 64;
const int RESTRICTION_WEST              = 128;*/
const int STAIRS_UP_NORTH               = 256;
const int STAIRS_UP_EAST                = 512;
const int STAIRS_UP_SOUTH               = 1024;
const int STAIRS_UP_WEST                = 2048;
const int STAIRS_DOWN_NORTH             = 4096;
const int STAIRS_DOWN_EAST              = 8192;
const int STAIRS_DOWN_SOUTH             = 16384;
const int STAIRS_DOWN_WEST              = 32768;

const int MASK_DOOR                     = 15;
const int MASK_STAIRS /*up*/            = 3840;

const string TRANSITION_STAIRS_UP           = "StairsUp";
const string TRANSITION_STAIRS_DOWN         = "StairsDown";
const string TRANSITION_STAIRS_DIRECTION    = "StairsDirection";
const string TRANSITION_RANDOM_TRANSITION   = "RandomTransitionDoor";
const string TRANSITION_DOOR_WALL           = "Door";
const string TRANSITION_TARGET              = "Destination";
const string LEVEL                          = "Level";
const string DUNGEON                        = "Dungeon";
const string DUNGEON_LEVEL                  = "DungeonLevel";

const string AREA_PROP_DOOR_COUNT           = "NumberOfDoorsInArea";
const string AREA_PROP_DOOR_WALLS           = "Doors";
const string AREA_PROP_TILESET              = "TileSet";

const string QUE_NUMBER_OF_DOORS            = "DoorsToWork";
const string QUE_DOOR_BEING_WORKED          = "DoorToWork";

                /////////  AREA GEN CONSTANTS ////////

const int DOOR_OPEN_CLOSE_CHANGE            = 25;
const int DOOR_LOCK_UNLOCK_CHANGE           = 10;

                ////////////MAP CONSTANTS/////////////

const string MAP_ROOM_WP_TAG            = "MapRoomArrivalPoint";
const string MAP_LOC_BEFORE_USE         = "BeforeMapUse";
const string MAP_YOU_ARE_HERE           = "YouAreHere";
const string MAP_ERROR_OUTDOORS         = "Map only works in dungeons.";
const string MAP_ERROR_COMBAT           = "Map does not function in combat.";
const string MAP_DO_ONCE                = "DoOnce";
const string MAP_AREA                   = "MapArea";
const string MAP_COORDINATE_00          = "Coord00";
const string MAP_VISITED                = "Visited";
const string MAP_STAIRS_DOWN            = "StairsDown";
const string MAP_DEAD_END               = "DeadEnds";
const string MAP_3_WAY_USED             = "3WayUsed";
const string MAP_4_WAY_USED             = "4WayUsed";

const string RESREF_PLC_ROOM            = "map_room";
const string RESREF_PLC_YOU_ARE_HERE    = "marker_urhere";
const string RESREF_PLC_STAIRS_DOWN     = "marker_down";
const string RESREF_PLC_CORRIDOR        = "map_passage";

const string SCRIPT_ERASE_MAP           = "aex_id_erasemap";
                //////// TRANSITION CONSTANTS ///////
const string TRANSITION_DOOR            = "TD";
const string TRANSITION_PC              = "EO";
const string SCRIPT_AREA_SETUP          = "dtc_id_areasetup";

                   //////// CACHE CONSTANTS ////////
const string CACHE_OBJECT               = "O";
const string CACHE_RESREF               = "R";
const string CACHE_TAG                  = "T";
const string CACHE_LOCATION             = "L";
const string CACHE_FACING               = "F";
const string CACHE_NUMBER               = "N";
const string CACHE_AREA_CACHED          = "Cached";

                //////// NAMING CONVENTION CONSTANTS ////////
const string NAME_CON_AREAa              = "Area";

                //////// TEMP VARIABLE CONSTANTS //////////
const string TEMPORARYa                  = "Temp";
const string TEMPORARY2a                 = "Temp2";

/////////////////////////////END CONSTANTS/////////////////////////

///////////////////////////START PROTOTYPES////////////////////////

            /////////Dungeon Generatation Functions/////////

// Returns the dungeon that oPC is in.
int GetDungeon(object oPC);

// Returns the level that oPC is on.
// This has NO reference to GetDungeon but is often used with it.
int GetLevel(object oPC);

// Sets a variable if a dungeon level has been made.
void SetDungeonLevelMade(int nDungeon, int nLevel, int iStatus = TRUE);

// Returns the value set by the SetDungeonLevelMade function.
int GetDungeonLevelMade(int nDungeon, int nLevel);

// Sets weither or not an area has been used in a given dungeon level.
void SetAreaUsedInLevel(object oArea,int nDungeon = 1, int nLevel = 1,int iStatus = TRUE);

//Returns weither of not oArea has been used in the dungeon.
// This value is set by SetAreaUsedInLevel.
int GetAreaUsedInLevel(object oArea, int nDungeon, int nLevel);

// A simple wrapper for tracking dungeon level IDs.
string GetDungeonLevelId(int nDungeon,int nLevel);


            /////////Area Generatation Functions////////

// This function is only run on Module Load.
// It determines the door and stair locations of every area in the module.
// I am worried that at 500 areas this might TMI but only time will tell.
int DetermineAreaProperties(object oArea = OBJECT_SELF);

// This will return a set of stairs leading to oStairsDown.
// The returned object will be facing the same direction as oStairsDown
// This area will always be stored as coordinate 0,0 of the dungeon level.
object GetStairsUp(int nDungeon, int nLevel, int nTileSet);

// This function is the core of the level generation system it calls all the other functions.
// Basically it picks,arranges, and stores all the areas for the dungeon level.
void GenerateLevelMap(int nDungeon, int nLevel, int nTileSet = 0);

// This function generates an adjacent area behind a known door.
// It determines the facing of the door and determines the coordinates of the new area.
// Then uses GenerateArea to generate the proper area.
void WorkDoor (object oDoor, int nLevel, int nDungeon,int nTileSet);

// This function is a sub function of WorkDoor that actually generates the area.
// Then it is stored to it's target coordinates determined by WorkDoor.
object GenerateArea(int x,int y,int nDungeon,int nLevel,int nTileSet);

// Subfunction of GenerateArea.
// This subfunction determines random door placements based on known ones.
int GetRandomWallDoors(int nWallReqs,int nPossiblePos,int nNumber,int iMin);

// Subfunction of GetRandomWallDoors.
// It randomly returns one of the possible door positions supplied.
int GetRandomWall(int nPossiblePos);

// Used after all areas for the dungeon level have been placed.
// This function will find one dead end area and replace it with a matching stairs down area.
void ReplaceDeadEndWithStairsDown(int nDungeon, int nLevel, int nTileSet);


                /////////////Coord Functions///////////

// Stores a NON-STAIRS area to it's proper coordinate.
void StoreAreaToCoord(object oArea, int x, int y, int nLevel,int nDungeon,int nStairsDownOverRide = 0);

// Sets the coordinates of an area within a particular dungeon level.
// This function is used for STAIRS ONLY.
// It is also a subfunction of StoreAreaToCoord.
void SetCoordinates(object oArea,int x,int y, int nlevel = 1, int nDungeon = 1);

// Subfunction of both StoreAreaToCoord and SetCoordinates
// Returns a Complete Module Coordinate.
// Sets the Coordinates into an Area if valid.
string CoordinateName(int x, int y, int nLevel, int nDungeon,object oArea = OBJECT_INVALID);

// Returns the X coordinate of an area.
// This value is set by the CoordinateName function.
int GetAreaX (object oArea, int nLevel, int nDungeon);

// Returns the Y coordinate of an area.
// This value is set by the CoordinateName function.
int GetAreaY (object oArea, int nLevel, int nDungeon);

// Returns the area set by the SetCoordinates function.
// If no area has been set this function will return OBJECT_INVALID.
object GetAreaFromCoordinates(int x, int y, int nLevel, int nDungeon);

                ///////////Door Functions////////////

// Returns the valid door positions of an area, set by DetermineAreaProperties.
int GetAreaDoors(object oArea);

// Returns a door in a supplied area on WALL_*
object GetDoor(object oArea,int nWall);

// This will link Stairs Up to Stairs Down for area transition.
// nLevel must be the nLevel of oSource.
// oTarget is the Stairs Up.
// oSource is the Stairs Down.
void LinkDoors(int nDungeon, int nLevel,object oTarget, object oSource = OBJECT_SELF);

// Returns the Door destination set by the LinkDoors function.
// If a door was not linked by LinkDoors it looks to the appropriate adjacent coordinate for a destination door.
object GetDoorDestination(int nDungeon,int nLevel,object oDoor = OBJECT_SELF);

// Moves the party between levels.
// Specifically to the target set by LinkDoors.
// Because the areas are used on multiple floors the entire party must be moved level to level.
void LevelTransition(int nDungeon, int nLevel, object oClicker);

// Returns which wall a door is attached too.
int GetDoorWall(object oDoor);

// Will return the opposite wall of a door or supplied wall.
// ONLY USE 1 PERAMETER THE OTHER SHOULD BE LEFT TO INVALID.
// Attempting to use both will return WALL_INVALID
int GetOppositeWall(object oDoor = OBJECT_INVALID,int nWall = WALL_INVALID);

////////////////////////////END PROTOTYPES////////////////////////

///////////////////////////START FUNCTIONS////////////////////////

            //////////Dungeon Generatation Functions////////

//::///////////////////////////////////////////////
//:: Name: GetDungeon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to return what dungeon oPC is in.

Note only PCs have can valid dungeon levels.

This function is usually used inconjuction with GetLevel to track
what dungeon level a PC is on.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetDungeon(object oPC)
    {
    return GetLocalInt(oPC,DUNGEON);
    }

//::///////////////////////////////////////////////
//:: Name: GetLevel
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to return what level or a dungeon oPC is on.

Note only PCs have can valid dungeon levels.

This function is usually used inconjuction with GetDungeon to track
what dungeon level a PC is on.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetLevel(object oPC)
    {
    //return GetLocalInt(oPC,LEVEL); // Old ID line. Not used since Prototype 5.
    return GetLocalInt(GetModule(), "CurrentLevel"); // Prototype 5 change.
    }

//::///////////////////////////////////////////////
//:: Name: SetDungeonLevelMade
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to return what level or a dungeon oPC is on.

This function tells the module that a dungeon level has been generated.

nDungeon is usually the value returned by GetDungeon.

nLevel is usually a modified value returned by GetLevel.

iStatus is defaulted to TRUE, currently this should NOT be changed.
Numerous bad things can happen if this value is changed from TRUE.

Originally it was planned to have the ability to change floor layouts
behind the PC's however due to mapping system constraints this can
and will cause issues.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void SetDungeonLevelMade(int nDungeon, int nLevel, int nStatus)
    {
    SetLocalInt(GetModule(),GetDungeonLevelId(nDungeon,nLevel),nStatus);
    }

//::///////////////////////////////////////////////
//:: Name: SetDungeonLevelMade
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to return the value set by SetDungeonLevelMade.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetDungeonLevelMade(int nDungeon, int nLevel)
    {
    return GetLocalInt(GetModule(),GetDungeonLevelId(nDungeon,nLevel));
    }

//::///////////////////////////////////////////////
//:: Name: SetAreaUsedInLevel
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to track weither or not an area has been
used in particular dungeon level.

oArea is the area to be marked as used.

nDungeon is usually the value returned by GetDungeon.

nLevel is usually a modified value returned by GetLevel.

iStatus is defaulted to TRUE, currently this should NOT be changed.
Numerous bad things can happen if this value is changed from TRUE.

Originally it was planned to have the ability to change floor layouts
behind the PC's however due to mapping system constraints this can
and will cause issues.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void SetAreaUsedInLevel(object oArea,int nDungeon, int nLevel,int nStatus)
    {
    SetLocalInt(GetModule(),GetDungeonLevelId(nDungeon,nLevel)+GetTag(oArea),nStatus);
    }

//::///////////////////////////////////////////////
//:: Name: GetAreaUsedInLevel
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Simple wrapper function to get the value set by SetAreaUsedInLevel.
It is used to determine if the area has already been used on this
dungeon level.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetAreaUsedInLevel(object oArea, int nDungeon, int nLevel)
    {
    return GetLocalInt(GetModule(),GetDungeonLevelId(nDungeon,nLevel)+GetTag(oArea));
    }

//::///////////////////////////////////////////////
//:: Name: GetDungeonLevelId
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
A Dungeon Level ID commonly scripted here as nLevelID is used to
track things that happen on a particular dungeon level. Many
things in this module use the nLevelID as part of their variable
names.

nDungeon is usually the value returned by GetDungeon.

nLevel is usually the value returned by GetLevel.

As an example this function will return "001001" for
Dungeon 1 Level 1. "003020" for dungeon 3 level 20.

This string can then be combined with any other string value to
build a variable name that is for only this particular dungeon
level.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
string GetDungeonLevelId(int nDungeon, int nLevel)
    {
    return Convert3Digit(nDungeon)+Convert3Digit(nLevel);
    }

                ///////Area Generatation Functions///////

//::///////////////////////////////////////////////
//:: Name: DetermineAreaProperties
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Rather than build a 2da that will have to be updated or assign
variables to every area as it built I opted for this.

This function is run on module load. It will go thru every area in
the module and record that area's properties for future use by the
dungeon level generations system.

Currently this function records locations of Doors, Stairs Up,
and Stairs Down by what wall they are on.

At a later date I will add support for tracking other properties
about the area that will be a simple waypoint placed in the area
such as what tiles set the area comes from.

Currently this system works fine with approximately 100 test areas.
I have fears of a possible TMI with 500 areas. Depending on how
much data needs to be stored on module load.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int DetermineAreaProperties(object oArea)
{
int nDoorWall,nDoorLocs;
string sTag;
object oMod = GetModule();
// Cycle thru all the objects in the area.
object oAreaProp = GetFirstObjectInArea(oArea);
while(GetIsObjectValid(oAreaProp))
    {
    switch (GetObjectType(oAreaProp))
        {
        case OBJECT_TYPE_DOOR:
            {
            // Record the transition by it's type, be it up, down, or lateral.
            sTag = GetTag(oAreaProp);
            if (sTag == TRANSITION_STAIRS_UP)
                {
                // Determine stairs wall and store the properties.
                nDoorWall = GetDoorWall(oAreaProp);
                SetLocalObject(oArea,TRANSITION_STAIRS_UP,oAreaProp);
                SetLocalInt(oArea, TRANSITION_STAIRS_DIRECTION, nDoorWall);
                // Adjust the doors wall value bitwise for a STAIRS_UP_* value.
                nDoorLocs += (nDoorWall<<8);
                }
            else if (sTag == TRANSITION_STAIRS_DOWN)
                {
                // Determine stairs wall and store the properties.
                nDoorWall = GetDoorWall(oAreaProp);
                SetLocalObject(oArea,TRANSITION_STAIRS_DOWN,oAreaProp);
                SetLocalInt(oArea, TRANSITION_STAIRS_DIRECTION, GetDoorWall(oAreaProp));
                // Adjust the doors wall value bitwise for a STAIRS_DOWN_* value.
                nDoorLocs += nDoorWall<<12;
                }
            else if (GetIsObjectValid(GetTransitionTarget(oAreaProp))) // Make sure to only check area transition doors not internal ones.
                {
                // Determine what wall the door is on.
                nDoorWall = GetDoorWall(oAreaProp);
                // Store the door for area to area linking to known areas.
                SetLocalObject(oArea,TRANSITION_DOOR_WALL + IntToString(nDoorWall),oAreaProp);
                // Store door for linking to an unknown area.
                SetLocalObject(oMod,GetTag(oArea)+ TRANSITION_DOOR_WALL + IntToString(nDoorWall),oAreaProp); //Not sure this is used anymore.
                // Record the number of nonstair transition doors in the area.
                SetLocalInt(oArea, AREA_PROP_DOOR_COUNT, GetLocalInt(oArea, AREA_PROP_DOOR_COUNT) +1);
                // Increment the door wall tracker by this doors wall.
                nDoorLocs += nDoorWall;
                }
            break;
            }
        case OBJECT_TYPE_WAYPOINT:
            {
            // Set the Area TileSet value
            if (GetTag(oAreaProp) == AREA_PROP_TILESET)
                {
                SetLocalInt(oArea,AREA_PROP_TILESET,GetLocalInt(oAreaProp,AREA_PROP_TILESET));
                }
            break;
            }
        }
    oAreaProp = GetNextObjectInArea(oArea);
    }
// Records which area walls have doors.
// This means each compass direction can only have 1 door.
// No having 2 doors facing east as an example.
SetLocalInt(oArea,AREA_PROP_DOOR_WALLS,nDoorLocs);
return nDoorLocs;
}

//::///////////////////////////////////////////////
//:: Name: GenerateLevelMap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function generates the layout of a dungeon level.
It starts by generating a stair case up then generates the other
areas by branching of of it. Building and working a door cue as it
goes until it runs out of doors.

Once the floor is gnerated 1 dead is picked at random and replaced
with a stair case down.

This function is called by the stairs down used to enter the level
being generated.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void GenerateLevelMap(int nDungeon, int nLevel, int nTileSet)
{
// Prevent the dungeon level from being recreated.
SetDungeonLevelMade(nDungeon,nLevel);
object oMod = GetModule();
string sLevelID = GetDungeonLevelId(nDungeon,nLevel);
// Determine the stairs back up. Everything in dungeon level will branch from it.
//Get a Stairs Area that matches the Stairs Down used and link them.
object oArea = GetStairsUp(nDungeon,nLevel,nTileSet);
// Because of how this is done stairs areas should only have 1 exit into the rest of the level.
object oDoor = GetDoor(oArea,GetAreaDoors(oArea) & MASK_DOOR);
int iDoorToWork = 1;
//Set the starting point for the door cue.
SetLocalInt(oMod,QUE_NUMBER_OF_DOORS +sLevelID, iDoorToWork);
// Work thru the door que.
while (GetIsObjectValid(oDoor))
    {
    WorkDoor(oDoor,nLevel,nDungeon,nTileSet);
    oDoor = GetLocalObject(oMod, QUE_DOOR_BEING_WORKED + IntToString(iDoorToWork += 1) + sLevelID);
    }
// Dungeon level is generated, replace 1 dead end with a stair down.
// This may need to be changed later for limited floor dungeons with an actual bottom.
ReplaceDeadEndWithStairsDown(nDungeon,nLevel,nTileSet);
}

//::///////////////////////////////////////////////
//:: Name GetStairsUp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function is called by the stairs down that generated the level.
It is a subfunction of GenerateLevelMap.

Currently all stairs only have 1 exit and it must be opposite the
stairs. If this changes this funtion will need to be reworked.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////

object GetStairsUp(int nDungeon, int nLevel, int nTileSet)
    {
    object oMod = GetModule();
    object oArea;
    int nRandom;
    //Set the base Tileset Ref
    string sRef = IntToString(nTileSet);
    // The door that leads to the rest of the dungeon must match the direction of the stairs down.
    int nRestrictions = GetDoorWall(OBJECT_SELF);
    // Set the stairs position req.
    nRestrictions += (GetOppositeWall(OBJECT_SELF)<<8);
    //Update ref by restrictions.
    sRef += IntToString(nRestrictions);
    // Get the number of possible combinations of this, determined
    // at module load by DetermineAreaProperties.
    nRandom = GetLocalInt(oMod,sRef);
    // Get a random area that matches the restrictions.
    sRef += Convert3Digit(Random(nRandom)+1);
    oArea = GetLocalObject(oMod,sRef);
    if (GetIsObjectValid(oArea))
        {
        //Transition link the stairs down to this newly generated
        // stairs up.
        LinkDoors(nDungeon,nLevel,GetLocalObject(oArea,TRANSITION_STAIRS_UP));
        //Set the area as used for this dungeon level.
        SetAreaUsedInLevel(oArea,nDungeon,nLevel);
        //Set the Area to it's coordintates.
        SetCoordinates(oArea,0,0,nLevel,nDungeon);
        return oArea;
        }
    //Something went wrong try again.
    return GetStairsUp(nDungeon,nLevel,nTileSet); //THIS SHOULD NEVER HAPPEN!
    }

//::///////////////////////////////////////////////
//:: Name WorkDoor
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GenerateLevelMap. It simply supplies
a modified coordinate, based on the coordinate of the door area, to
the GenerateArea function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void WorkDoor (object oDoor, int nLevel, int nDungeon,int nTileSet)
    {
    object oArea = GetArea(oDoor);
    int x = GetAreaX (oArea,nLevel,nDungeon);
    int y = GetAreaY (oArea,nLevel,nDungeon);
    switch(GetDoorWall(oDoor))
        {
        case WALL_NORTH: {GenerateArea(x,y+1,nDungeon,nLevel,nTileSet);break;}
        case WALL_EAST:  {GenerateArea(x+1,y,nDungeon,nLevel,nTileSet);break;}
        case WALL_SOUTH: {GenerateArea(x,y-1,nDungeon,nLevel,nTileSet);break;}
        case WALL_WEST:  {GenerateArea(x-1,y,nDungeon,nLevel,nTileSet);break;}
        }
    }

//::///////////////////////////////////////////////
//:: Name GenerateArea
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GenerateLevelMap. It selects an area and
records it to a dungeon level coordinate.

This selection is based on a number of requirements. Doors and
blank walls must match up too adjacent areas. Once those
requirements are determined a random area is picked to fill them.

Once the area is selected it's doors are added to the door que
still running in the GenerateLevelMap function

At the beginning of this process there is a high percentage that a
4-way or 3-way transition area will be selected. As these are used
their percentage drops and the chances of 2-way transition or dead
end increase.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
object GenerateArea(int x,int y,int nDungeon,int nLevel,int nTileSet)
{
object oAdjArea = GetAreaFromCoordinates(x,y,nLevel,nDungeon);
if (GetIsObjectValid(oAdjArea))
    {
    // If an adjacent area is found terminate immediately.
    // The que will advance to the next door.
    return oAdjArea;
    }
object oMod = GetModule();
object oAdjDoor;
int nWall,nWallReqs,nPossiblePos,nMin;
int n3WayUsed,n4WayUsed;
int n2Way,n3Way,n4Way;
int nRoll,nCounter,nTemp,nMap;
int nMax = 4;
string sRef = IntToString(nTileSet);
string sLevelID = GetDungeonLevelId(nDungeon,nLevel);
string sTable;
// Cycle thru the walls of this area and determine restrictions
// based on adjacent coordinates. Once this loop is terminated
// all non stair coordinate restrictions should be set.
for (nWall = WALL_NORTH; nWall <= WALL_WEST; nWall= nWall << 1)
    {
    // Attempt to find adjacent areas. Working clockwise around
    // the area.
    switch (nWall)
        {
        case WALL_NORTH:    {oAdjArea = GetAreaFromCoordinates(x,y+1,nLevel,nDungeon);break;}
        case WALL_EAST:     {oAdjArea = GetAreaFromCoordinates(x+1,y,nLevel,nDungeon);break;}
        case WALL_SOUTH:    {oAdjArea = GetAreaFromCoordinates(x,y-1,nLevel,nDungeon);break;}
        case WALL_WEST:     {oAdjArea = GetAreaFromCoordinates(x-1,y,nLevel,nDungeon);break;}
        }
    if (GetIsObjectValid(oAdjArea))
        {
        // Found an area at adjacent coord.
        oAdjDoor = GetDoor(oAdjArea,GetOppositeWall(OBJECT_INVALID,nWall));
        if (GetIsObjectValid(oAdjDoor))
            {
            // Door was found on opposite side of this wall a
            // door MUST be placed on this side of the wall.
            nWallReqs += nWall;
            nMin+=1;
            }
        else
            {
            // Door was not found. Lower the number of maximum
            // doors for this coord.
            nMax-=1;
            }
        }
    else
        {
        // A possible door position with no requirements has
        // been found.
        nPossiblePos+=nWall;
        }
    }
// Generate a "random" number of connections based on
// coordinate restrictions.
n4WayUsed = GetLocalInt(oMod,sLevelID + MAP_4_WAY_USED);
n3WayUsed = GetLocalInt(oMod,sLevelID + MAP_3_WAY_USED);
// Generate chances of a particular type of area.
// This is a d100 roll.
// Compute Odds of 4 way connection
if (nMin == 4)
    {
    n4Way = 100;
    }
else if (nMax < 4)
    {
    n4Way = 0;
    }
else
    {
    n4Way = CHANCE_OF_4_WAY_EXIT  - (LEVEL_SIZE * n4WayUsed);
    }
// Compute Odds of 3 way connection
if (n4Way < 100)
    {
    if (nMin == 3 && nMax == 3)
        {
        n3Way = 100;
        }
    else if (nMax < 3)
        {
        n3Way = 0;
        }
    else
        {
        n3Way = n4Way + CHANCE_OF_3_WAY_EXIT  - (LEVEL_SIZE * n3WayUsed);
        }
    }
// Compute Odds of 2 way connection
if (n3Way < 100)
    {
    if (nMin == 2 && nMax == 2)
        {
        n2Way = 100;
        }
    else if (nMax < 2)
        {
        n2Way = 0;
        }
    else
        {
        n2Way   = n3Way + CHANCE_OF_2_WAY_EXIT + (LEVEL_SIZE * n4WayUsed);
        }
    }
// Find random door placements and place the area.
oAdjArea = OBJECT_INVALID;
// Search for an area until we find one that meets the
// requirements.
while(!GetIsObjectValid(oAdjArea))
    {
    // Find out how many transitions the random area should
    // have.
    nRoll = d100();
    if (nRoll <= n4Way)
        {
        //Nothing random about 4 doors.
        nWallReqs = 15;
        }
    else if (nRoll <= n3Way)
        {
        if (nMax != 3)
            {
            if (nMin < 3)
                {
                nWallReqs = GetRandomWallDoors(nWallReqs,nPossiblePos,3,nMin);
                }
            else
                {
                nWallReqs += nPossiblePos;
                }
            }
        else
            {
            nWallReqs += nPossiblePos;
            }
        }
    else if (nRoll <= n2Way)
        {
        if (nMax != 2)
            {
            if (nMin < 2)
                {
                nWallReqs = GetRandomWallDoors(nWallReqs,nPossiblePos,2,nMin);
                }
            else
                {
                nWallReqs += nPossiblePos;
                }
            }
        else
            {
            nWallReqs += nPossiblePos;
            }
        }
    // If the roll matches none of the above a Dead End is
    // generated by default.

    // Select a random area that meets the requirements we
    // have determined above.
    sRef += IntToString(nWallReqs);
    sRef += Convert3Digit(Random(GetLocalInt(oMod,sRef))+1);
    // sRef refers to the variable name we stored the area into
    // during module load using the DetermineAreaProperties.
    oAdjArea = GetLocalObject(oMod,sRef);
    //Area was already used on this level used get another.
    if (GetAreaUsedInLevel(oAdjArea,nDungeon,nLevel))
        {
        // Stack Overflow Correction.
        // A loop just didn't work so start over and hope.
        // This may cause a TMI.
        // In theory more areas will prevent a TMI here
        // However it my cause a TMI in the module load.
        oAdjArea = GenerateArea(x,y,nDungeon,nLevel,nTileSet);
        }
    }
// Set the area to it's coordinate.
StoreAreaToCoord(oAdjArea,x,y,nLevel,nDungeon);
// Store Map Information
nMap = GetLocalInt(oMod, MAP_AREA + sLevelID);
SetLocalInt(oMod, MAP_AREA + sLevelID, nMap += 1);
SetLocalObject(oMod, MAP_AREA + sLevelID + IntToString(nMap), oAdjArea);
return oAdjArea;
}

//::///////////////////////////////////////////////
//:: Name GetRandomWallDoors
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GenerateArea it is not meant for external
use. This function will take the required doors and randomly add
possible door positions until the number of doors is equal to
nNumber.

This function is useful for if you have 2 required doors but need
a third. It will randomly pick one of the 2 possible positions.
Then it returns the new door requirements to GenerateArea.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetRandomWallDoors(int nWallReqs,int nPossiblePos,int nNumber,int nMin)
{
int nTemp;
int nCounter = 1;
while (nCounter <= nNumber - nMin)
    {
    nTemp = GetRandomWall(nPossiblePos); // Of the possible door positions generate 1 randomly to use.
    nPossiblePos -= nTemp;
    nWallReqs += nTemp;
    nCounter+=1;
    }
return nWallReqs;
}
//::///////////////////////////////////////////////
//:: Name GetRandomWallDoors
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GetRandomWallDoors it is not meant for
external use. It randomly picks 1 wall from the available
possibilities.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetRandomWall(int nPossiblePos)
{
int nTemp = 0;
while(!(nTemp & nPossiblePos))
    {
    nTemp = d4();
    if (nTemp > 1)
        nTemp = (1<<(nTemp-1));
    }
return nTemp;
}

//::///////////////////////////////////////////////
//:: Name ReplaceDeadEndWithStairsDown
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GenerateLevelMap it is not meant for
external use.

It randomly picks 1 dead end in the current level map and replaces
it with an appropriate stairs down. The stairs down areas are
specially stored by the StoreAreaToCoord function just for this
purpose.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void ReplaceDeadEndWithStairsDown(int nDungeon, int nLevel, int nTileSet)
{
object oMod = GetModule();
object oStairsDown;
int i = 1;
string sRef;
string sLevelID = GetDungeonLevelId(nDungeon,nLevel);
// Determine the dead end area to be replaced.
int nRandomDeadEnd = Random(GetLocalInt(oMod,sLevelID + MAP_DEAD_END))+1;//Bug fix the +1 was inside the random instead of outside of it.
object oDeadEnd = GetLocalObject(oMod,sLevelID + MAP_DEAD_END + IntToString(nRandomDeadEnd));
// Get the dead ends coordinates so the stairs down can be
// placed in same coordinates.
int x = GetAreaX(oDeadEnd,nLevel,nDungeon);
int y = GetAreaY (oDeadEnd,nLevel,nDungeon);
// Determine the stairs down placement restrictions.
int nTemplate = GetAreaDoors(oDeadEnd);
nTemplate += (GetOppositeWall(OBJECT_INVALID,nTemplate)<<12);
sRef = IntToString(nTileSet) + IntToString(nTemplate);
sRef += Convert3Digit(Random(GetLocalInt(oMod,sRef))+1);
oStairsDown = GetLocalObject(oMod,sRef);
// Cycle thru all the areas on the dungeon level.
while(i <= GetLocalInt(oMod,MAP_AREA + sLevelID))
    {
    sRef = MAP_AREA + sLevelID + IntToString(i);
    if (oDeadEnd == GetLocalObject(oMod, sRef))
        {
        // Exchange the Dead End with the Stairs Down.
        SetLocalObject(oMod,sRef,oStairsDown);
        }
    i+=1;
    }
SetAreaUsedInLevel(oDeadEnd,nDungeon,nLevel,FALSE);
SetAreaUsedInLevel(oStairsDown,nDungeon,nLevel,TRUE);
StoreAreaToCoord(oStairsDown,x,y,nLevel,nDungeon,TRUE);
// Mark this area as the stairs down for this area for the map.
SetLocalInt(oStairsDown,TRANSITION_STAIRS_DOWN + sLevelID,TRUE);
}

                /////////// Coord Functions /////////////


//::///////////////////////////////////////////////
//:: Name: StoreAreaToCoord
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GenerateLevelMap it is not meant for
external use.

This will store an area to a x,y,dungeon level coordinate.

This coordinate system accomplishes a several things.
1. It prevents remapping of areas that have already been generated.
2. It helps the area generation system to find viable and unviable
   walls for area requirements. Preventing illegal collisions of
   a door and a wall.
3. Tells the maping system exactly where to put the map pieces
   representing an area and it's corridors.

*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void StoreAreaToCoord(object oArea, int x, int y, int nLevel,int nDungeon,int iStairsDownOverRide)
{
if ((!GetIsObjectValid(GetAreaFromCoordinates(x,y,nLevel,nDungeon))) || iStairsDownOverRide) // Make sure we aren't repeating work after the TMI Corection..
    {
    object oMod = GetModule();
    string sLevelID = GetDungeonLevelId(nDungeon,nLevel);
    int nDoor = GetLocalInt(oArea,AREA_PROP_DOOR_COUNT);
    int nDeadEnds, nWall;;
    // Store the area to coord and prevent reuse in this level.
    SetAreaUsedInLevel(oArea,nDungeon,nLevel);                  //Set the area as used for this dungeon level.
    SetCoordinates(oArea,x,y,nLevel,nDungeon);                  //Record this area at it's coordinates
    // Store the number of these types of areas used to allow for proper dungeon size scaling.
    if (nDoor == 4)
        {
        SetLocalInt(oMod,sLevelID + MAP_4_WAY_USED,GetLocalInt(oMod,sLevelID+MAP_4_WAY_USED)+1);
        }
    else if (nDoor == 3)
        {
        SetLocalInt(oMod,sLevelID + MAP_3_WAY_USED,GetLocalInt(oMod,sLevelID+MAP_3_WAY_USED)+1);
        }
    //Store dead ends so that we can replace 1 at end of level gen with stairs down.
    else if (nDoor == 1)
        {
        // Make sure not to flag stairs up areas.
        if (!(MASK_STAIRS & GetAreaDoors(oArea)))
            {
            nDeadEnds = GetLocalInt(oMod,sLevelID + MAP_DEAD_END) + 1;
            SetLocalInt(oMod, sLevelID + MAP_DEAD_END, nDeadEnds);
            SetLocalObject(oMod, sLevelID + MAP_DEAD_END + IntToString(nDeadEnds), oArea);
            }
        }
   // This area is now set to it's coordinate. Que it's doors to determine surrounding areas.
   for (nWall = WALL_NORTH; nWall <= WALL_WEST; nWall = nWall<<1)
        {
        // If there is a valid door cue it to be worked.
        if (nWall & GetAreaDoors(oArea))
            {
            nDoor = GetLocalInt(oMod,QUE_NUMBER_OF_DOORS+sLevelID)+1;
            SetLocalInt(oMod,QUE_NUMBER_OF_DOORS+sLevelID,nDoor);
            SetLocalObject(oMod, QUE_DOOR_BEING_WORKED + IntToString(nDoor) + sLevelID, GetDoor(oArea,nWall));
            }
        }
    }
}
//::///////////////////////////////////////////////
//:: Name: SetCoordinates
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of StoreAreaToCoord it is not meant for
external use.

This is function is a wrapper that sets the coordinate for the
area.

This information can later be retrieved using GetAreaX and
GetAreaY.

*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
void SetCoordinates(object oArea,int x,int y, int nLevel, int nDungeon)
{
string sCoord = CoordinateName(x,y,nLevel,nDungeon,oArea);
SetLocalObject(GetModule(),sCoord,oArea);
}

//::///////////////////////////////////////////////
//:: Name: CoordinateName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of SetCoordinates and GetAreaFromCoordinates it is not meant for
external use.

This function stores the X,Y corridinates to the area for a
particular dungeon level. This information can later be retrieved
using the GetAreaX and GetAreaY functions.

It also returns a unique string to be used by SetCoordinates and
GetAreaFromCoordinates to to store and retrieve the area from that
specific coordinate.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
string CoordinateName(int x, int y, int nLevel, int nDungeon, object oArea)
{
string sID = GetDungeonLevelId(nDungeon,nLevel);
if (GetIsObjectValid(oArea))
    {
    SetLocalInt(oArea,sID+"X",x);
    SetLocalInt(oArea,sID+"Y",y);
    }
return sID+Convert3Digit(x)+Convert3Digit(y);
}

//::///////////////////////////////////////////////
//:: Name: GetAreaX
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function can be used to find out what the X coordinate is for
an area within a specific dungeon level.

This vaule is set by the CoordinateName function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetAreaX (object oArea, int nLevel, int nDungeon)
{
return GetLocalInt(oArea,GetDungeonLevelId(nDungeon,nLevel)+"X");
}

//::///////////////////////////////////////////////
//:: Name: GetAreaY
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function can be used to find out what the Y coordinate is for
an area within a specific dungeon level.

This vaule is set by the CoordinateName function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
int GetAreaY (object oArea, int nLevel, int nDungeon)
{
return GetLocalInt(oArea,GetDungeonLevelId(nDungeon,nLevel)+"Y");
}

//::///////////////////////////////////////////////
//:: Name: GetAreaFromCoordinates
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function is used to get the area at a specific X,Y, dungeon
level coordinate.

This informations is stored in by the SetCoordinates function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: June 6 2005
//:://////////////////////////////////////////////
object GetAreaFromCoordinates(int x, int y, int nLevel, int nDungeon)
{
return GetLocalObject(GetModule(),CoordinateName(x,y,nLevel,nDungeon));
}


                //////// Door Functions ////////


//::///////////////////////////////////////////////
//:: Name GetAreaDoors
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function will retrieve the door properties from an area that
were recorded on module load by the DetermineAreaProperties
function.

It returns the valid WALL_* and STAIR_* wall locations of the area
which can be checked for using bitwise math.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
int GetAreaDoors(object oArea)
{
return GetLocalInt(oArea,AREA_PROP_DOOR_WALLS);
}

//::///////////////////////////////////////////////
//:: Name GetDoor
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Returns the door on the supplied WALL_* in oArea.

This information is stored on Module Load by the
DetermineAreaProperties function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
object GetDoor(object oArea,int nWall)
{
if (nWall != WALL_INVALID)
    {
    return GetLocalObject(oArea, TRANSITION_DOOR_WALL + IntToString(nWall));
    }
return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: Name LinkDoors
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is a subfunction of GetStairsUp and is not meant to be
externally used. it links 2 doors on different levels of the same
dungeon.

Specifically the door on the newly generated level is linked
backwards to the previous level.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
void LinkDoors(int nDungeon, int nLevel,object oTarget, object oSource)
{
string sID = GetDungeonLevelId(nDungeon,nLevel);
SetLocalObject(oSource, sID + TRANSITION_TARGET, oTarget);
if (GetTag(oSource) == TRANSITION_STAIRS_DOWN)
    {
    sID = GetDungeonLevelId(nDungeon,nLevel-1);
    }
SetLocalObject(oTarget, sID + TRANSITION_TARGET, oSource);
}

//::///////////////////////////////////////////////
//:: Name GetDoorDestination
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function can be used to find what staircase a staircase is
linked too for level changing area transitions.

It can also be used by a normal transition door to find a matching
door in an adjacent area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
object GetDoorDestination(int nDungeon,int nLevel,object oDoor)
{
object oDest = GetLocalObject(oDoor, GetDungeonLevelId(nDungeon,nLevel) + TRANSITION_TARGET);
// Stairs have recorded Destinations. Set by the LinkDoors
// function.
if (GetIsObjectValid(oDest))
    {
    return oDest;
    }
// Other types of doors look for the matching door on the other side of the wall.
object oArea = GetArea(oDoor);
int x = GetAreaX (oArea,nLevel,nDungeon);
int y = GetAreaY (oArea,nLevel,nDungeon);
int nWall = GetDoorWall(oDoor);
switch(nWall)
    {
    case WALL_NORTH: {y+=1;break;}
    case WALL_EAST:  {x+=1;break;}
    case WALL_SOUTH: {y-=1;break;}
    case WALL_WEST:  {x-=1;break;}
    };
object oAdjArea = GetAreaFromCoordinates(x,y,nLevel,nDungeon);
//Remove Fog of war from the adjacent area's map tile.
SetLocalInt(oAdjArea,MAP_VISITED + GetDungeonLevelId(nDungeon,nLevel), TRUE);
return GetDoor(oAdjArea, GetOppositeWall(OBJECT_INVALID, nWall));
}

//::///////////////////////////////////////////////
//:: Name LevelTransition
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function is used to transition the entire party from one
dungeon level to another. This function is meant strictly for use
on stair cases or other objects that have had their destination
set by the LinkDoors function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
void LevelTransition(int nDungeon, int nLevel, object oPC)
{
object oDestination = GetDoorDestination(nDungeon,nLevel);
object oParty = GetFirstFactionMember(oPC,FALSE);
while(GetIsObjectValid(oParty))
    {
    SetLocalInt(oParty,LEVEL,nLevel);
    AssignCommand(oParty,JumpToObject(oDestination));
    oParty = GetNextFactionMember(oPC,FALSE);
    }
}

//::///////////////////////////////////////////////
//:: Name GetDoorWall
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function is used to determine what wall a door is on.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
int GetDoorWall(object oDoor)
{
int nFace = FloatToInt(GetFacing(oDoor));
if (nFace == 45 | 135 | 225 | 315)
    {
    if (d2() == 1)
        {
        nFace +=1;
        }
    else
        {
        nFace -=1;
        }
    }
if (nFace > 45 && nFace < 135)
    {
    return WALL_NORTH;
    }
else if (nFace > 135 && nFace < 225)
    {
    return WALL_WEST;
    }
else if (nFace > 225 && nFace < 315)
    {
    return WALL_SOUTH;
    }
else if (nFace > 315 || nFace < 45)
    {
    return WALL_EAST;
    }
// This should NEVER happen! Placed for compile reasons.
return WALL_INVALID;
}

//::///////////////////////////////////////////////
//:: Name GetOppositeWall
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This function will return the opposite WALL_*.
This can be used to either find the opposite side of a door or a
wall. Only 1 perameter can be used or an error will result.

Example a door on the east wall will return WALL_WEST.
If supplied WALL_NORTH then WALL_SOUTH will be returned.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On:June 6 2005
//:://////////////////////////////////////////////
int GetOppositeWall(object oDoor = OBJECT_INVALID,int nWall = WALL_INVALID)
    {
    if (GetIsObjectValid(oDoor) && nWall != WALL_INVALID)
        {
        return WALL_INVALID; // ONLY 1 perameter on at a time please!
        }
    else
        {
        if (GetIsObjectValid(oDoor))
            {
            nWall = GetDoorWall(oDoor);
            }
        switch (nWall)
            {
            case WALL_NORTH:
                {
                return WALL_SOUTH;
                }
            case WALL_WEST:
                {
                return WALL_EAST;
                }
            case WALL_SOUTH:
                {
                return WALL_NORTH;
                }
            case WALL_EAST:
                {
                return WALL_WEST;
                }
            };
        return WALL_INVALID; // Added for compile reasons only. THIS SHOULD NEVER HAPPEN!
        }
    }
