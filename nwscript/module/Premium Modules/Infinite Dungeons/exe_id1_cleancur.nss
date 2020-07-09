#include "inc_id1_debug"
#include "inc_id1_gen"
#include "inc_id_liltimmy"

void BossStuff();

void main()
{
    DebugMessage("");

    // get area to clean
    object oArea = GetLocalObject(GetModule(), "oTempArea");
    DebugMessage("Cleaning area " + GetTag(oArea));

    // if valid area
    if ((oArea != OBJECT_INVALID) && (GetTag(oArea) != "DungeonEntrance"))
    {

        object oCreator = GetLocalObject(GetModule(), "oTempPC");

        object oPCArea;
        int bPCPresent = FALSE;
        object oPC = GetFirstPC();
        while ((oPC != OBJECT_INVALID) && (bPCPresent == FALSE))
        {
            DebugMessage("Checking PC " + GetName(oPC));
            if (oPC != oCreator)
            {
                DebugMessage("  PC is not creator.");
                oPCArea = GetArea(oPC);
                if (oPCArea == oArea)
                {
                    DebugMessage("    PC is in the same area.");
                    bPCPresent = TRUE;
                } else
                {
                    DebugMessage("    PC is in a different area.");
                }
            } else
            {
                DebugMessage("  PC is creator.");
            }

            oPC = GetNextPC();
        }

        if (bPCPresent == FALSE)
        {
            object oDungeon = GetCurrentDungeon();
            int nLevel = GetLocalInt(GetModule(), "nTempPreviousLevel");
            int nIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
            int nArea = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nIdentifier) + "Area");

            string sAreaTag = GetTag(oArea);
            string sAreaSubTag = GetSubString(sAreaTag, 0, 8);
            DebugMessage("  Area tag of " + sAreaTag + " and subtag " + sAreaSubTag);
            if (sAreaSubTag == "BossArea")
            {
                SetLocalInt(oDungeon, "bBossActivated", FALSE);
            }

            int bPC;

            string sTag;
            string sSubTag;

            object oMaster;

            object oItem;

            // cycle through all objects
            object oObject = GetFirstObjectInArea(oArea);
            while (oObject != OBJECT_INVALID)
            {
                sTag = GetTag(oObject);
                sSubTag = GetSubString(sTag, 0, 11);
                DebugMessage("    Object found is tag " + sTag + " with subtag " + sSubTag);

                // check to see if object is a pc or henchman
                bPC = FALSE;
                if (GetIsPC(oObject) == TRUE)
                {
                    bPC = TRUE;
                }
                if (bPC == FALSE)
                {
                    oMaster = GetMaster(oObject);

                    if (GetIsPC(oMaster) == TRUE)
                    {
                        bPC = TRUE;
                    }
                }

                // if not a player or henchman
                if (bPC == FALSE)
                {
                    // if not static, delete
                    if (sSubTag != "ID1_STATIC_")
                    {
                        if ((GetLocalInt(GetModule(), "bTempEggGen") == FALSE) || (oObject != GetLocalObject(GetModule(), "oTempEgg")))
                        {
                            DebugMessage("      Destroying object.");

                            SetLocalInt(oObject, "bClean", TRUE);

                            if (GetHasInventory(oObject) == TRUE)
                            {
                                DebugMessage("        Object has inventory.");
                                oItem = GetFirstItemInInventory(oObject);
                                while (oItem != OBJECT_INVALID)
                                {
                                    SetPlotFlag(oItem, FALSE);
                                    DebugMessage("          Destroying item " + GetTag(oItem));
                                    DestroyObject(oItem);
                                    oItem = GetNextItemInInventory(oObject);
                                }
                            }

                            SetPlotFlag(oObject, FALSE);
                            AssignCommand(oObject, SetIsDestroyable(TRUE));
                            DelayCommand(0.01, DestroyObject(oObject));
                        }
                    }

                    // if a generic door
                    if (sTag == "ID1_STATIC_GENERICDOOR")
                    {
                        // close
                        AssignCommand(oObject, PlayAnimation(ANIMATION_DOOR_CLOSE));

                        // set to not locked
                        SetLocked(oObject, FALSE);
                        SetLockLockable(oObject, FALSE);
                        SetLockUnlockDC(oObject, 0);

                        // remove trap from door
                        SetTrapDisabled(oObject);
                    }

                    // if an area door
                    if (sTag == "ID1_STATIC_DOOR")
                    {
                        // close
                        AssignCommand(oObject, PlayAnimation(ANIMATION_DOOR_CLOSE));
                    }

                    // if a boss teleporter map note
                    if (sTag == "ID1_STATIC_BOSS_LAIR_TELEPORTER")
                    {
                        SetMapPinEnabled(oObject, FALSE);
                    }
                }

                // cycle to next object
                oObject = GetNextObjectInArea(oArea);
            }

            // deactivate
            string sActivate = "bArea" + IntToString(nArea) + "Level" + IntToString(nLevel) + "Activated";
            DebugMessage("  Setting " + sActivate);
            SetLocalInt(oDungeon, sActivate, FALSE);
        }
    }

    if (GetLocalInt(GetModule(), "bTempEggGen") == TRUE)
    {
        SetLocalInt(GetModule(), "bTempEggGen", FALSE);
        SetLocalObject(GetModule(), "oTempEgg", OBJECT_INVALID);
    }

    if (GetLocalInt(GetModule(), "bBossTeleport") == TRUE)
    {
        SetLocalInt(GetModule(), "bBossTeleport", FALSE);

/*        // store current dungeon
        object oDungeon = GetCurrentDungeon();
        int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
        if (nDungeonNumber != 0)
        {
            string sName = "Dungeon" + IntToString(nDungeonNumber);
            int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
            DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
            DestroyObject(oDungeon);
        }*/

/*        // get previous dungeon
        nDungeonNumber = GetLocalInt(GetModule(), "nPreviousDungeon");
        string sName = "Dungeon" + IntToString(nDungeonNumber);
        DebugMessage("Retrieving " + sName);
        location lLocation = GetLocation(GetObjectByTag("CPU"));
        oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
        if (oDungeon == OBJECT_INVALID)
        {
            DebugMessage("    Could not retrieve " + sName);
        } else
        {
            DebugMessage("    " + sName + " was retrieved.");
        }

        // set the current dungeon to the previous one
        SetLocalInt(GetModule(), "nDungeonNumber", nDungeonNumber);
        SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
        DebugMessage("        Dungeon Number: " + IntToString(nDungeonNumber));*/

/*        BossStuff();

        SetLocalInt(GetModule(), "bGenerating", FALSE);*/

        DelayCommand(0.01, ExecuteScript("exe_id1_bosstel1", GetNextCPU()));
    } else if (GetLocalInt(GetModule(), "bTempLevelGen") == TRUE)
    {
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    } else
    {
        // normal cleangen ending
        DebugMessage("  Activating area.");

        // activate new level
        SetLocalInt(GetModule(), "nActivationProcess", 0);
        DelayCommand(0.01, ExecuteScript("exe_id1_active", GetNextCPU()));
    }

}

