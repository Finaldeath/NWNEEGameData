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

    object oTrap;

    int nDamageDC;
    int nDetectDC;
    int nDisarmDC;
    float fRadius;
    int nDamageType;
    int nDamageMin;
    int nDamageMax;

    int bTrapped;
    int bTriggered;

    // get number of trap waypoints
    int nTrapNum = GetLocalInt(oDungeon, "n" + sWaypoint);

    int nDungeonDamageType;

    // for each trap
    int nTrap = 1;
    while (nTrap <= nTrapNum)
    {
        DebugMessage("On trap " + IntToString(nTrap) + " of " + IntToString(nTrapNum));

        sLevel = sWaypoint + IntToString(nTrap) + "Level" + IntToString(nCurrentLevel);
        DebugMessage(sLevel);

        // if this trap is active
        bTrapped = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bTrapped == TRUE)
        {
            // if state is untriggered
            bTriggered = GetLocalInt(oDungeon, "b" + sLevel + "Triggered");
            if (bTriggered == FALSE)
            {
                oWaypoint = GetLocalObject(oArea, "oWaypointTrap" + IntToString(nTrap));

                fRadius = GetLocalFloat(oDungeon, "f" + sLevel + "Radius");
                DebugMessage("Radius is " + FloatToString(fRadius));

                // spawn
                oTrap = CreateTrapAtLocation(48, GetLocation(oWaypoint), fRadius, "", STANDARD_FACTION_HOSTILE, "tda_id1_trap", "ten_id1_trap");

                nDamageDC = GetLocalInt(oDungeon, "n" + sLevel + "DamageDC");
                nDetectDC = GetLocalInt(oDungeon, "n" + sLevel + "DetectDC");
                nDisarmDC = GetLocalInt(oDungeon, "n" + sLevel + "DisarmDC");
                nDungeonDamageType = GetLocalInt(oDungeon, "n" + sLevel + "DamageType");
                nDamageType = GetLocalInt(oDungeon, "nListDamageType" + IntToString(nDungeonDamageType) + "ID");
                nDamageMin = GetLocalInt(oDungeon, "n" + sLevel + "DamageMin");
                nDamageMax = GetLocalInt(oDungeon, "n" + sLevel + "DamageMax");
                DebugMessage("Trap was " + GetTag(oTrap) + " with damage DC " + IntToString(nDamageDC) + " and detect DC " + IntToString(nDetectDC) + " and disarm DC " + IntToString(nDisarmDC));
                DebugMessage("Damage type " + IntToString(nDamageType) + " with damage " + IntToString(nDamageMin) + " to " + IntToString(nDamageMax));

                // assign variables
                SetLocalString(oTrap, "sVariable", sLevel);
                SetLocalInt(oTrap, "nDamageDC", nDamageDC);
                SetLocalInt(oTrap, "nDamageType", nDamageType);
                SetLocalInt(oTrap, "nDamageMin", nDamageMin);
                SetLocalInt(oTrap, "nDamageMax", nDamageMax);
                SetLocalFloat(oTrap, "fRadius", fRadius);
                SetTrapDetectDC(oTrap, nDetectDC);
                SetTrapDisarmDC(oTrap, nDisarmDC);

                SetTrapActive(oTrap, TRUE);
                SetTrapDetectable(oTrap, TRUE);
                SetTrapDisarmable(oTrap, TRUE);
                SetTrapKeyTag(oTrap, "");
                SetTrapOneShot(oTrap, TRUE);
                SetTrapRecoverable(oTrap, FALSE);
            }
        }

        nTrap++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

