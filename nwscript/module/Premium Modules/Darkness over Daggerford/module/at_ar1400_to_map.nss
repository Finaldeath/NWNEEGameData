// this script was damian's, rewritten on 7/14/06 by brian

#include "inc_bw_worldmap"

void main()
{
    //object oPC=GetPCSpeaker();
    //ExecuteScript("c3t_atc_to_map",oPC);  // sorry, we can't do this!

    object oClicker = GetPCSpeaker(); // use oClicker for below...

    // ================================================================
    // WHAT FOLLOWS ORIGINATED IN c3t_atc_to_map,
    // REWRITTEN TO WORK IN A CONVERSATION
    // NOTE: THIS IS SPECIFIC TO THIS TRANSITION!
    // TO MODIFY THIS SCRIPT TO WORK FROM OTHER LOCATIONS,
    // CHANGE THE RELEVANT VARIABLES HERE:

    // THIS IS THE TAG OF THE TRIGGER OR DOOR WE WANT TO JUMP TO
    // OR, THE WAYPOINT FOR THE WORLD MAP ("wmp_mapcenter")
    string sTarget = "wmp_mapcenter";

    // THIS IS THE TAG OF THE NEARBY *TRIGGER/DOOR* THAT TRANSITIONS
    // TO THE WORLD MAP, SO WE CAN RETURN THERE IF WE CANCEL TRAVEL:
    string sReturnTrig = "AR1400_AR1300_EXIT";

    // END TRANSITION SPECIFIC VAR'S
    // ================================================================


    // find destination location
    location lTarget = GetLocation(GetObjectByTag(sTarget));

    // call an update now to double-check for icon usability status
    UpdateWorldMap(oClicker);

    // set some variables on pc for world map
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));
    sAreaTag = GetStringLowerCase(GetStringLeft(sAreaTag, nWM_AREAPREFIX));

    SetLocalString(oClicker, "sWM_PreviousArea", sAreaTag);
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
