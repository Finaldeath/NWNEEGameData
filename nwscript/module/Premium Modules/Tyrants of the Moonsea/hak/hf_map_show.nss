//:://////////////////////////////////////////////////
//:: hf_map_show
/*
  OnClicked script for transition triggers that transition
  to the world map area.

  This script will set a variable on the PC which stores the
  tag of the area they are coming from, in case they want to
  return to this area from the world map, and so we know
  which direction the player is traveling to to reach
  their new destination.

  The beginning area could also transition the player to
  a specific waypoint in the world map, corresponding to
  this area's location.

*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2005 Bioware Corp.
//:: Created By: Brian Watson for Ossian Studios
//:: Created On: 8/9/2005
//:://////////////////////////////////////////////////

#include "hf_in_worldmap"
#include "x3_inc_horse"

void main()
{
    object oClicker = GetClickingObject();

    if (!GetIsObjectValid(oClicker))
    {
        oClicker = GetEnteringObject(); // handle doors
    }

    if (!GetIsPC(oClicker)) // no enemies in world map area!
    {
        AssignCommand(oClicker, ClearAllActions());
        AssignCommand(oClicker, ActionMoveAwayFromObject(OBJECT_SELF, FALSE, 10.0f));
        return;
    }

    // call an update now to double-check for icon usability status
    UpdateWorldMap(oClicker);

    object oTarget = GetTransitionTarget(OBJECT_SELF);
    location lTarget = GetLocation(oTarget);

    // set some variables on pc for world map
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));
    SetLocalString(oClicker, "sWM_PreviousArea", sAreaTag);

    string sReturnTrig = GetTag(OBJECT_SELF);
    SetLocalString(oClicker, "sWM_PreviousTrig", sReturnTrig);

    SetLocalInt(oClicker, "nWM_UsedInventoryMap", 0); // clear any previous setting

    // check for adjacent areas that might be revealed
    // this is based off of the name of the calling object
    // for example: East Entrance
    string sDir;
    string sName = GetName(OBJECT_SELF);
    string sLeft = GetStringLowerCase(GetStringLeft(sName, 4));
    if      (sLeft == "nort") sDir = "North";
    else if (sLeft == "sout") sDir = "South";
    else if (sLeft == "west") sDir = "West";
    else if (sLeft == "east") sDir = "East";

    // rather than encoding the direction in the tag, we can use variables
    // this overrides whatever the tag was saying
    if (GetLocalString(OBJECT_SELF, "HF_MAP_DIRECTION") != "")
    {
        sDir = GetLocalString(OBJECT_SELF, "HF_MAP_DIRECTION");
    }

    string sColumn = ("AdjArea_" + sDir);
    int nRow = 0;
    string sRevealed = "";
    string sLookup = Get2DAString(sWM_MAP2DA, sWM_MAP2DA_AREA, nRow);
    while ((sLookup != "") && (sRevealed == ""))
    {
        if (sLookup == sAreaTag) // found this area in world map listing
        {
            sRevealed = Get2DAString(sWM_MAP2DA, sColumn, nRow);
        }
        nRow += 1;
        sLookup = Get2DAString(sWM_MAP2DA, sWM_MAP2DA_AREA, nRow);
    }

    if (sRevealed != "") // valid reveal area listed for this direction
    {
        /*
        // DEBUG
        SendMessageToPC(oClicker, "DEBUG: Area adjacent: " + sRevealed);
        // DEBUG
        */

        RevealMapLocation(sRevealed);
        SetLocalString(oClicker, "sWM_AdjacentArea", sRevealed);
    }
    else
    {
        DeleteLocalString(oClicker, "sWM_AdjacentArea");
    }

    AssignCommand(oClicker, ClearAllActions());
    AssignCommand(oClicker, JumpToLocation(lTarget));
}

/*
Area transition triggers have some variables:

HF_MAP_DIRECTION = North | South | East | West
  Determines the direction that this exit faces and thus which new adjacent area
  is revealed on the world map.

HF_MAP_HORSE_HITCHING_POST = tag
  If set, the party's horses will be hitched at the given waypoint.
*/
