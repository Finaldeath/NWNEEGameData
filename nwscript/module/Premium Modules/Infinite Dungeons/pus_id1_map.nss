//:://////////////////////////////////////////////////////////////
//:: pus_id1_map                                                //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script is on the activation of the map item in the PC's
    inventory. First it checks to see if there are more than the
    maximum number of maps already created. This is just to make
    sure that there aren't a huge number open at once crowding
    everything. It then creates a map object and spawns in a
    limited map CPU set to create the actual map. The map
    generation script is then activated on the first map CPU
    object.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_clean"
#include "inc_id1_flags"
#include "inc_id1_var"
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Dungeon map used.");

    // determine the activating player
    object oPC = GetItemActivator();

    if (oPC != OBJECT_INVALID)
    {
        DebugMessage("  PC valid.");

        // if the dungeon entrance
        object oArea = GetArea(oPC);
        if (GetTag(oArea) != "DungeonEntrance")
        {
            DebugMessage("  Area is not dungeon entrance.");

            // if a dungeon is not selected
            object oDungeon = GetCurrentDungeon();
            if (oDungeon != OBJECT_INVALID)
            {
                DebugMessage("  Dungeon is valid.");

                int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
                if ((nCurrentLevel > 0) && (nCurrentLevel <= nMaxLevel))
                {
                    DebugMessage("  Level is valid.");

                    string sDungeonName = GetLocalString(oDungeon, "sDungeonName");

                    // if a map is already active
                    object oActiveMap = GetLocalObject(oPC, "oActiveMap");
                    if (oActiveMap != OBJECT_INVALID)
                    {
                        DebugMessage("  A map is already active.");

                        // check distance
                        float fDistance = GetDistanceBetween(oActiveMap, oPC);
                        DebugMessage("  Map distance is " + FloatToString(fDistance));

                        // set map as false
                        SetLocalObject(oPC, "oActiveMap", OBJECT_INVALID);

                        // if in a different area
                        object oMapArea = GetArea(oActiveMap);
                        if (oMapArea != oArea)
                        {
                            DebugMessage("  Old map is in a different area.");
                        }

                        string sDungeonName = GetLocalString(oDungeon, "sDungeonName");

                        // if far enough away or in a different area
                        if ((fDistance >= 5.0) || (oMapArea != oArea))
                        {
                            // create a new map
                            SendMessageToPC(oPC, "Dungeon Map of Level " + IntToString(nCurrentLevel) + " of " + sDungeonName + ".");

                            int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                            int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                            // create new map
                            object oMap = CreateObject(OBJECT_TYPE_PLACEABLE, "Map", GetLocation(oPC));
                            SetLocalObject(oMap, "oCreator", oPC);
                            SetLocalInt(oMap, "nPCArea", nAreaNum);
                            SetLocalInt(oMap, "nLevel", nCurrentLevel);
                            SetLocalObject(oMap, "oDungeon", oDungeon);

                            // set map as active
                            SetLocalObject(oPC, "oActiveMap", oMap);

                            // run map generation script
                            DelayCommand(0.01, ExecuteScript("exe_id1_mapgen", oMap));
                        } else
                        {
                            // remove an old map
                            SendMessageToPC(oPC, "Cleaning up Dungeon Map.");
                        }
                    } else // if a map is not active
                    {
                        DebugMessage("  No map is active.");

                        // create a new map
                        SendMessageToPC(oPC, "Dungeon Map of Level " + IntToString(nCurrentLevel) + " of " + sDungeonName + ".");

                        int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // create
                        object oMap = CreateObject(OBJECT_TYPE_PLACEABLE, "Map", GetLocation(oPC));
                        SetLocalObject(oMap, "oCreator", oPC);
                        SetLocalInt(oMap, "nPCArea", nAreaNum);
                        SetLocalInt(oMap, "nLevel", nCurrentLevel);
                        SetLocalObject(oMap, "oDungeon", oDungeon);

                        // set map as active
                        SetLocalObject(oPC, "oActiveMap", oMap);

                        // run map generation script
                        DelayCommand(0.01, ExecuteScript("exe_id1_mapgen", oMap));
                    }
                } else
                {
                    SendMessageToPC(oPC, "The current dungeon level is invalid.");
                }
            } else
            {
                SendMessageToPC(oPC, "The current dungeon is invalid.");
            }
        } else
        {
            SendMessageToPC(oPC, "The dungeon map can only be used inside a dungeon.");
        }
    } else
    {
        DebugMessage("  Map does not have a valid PC.");
    }
}
