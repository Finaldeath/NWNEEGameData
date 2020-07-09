//:://////////////////////////////////////////////////
//:: c3t_atc_to_map
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

#include "inc_bw_worldmap"

void main()
{
    object oClicker = GetClickingObject();

    //code added by damian 21/11/05
    object oMap=GetItemPossessedBy(oClicker,"db_directions");
    if(GetIsObjectValid(oMap)==0)

    //end additional code
    {
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

        object oTarget = GetTransitionTarget(OBJECT_SELF);
        location lTarget = GetLocation(oTarget);

        // set some variables on pc for world map
        string sAreaTag = GetTag(GetArea(OBJECT_SELF));
        sAreaTag = GetStringLowerCase(GetStringLeft(sAreaTag, nWM_AREAPREFIX));
        SetLocalString(oClicker, "sWM_PreviousArea", sAreaTag);

        string sReturnTrig = GetTag(OBJECT_SELF);
        SetLocalString(oClicker, "sWM_PreviousTrig", sReturnTrig);

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
    else
    {
         AssignCommand(oClicker,ClearAllActions());
         AssignCommand(oClicker,ActionStartConversation(oClicker,"db_ar1400exit", FALSE, FALSE));
    }
}
