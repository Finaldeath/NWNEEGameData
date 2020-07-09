//:://////////////////////////////////////////////////////////////
//:: exe_id1_mapgen                                             //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script spawns in a single Y row of the map on the ground
    around the PC. The tiles spawned in reflect the configuration
    of the dungeon level the player is on.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_gen"
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Map child process.");

    object oCreator = GetLocalObject(OBJECT_SELF, "oCreator");
    object oCenter = GetLocalObject(OBJECT_SELF, "oCenter");
    int nCurrentY = GetLocalInt(OBJECT_SELF, "nCurrentY");
    int nMaxX = GetLocalInt(OBJECT_SELF, "nMaxX");
    int nPCArea = GetLocalInt(OBJECT_SELF, "nPCArea");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");

    // if PC is valid
    if (oCreator != OBJECT_INVALID)
    {
        DebugMessage("Map child process has a creator.");

        // if dungeon is valid
        if (oDungeon != OBJECT_INVALID)
        {
            DebugMessage("Map child process has a dungeon.");

            string sLevel;
            int nArea;
            location lCenter = GetLocation(oCenter);
            vector vTile;

            int nPCX = GetLocalInt(oDungeon, "nArea" + IntToString(nPCArea) + "Level" + IntToString(nLevel) + "X");
            int nPCY = GetLocalInt(oDungeon, "nArea" + IntToString(nPCArea) + "Level" + IntToString(nLevel) + "Y");
            float fX;
            float fY;
            location lTile;
            int nChildNum = 0;
            object oTile;
            int nExploreState;
            object oFactionLeader = GetFactionLeader(oCreator);
            object oFactionMember;
            int nType;
            int nAnimation;
            int bStairsUp;
            int bStairsDown;
            int bBoss;
            int bPlot;
            int bForge;
            int bPuzzle;
            int bCamp;
            float fFacing;

            // go through each X
            int nCurrentX = 1;
            while (nCurrentX <= nMaxX)
            {
                // get area at these coordinate
                sLevel = "Level" + IntToString(nLevel) + "Area" + IntToString(nCurrentX) + "_" + IntToString(nCurrentY);
                nArea = GetLocalInt(oDungeon, "n" + sLevel);
                DebugMessage("  Variable Level" + IntToString(nLevel) + "Area" + IntToString(nCurrentX) + "_" + IntToString(nCurrentY) + " is " + IntToString(nArea));

                // get tile location
                fX = (nCurrentX - nPCX) * 1.0;
                fY = (nCurrentY - nPCY) * 1.0;
                vTile = GetPositionFromLocation(lCenter);
                vTile.x += fX;
                vTile.y += fY;
                lTile = Location(GetAreaFromLocation(lCenter), vTile, 0.0);

                // if an area present
                if (nArea != 0)
                {
                    nExploreState = 0;

                    if (nArea == nPCArea)
                    {
                        nExploreState = 2;
                    }

                    // get player explored variable
                    if (nExploreState == 0)
                    {
                        nExploreState = GetExploredState(oCreator, "", nArea, nLevel, oDungeon);
                    }

                    // if sharing with party
                    if (nExploreState == 0)
                    {
                        // explore if not
                        if (GetModuleFlag(ID1_FLAG_MAP_DISPLAY) == ID1_MAP_DISPLAY_PARTY)
                        {
                            // get first party
                            oFactionMember = GetFirstFactionMember(oFactionLeader, TRUE);
                            while ((oFactionMember != OBJECT_INVALID) && (nExploreState == 0))
                            {
                                // get that party member's explore state
                                nExploreState = GetExploredState(oFactionMember, "", nArea, nLevel, oDungeon);

                                // if the party member has not explored it
                                if (nExploreState == 0)
                                {
                                    oFactionMember = GetNextFactionMember(oFactionLeader, TRUE);
                                } else // if the party member has explored it
                                {
                                    nExploreState = 3;
                                }
                            }
                        }
                    }

                    // if all revealed
                    if (nExploreState == 0)
                    {
                        // explore if not
                        if (GetModuleFlag(ID1_FLAG_MAP_DISPLAY) == ID1_MAP_DISPLAY_ALL)
                        {
                            nExploreState = 4;
                        }
                    }

                    // if anything is revealed
                    if (nExploreState > 0)
                    {
                        // determine animation state
                        if (nExploreState == 1)
                        {
                            // change to black lines
                            nAnimation = ANIMATION_PLACEABLE_OPEN;
                        } else if (nExploreState == 2)
                        {
                            // change to red lines
                            nAnimation = ANIMATION_PLACEABLE_CLOSE;
                        } else if (nExploreState == 3)
                        {
                            // change to light blue lines
                            nAnimation = ANIMATION_PLACEABLE_ACTIVATE;
                        } else if (nExploreState > 3)
                        {
                            // change to grey lines
                            nAnimation = ANIMATION_PLACEABLE_DEACTIVATE;
                        }

                        // determine tile type
                        nType = 0;
                        if (GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nLevel) + "North") != 0)
                        {
                            nType += ID1_DOOR_NORTH;
                        }
                        if (GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nLevel) + "East") != 0)
                        {
                            nType += ID1_DOOR_EAST;
                        }
                        if (GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nLevel) + "South") != 0)
                        {
                            nType += ID1_DOOR_SOUTH;
                        }
                        if (GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nLevel) + "West") != 0)
                        {
                            nType += ID1_DOOR_WEST;
                        }

                        // spawn in background tile
                        nChildNum++;
                        oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile05", lTile);
                        SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);

                        // adjust location upwards
                        vTile.z += 0.01;
                        lTile = Location(GetAreaFromLocation(lCenter), vTile, 0.0);

                        // find facing
                        if ((nType == 15) || (nType == 13) || (nType == 9) || (nType == 8))
                        {
                            fFacing = 0.0;
                        } else if ((nType == 14) || (nType == 12) || (nType == 5) || (nType == 4))
                        {
                            fFacing = 90.0;
                        } else if ((nType == 10) || (nType == 7) || (nType == 6) || (nType == 2))
                        {
                            fFacing = 180.0;
                        } else if ((nType == 11) || (nType == 3) || (nType == 1))
                        {
                            fFacing = 270.0;
                        }

                        // find tile type
                        if ((nType == 1) || (nType == 2) || (nType == 4) || (nType == 8))
                        {
                            nType = 0;
                        } else if ((nType == 3) || (nType == 6) || (nType == 9) || (nType == 12))
                        {
                            nType = 1;
                        } else if ((nType == 7) || (nType == 11) || (nType == 13) || (nType == 14))
                        {
                            nType = 2;
                        } else if (nType == 15)
                        {
                            nType = 3;
                        } else if ((nType == 10) || (nType == 5))
                        {
                            nType = 4;
                        }

                        // spawn in appropriate tile
                        nChildNum++;
                        oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile" + IntToStringDigits(nType, 2), lTile);
                        DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                        DelayCommand(0.01, AssignCommand(oTile, SetFacing(fFacing)));
                        SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);

                        // determine map markers
                        bStairsUp = GetLocalInt(oDungeon, "b" + sLevel + "StairsUp");
                        DebugMessage("  b" + sLevel + "StairsUp is " + IntToString(bStairsUp));
                        bStairsDown = GetLocalInt(oDungeon, "b" + sLevel + "StairsDown");
                        DebugMessage("  b" + sLevel + "StairsDown is " + IntToString(bStairsDown));
                        bBoss = GetLocalInt(oDungeon, "b" + sLevel + "Boss");
                        DebugMessage("  b" + sLevel + "Boss is " + IntToString(bBoss));
                        bPlot = GetLocalInt(oDungeon, "b" + sLevel + "Plot");
                        DebugMessage("  b" + sLevel + "Plot is " + IntToString(bPlot));
                        bForge = GetLocalInt(oDungeon, "b" + sLevel + "Forge");
                        DebugMessage("  b" + sLevel + "Forge is " + IntToString(bForge));
                        bPuzzle = GetLocalInt(oDungeon, "b" + sLevel + "Puzzle");
                        DebugMessage("  b" + sLevel + "Puzzle is " + IntToString(bPuzzle));
                        bCamp = GetLocalInt(oDungeon, "b" + sLevel + "Camp");
                        DebugMessage("  b" + sLevel + "Camp is " + IntToString(bCamp));

                        // adjust location upwards
                        vTile.z += 0.01;
                        lTile = Location(GetAreaFromLocation(lCenter), vTile, 0.0);

                        // spawn in appropriate map markers
                        if (bStairsUp == TRUE)
                        {
                            nChildNum++;
                            oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile07", lTile);
                            DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                            DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                            SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                        }
                        if (bStairsDown == TRUE)
                        {
                            nChildNum++;
                            oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile06", lTile);
                            DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                            DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                            SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                        }
                        if (bBoss == TRUE)
                        {
                            nChildNum++;
                            oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile09", lTile);
                            DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                            DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                            SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                        }
                        if (nExploreState < 4)
                        {
                            if (bPlot == TRUE)
                            {
                                nChildNum++;
                                oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile10", lTile);
                                DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                                DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                                SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                            }
                            if (bForge == TRUE)
                            {
                                nChildNum++;
                                oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile11", lTile);
                                DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                                DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                                SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                            }
                            if (bPuzzle == TRUE)
                            {
                                nChildNum++;
                                oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile08", lTile);
                                DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                                DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                                SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                            }
                            if (bCamp == TRUE)
                            {
                                nChildNum++;
                                oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile12", lTile);
                                DelayCommand(0.01, AssignCommand(oTile, PlayAnimation(nAnimation)));
                                DelayCommand(0.01, AssignCommand(oTile, SetFacing(90.0)));
                                SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                            }
                        }
                    } else
                    {
                        // if showing the entire map, or the extents
                        if ((GetModuleFlag(ID1_FLAG_MAP_BOUNDARY) == ID1_MAP_BOUNDARY_SHOW_FULL) || (GetModuleFlag(ID1_FLAG_MAP_BOUNDARY) == ID1_MAP_BOUNDARY_SHOW_EXTENTS))
                        {
                            // spawn background tile
                            nChildNum++;
                            oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile05", lTile);
                            SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                        }
                    }
                } else // if an area not present
                {
                    // if full map size
                    if (GetModuleFlag(ID1_FLAG_MAP_BOUNDARY) == ID1_MAP_BOUNDARY_SHOW_FULL)
                    {
                        // spawn background tile
                        nChildNum++;
                        oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "tile05", lTile);
                        SetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChildNum), oTile);
                    }
                }

                nCurrentX++;
            }

            DebugMessage("Number of children is " + IntToString(nChildNum));
            SetLocalInt(OBJECT_SELF, "nChildNum", nChildNum);
        } else
        {
            DebugMessage("Dungeon does not exist for child process.");

            DestroyObject(OBJECT_SELF);
        }
    } else
    {
        DebugMessage("Player does not exist for child process.");

        DestroyObject(OBJECT_SELF);
    }
}
