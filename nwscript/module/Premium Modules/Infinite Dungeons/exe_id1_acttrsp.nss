#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

#include "inc_id1_treasure"

void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    DebugMessage("nCurrentLevel is " + IntToString(nCurrentLevel));


    // get number of treasure waypoints in this level
    string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointTreasure";

    DebugMessage("Waypoint is " + sWaypoint);

    int nTreasureNum = GetLocalInt(oDungeon, "n" + sWaypoint);

    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    int nHardness = nPartyLevel / 2;
    int nCurrentHP;
    int nHP = nPartyLevel * 5;

    object oWaypoint;

    string sLevel;

    int nContainer;
    string sContainer;
    object oContainer;

    float fFacing;

    int bUsed;

    int bDead;

    int nMicroNum;
    object oMicroCPU;

    int bLocked;
    int nUnlockDC;

    int bTrapped;
    int bTriggered;

    float fRadius;
    int nDamageDC;
    int nDetectDC;
    int nDisarmDC;
    int nDamageType;
    int nDamageMin;
    int nDamageMax;

    int nDungeonDamageType;

    // examine each waypoint
    int nTreasure = 1;
    while (nTreasure <= nTreasureNum)
    {
        sLevel = sWaypoint + IntToString(nTreasure) + "Level" + IntToString(nCurrentLevel);

        DebugMessage("Level is " + sLevel);

        // if used
        bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bUsed == TRUE)
        {
            bDead = GetLocalInt(oDungeon, "b" + sLevel + "Dead");
            if (bDead == FALSE)
            {
                // get container
                nContainer = GetLocalInt(oDungeon, "n" + sLevel + "Container");
                sContainer = GetLocalString(oDungeon, "sListContainer" + IntToString(nContainer) + "ResRef");

                DebugMessage("Container resref is " + sContainer);

                // get waypoint
                oWaypoint = GetLocalObject(oArea, "oWaypointTreasure" + IntToString(nTreasure));

                // spawn container
                oContainer = CreateObject(OBJECT_TYPE_PLACEABLE, sContainer, GetLocation(oWaypoint));

                if (oContainer != OBJECT_INVALID)
                {
                    // set hardness of the chest
                    SetHardness(nHardness, oContainer);

                    // set hitpoints of the chest
                    nCurrentHP = GetCurrentHitPoints(oContainer);
                    if (nCurrentHP < nHP)
                    {
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(nHP - nCurrentHP), oContainer);
                    } else if (nCurrentHP > nHP)
                    {
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(nCurrentHP - nHP), oContainer);
                    }

                    // get facing
                    fFacing = GetFacing(oWaypoint);
                    fFacing += 180.0;

                    DebugMessage("Waypoint facing: " + FloatToString(fFacing));

                    DebugMessage("Container facing: " + FloatToString(GetFacing(oContainer)));

                    // set facing
                    AssignCommand(oContainer, SetFacing(fFacing));

                    // set variables on the container
                    SetLocalString(oContainer, "sVariable", sLevel);

                    // make a microprocess to generate the container items
                    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU53");
                    SetLocalObject(oMicroCPU, "oContainer", oContainer);
                    SetLocalString(oMicroCPU, "sLevel", sLevel);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                    SetLocalInt(oMicroCPU, "bContainer", TRUE);

                    DelayCommand(0.01, ExecuteScript("exe_id1_micloot", oMicroCPU));

                    // if locked
                    bLocked = GetLocalInt(oDungeon, "b" + sLevel + "Locked");
                    if (bLocked == TRUE)
                    {
                        bLocked = GetLocalInt(oDungeon, "b" + sLevel + "Unlocked");
                        if (bLocked == FALSE)
                        {
                            nUnlockDC = GetLocalInt(oDungeon, "n" + sLevel + "UnlockDC");
                            DebugMessage("Container is locked with DC " + IntToString(nUnlockDC));
                            SetLocked(oContainer, TRUE);
                            SetLockLockable(oContainer, FALSE);
                            SetLockUnlockDC(oContainer, nUnlockDC);
                        }
                    }

                    // if trapped
                    bTrapped = GetLocalInt(oDungeon, "b" + sLevel + "Trapped");
                    if (bTrapped == TRUE)
                    {
                        // if state is active
                        bTriggered = GetLocalInt(oDungeon, "b" + sLevel + "Triggered");
                        if (bTriggered == FALSE)
                        {
                            fRadius = GetLocalFloat(oDungeon, "f" + sLevel + "Radius");
                            DebugMessage("Radius is " + FloatToString(fRadius));

                            // spawn
                            CreateTrapOnObject(48, oContainer, STANDARD_FACTION_HOSTILE, "pda_id1_treasure", "ptt_id1_treasure");

                            nDamageDC = GetLocalInt(oDungeon, "n" + sLevel + "DamageDC");
                            nDetectDC = GetLocalInt(oDungeon, "n" + sLevel + "DetectDC");
                            nDisarmDC = GetLocalInt(oDungeon, "n" + sLevel + "DisarmDC");
                            nDungeonDamageType = GetLocalInt(oDungeon, "n" + sLevel + "DamageType");
                            nDamageType = GetLocalInt(oDungeon, "nListDamageType" + IntToString(nDungeonDamageType) + "ID");
                            nDamageMin = GetLocalInt(oDungeon, "n" + sLevel + "DamageMin");
                            nDamageMax = GetLocalInt(oDungeon, "n" + sLevel + "DamageMax");

                            DebugMessage("Trap was " + GetTag(oContainer) + " with damage DC " + IntToString(nDamageDC) + " and detect DC " + IntToString(nDetectDC) + " and disarm DC " + IntToString(nDisarmDC));
                            DebugMessage("Damage type " + IntToString(nDamageType) + " with damage " + IntToString(nDamageMin) + " to " + IntToString(nDamageMax));

                            // assign variables
                            SetLocalInt(oContainer, "nDamageDC", nDamageDC);
                            SetLocalInt(oContainer, "nDamageType", nDamageType);
                            SetLocalInt(oContainer, "nDamageMin", nDamageMin);
                            SetLocalInt(oContainer, "nDamageMax", nDamageMax);
                            SetLocalFloat(oContainer, "fRadius", fRadius);
                            SetTrapDetectDC(oContainer, nDetectDC);
                            SetTrapDisarmDC(oContainer, nDisarmDC);

                            SetTrapActive(oContainer, TRUE);
                            SetTrapDetectable(oContainer, TRUE);
                            SetTrapDisarmable(oContainer, TRUE);
                            SetTrapKeyTag(oContainer, "");
                            SetTrapOneShot(oContainer, TRUE);
                            SetTrapRecoverable(oContainer, FALSE);
                        }
                    }
                } else
                {
                    DebugMessage("Container object didn't exist yet.");
                }
            }
        }

        // cycle to next waypoint
        nTreasure++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

