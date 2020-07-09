#include "inc_id1_debug"
#include "inc_id1_score"

void main()
{
    object oDungeon = GetCurrentDungeon();
    object oCurrentArea = GetArea(OBJECT_SELF);
    string sCurrentTag = GetTag(oCurrentArea);
    DebugMessage("The teleporter is located in area " + sCurrentTag);

    int bInCombat = FALSE;
    int bOtherArea = FALSE;
    int bTooFar = FALSE;

    float fDistance;

    object oArea;

    // cycle through all players
    object oPC = GetFirstPC();
    while ((oPC != OBJECT_INVALID) && (bInCombat == FALSE) && (bOtherArea == FALSE) && (bTooFar == FALSE))
    {
        DebugMessage("Examining player " + GetPCIdentifier(oPC));

        if (GetIsInCombat(oPC) == TRUE)
        {
            DebugMessage("  Player is in combat.");

            bInCombat = TRUE;
        } else
        {
            oArea = GetArea(oPC);
            DebugMessage("  Tag of player's area is " + GetTag(oArea));

            if ((oArea != oCurrentArea) && (GetTag(oArea) != "DungeonEntrance"))
            {
                DebugMessage("  Player is in another area.");

                bOtherArea = TRUE;
            } else if (GetTag(oArea) != "DungeonEntrance")
            {
                fDistance = GetDistanceToObject(oPC);
                DebugMessage("  Player is at distance " + FloatToString(fDistance));

                if (fDistance > 10.0)
                {
                    DebugMessage("  Player is too far away.");

                    bTooFar = TRUE;
                } else
                {
                    DebugMessage("  Player is acceptable.");
                }
            } else
            {
                DebugMessage("  Player is in the dungeon entrance area.");
            }
        }

        // check the next PC
        oPC = GetNextPC();
    }

    if (bInCombat == FALSE)
    {
        if (bOtherArea == FALSE)
        {
            if (bTooFar == FALSE)
            {
                // transport all PCs not in the entrance area
                object oDungeonEntrance = GetObjectByTag("DungeonEntranceStairs");
                object oLocation;
                if (sCurrentTag == "BossArea_BACCHA")
                {
                    oLocation = GetWaypointByTag("BACCHA_TELEPORTER");
                } else if (sCurrentTag == "BossArea_HAGATHA")
                {
                    oLocation = GetWaypointByTag("HAGATHA_TELEPORTER");
                } else if (sCurrentTag == "BossArea_MAGGRIS")
                {
                    oLocation = GetWaypointByTag("MAGGRIS_TELEPORTER");
                } else if (sCurrentTag == "BossArea_GZHORB")
                {
                    oLocation = GetWaypointByTag("GZHORB_TELEPORTER");
                } else if (sCurrentTag == "BossArea_MASTERIUS")
                {
                    oLocation = GetWaypointByTag("MASTERIUS_TELEPORTER");
                } else if (sCurrentTag == "BossArea_HARAT")
                {
                    oLocation = GetWaypointByTag("HARAT_TELEPORTER");
                } else if (sCurrentTag == "BossArea_HALASTER")
                {
                    oLocation = GetWaypointByTag("HALASTER_TELEPORTER");
                } else
                {
                    oLocation = oDungeonEntrance;
                }
                DebugMessage("Location tag " + GetTag(oLocation));

                oPC = GetFirstPC();
                AssignCommand(oDungeonEntrance, PlayAnimation(ANIMATION_DOOR_CLOSE));
                object oHenchman;
                int nCount;
                while (oPC != OBJECT_INVALID)
                {
                    DebugMessage("Cutscene mode for " + GetPCIdentifier(oPC));


                    oArea = GetArea(oPC);
                    DebugMessage("  Area tag is " + GetTag(oArea));
                    if (GetTag(oArea) != "DungeonEntrance")
                    {
                        // put PC in cutscene mode
                        if (GetCutsceneMode(oPC) == FALSE)
                        {
                            DebugMessage("Cutscene mode set on PC.");
                            SetCutsceneMode(oPC, TRUE);
                        } else
                        {
                            DebugMessage("Cutscene mode already set on PC.");
                        }
                    }

                    // get henchmen of player
                    nCount = 1;
                    oHenchman = GetHenchman(oPC, nCount);
                    while (oHenchman != OBJECT_INVALID)
                    {
                        DebugMessage("    Henchman " + IntToString(nCount));
                        if (GetLocalString(oHenchman, "sConversation") == "id1_plotgiver")
                        {
                            DebugMessage("    Is a plot giver. Deleting.");

                            string sVariable = GetLocalString(oHenchman, "sVariable");
                            DebugMessage("    sVariable is " + sVariable);
                            SetLocalInt(oDungeon, "b" + sVariable + "Gone", FALSE);

                            RemoveHenchman(oPC, oHenchman);
                            DestroyObject(oHenchman);
                        } else
                        {
                            nCount++;
                        }
                        oHenchman = GetHenchman(oPC, nCount);
                    }

                    // set the respawn point as the dungeon stairs
                    SetLocalObject(oPC, "ptr_id1_door", oDungeonEntrance);

                    // cycle to next PC
                    oPC = GetNextPC();
                }

                // set the previous level
                int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                SetLocalInt(GetModule(), "nTempPreviousLevel", nCurrentLevel);
                DebugMessage("Setting level to clean as " + IntToString(nCurrentLevel));

                // set the current level
                DebugMessage("Set nCurrentLevel to 0. Point X8.");
                SetLocalInt(GetModule(), "nCurrentLevel", 0);

                // set starting coordinates
                SetLocalInt(GetModule(), "nCurrentX", 1);
                SetLocalInt(GetModule(), "nCurrentY", 1);

                // set boss teleporter variable
                SetLocalInt(GetModule(), "bTempBossTeleport", TRUE);
                SetLocalObject(GetModule(), "oTempLocation", oLocation);
                SetLocalObject(GetModule(), "oDestinationDoor", oDungeonEntrance);
                SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);

                SetLocalObject(GetModule(), "oTempArea", oCurrentArea);

                SetLocalInt(GetModule(), "bBossTeleport", TRUE);

                // clean this area only
                DelayCommand(0.01, ExecuteScript("exe_id1_cleancur", GetObjectByTag("CPU1")));
            } else
            {
                DebugMessage("A player is too far from the teleporter.");

                SpeakString("You must gather all players close to the teleporter before it activates.");
            }
        } else
        {
            DebugMessage("A player is in an area other than this one or the dungeon entrance.");

            SpeakString("You must gather all players close to the teleporter before it activates.");
        }
    } else
    {
        DebugMessage("A player is in combat.");

        SpeakString("The teleporter cannot be used in combat.");
    }
}
