#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

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

    string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointTrap";
    string sLevel;

    object oWaypoint;
    object oDoor;

    object oTrap;

    float fRadius;
    int nDamageDC;
    int nDisarmDC;
    int nDetectDC;
    int nDamageType;
    int nDamageMin;
    int nDamageMax;

    // get number of generic doors
    sWaypoint = "Area" + IntToString(nAreaNum) + "GenericDoor";
    int nDoorNum = GetLocalInt(oDungeon, "n" + sWaypoint);

    int bLocked;
    int nUnlockDC;

    int bTrapped;
    int bTriggered;

    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    int nHardness = nPartyLevel / 2;
    int nCurrentHP;
    int nHP = nPartyLevel * 5;

    int bDead;
    int nDungeonDamageType;

    // for each door
    int nDoor = 1;
    while (nDoor <= nDoorNum)
    {
        DebugMessage("On door " + IntToString(nDoor) + " of " + IntToString(nDoorNum));

        oDoor = GetLocalObject(oArea, "oGenericDoor" + IntToString(nDoor));

        sLevel = sWaypoint + IntToString(nDoor) + "Level" + IntToString(nCurrentLevel);
        DebugMessage(sLevel);

        bDead = GetLocalInt(oDungeon, "b" + sLevel + "Dead");
        if (bDead == FALSE)
        {
            // set the hardness of the door
            SetHardness(nHardness, oDoor);

            // set the hitpoints of the door
            nCurrentHP = GetCurrentHitPoints(oDoor);
            DebugMessage("  Door has " + IntToString(nCurrentHP) + " hitpoints and needs " + IntToString(nHP));
            if (nCurrentHP < nHP)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(nHP - nCurrentHP), oDoor);
            } else if (nCurrentHP > nHP)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(nCurrentHP - nHP), oDoor);
            }

            // locks
            bLocked = GetLocalInt(oDungeon, "b" + sLevel + "Locked");
            if (bLocked == TRUE)
            {
                DebugMessage("  Door should be locked.");

                // if door is unpicked
                bLocked = GetLocalInt(oDungeon, "b" + sLevel + "Unlocked");
                if (bLocked == FALSE)
                {
                    nUnlockDC = GetLocalInt(oDungeon, "n" + sLevel + "UnlockDC");
                    DebugMessage("Locking door with DC " + IntToString(nUnlockDC));
                    SetLocked(oDoor, TRUE);
                    SetLockLockable(oDoor, FALSE);
                    SetLockUnlockDC(oDoor, nUnlockDC);
                }
            } else
            {
                SetLocked(oDoor, FALSE);
                SetLockLockable(oDoor, FALSE);
            }

            // traps
            bTrapped = GetLocalInt(oDungeon, "b" + sLevel + "Trapped");
            if (bTrapped == TRUE)
            {
                // if state is untriggered
                bTriggered = GetLocalInt(oDungeon, "b" + sLevel + "Triggered");
                if (bTriggered == FALSE)
                {
                    fRadius = GetLocalFloat(oDungeon, "f" + sLevel + "Radius");
                    DebugMessage("Radius is " + FloatToString(fRadius));

                    // spawn
                    CreateTrapOnObject(48, oDoor, STANDARD_FACTION_HOSTILE, "pda_id1_gdoor", "ptt_id1_gdoor");

                    nDamageDC = GetLocalInt(oDungeon, "n" + sLevel + "DamageDC");
                    nDetectDC = GetLocalInt(oDungeon, "n" + sLevel + "DetectDC");
                    nDisarmDC = GetLocalInt(oDungeon, "n" + sLevel + "DisarmDC");
                    nDungeonDamageType = GetLocalInt(oDungeon, "n" + sLevel + "DamageType");
                    nDamageType = GetLocalInt(oDungeon, "nListDamageType" + IntToString(nDungeonDamageType) + "ID");
                    nDamageMin = GetLocalInt(oDungeon, "n" + sLevel + "DamageMin");
                    nDamageMax = GetLocalInt(oDungeon, "n" + sLevel + "DamageMax");
                    DebugMessage("Trap was " + GetTag(oDoor) + " with damage DC " + IntToString(nDamageDC) + " and detect DC " + IntToString(nDetectDC) + " and disarm DC " + IntToString(nDisarmDC));
                    DebugMessage("Damage type " + IntToString(nDamageType) + " with damage " + IntToString(nDamageMin) + " to " + IntToString(nDamageMax));

                    // assign variables
                    SetLocalString(oDoor, "sVariable", sLevel);
                    SetLocalInt(oDoor, "nDamageDC", nDamageDC);
                    SetLocalInt(oDoor, "nDamageType", nDamageType);
                    SetLocalInt(oDoor, "nDamageMin", nDamageMin);
                    SetLocalInt(oDoor, "nDamageMax", nDamageMax);
                    SetLocalFloat(oDoor, "fRadius", fRadius);
                    SetTrapDetectDC(oDoor, nDetectDC);
                    SetTrapDisarmDC(oDoor, nDisarmDC);

                    SetTrapActive(oDoor, TRUE);
                    SetTrapDetectable(oDoor, TRUE);
                    SetTrapDisarmable(oDoor, TRUE);
                    SetTrapKeyTag(oDoor, "");
                    SetTrapOneShot(oDoor, TRUE);
                    SetTrapRecoverable(oDoor, FALSE);
                } else
                {
                    SetTrapDisabled(oDoor);
                }
            } else
            {
                SetTrapDisabled(oDoor);
            }
        } else
        {
            AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_DESTROY));
        }

        nDoor++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

