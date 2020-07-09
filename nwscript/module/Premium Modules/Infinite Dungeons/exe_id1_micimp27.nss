#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing details for area " + IntToString(nNum) + " on level " + IntToString(nLevel));

    string sArea = "Area" + IntToString(nNum);
    int nSizeNum;
    int nSize;

    int nItemNum;
    int nItem;

    // encounter/boss/guard waypoints
    string sWaypoint;
    int nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointEncounter");
    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Dead", FALSE);

            // item num
            nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum");
            nItem = 1;
            while (nItem <= nItemNum)
            {
                SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Item" + IntToString(nItem) + "Taken", FALSE);
                nItem++;
            }

            nSize++;
        }

        nWaypoint++;
    }
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointBoss");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointBoss" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Dead", FALSE);

            // item num
            nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum");
            nItem = 1;
            while (nItem <= nItemNum)
            {
                SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Item" + IntToString(nItem) + "Taken", FALSE);
                nItem++;
            }

            nSize++;
        }

        nWaypoint++;
    }
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointBossGuard");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointBossGuard" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Dead", FALSE);

            // item num
            nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum");
            nItem = 1;
            while (nItem <= nItemNum)
            {
                SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Item" + IntToString(nItem) + "Taken", FALSE);
                nItem++;
            }

            nSize++;
        }

        nWaypoint++;
    }

    // treasure waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointTreasure");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        SetLocalInt(oImport, "b" + sWaypoint + "Dead", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Unlocked", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Triggered", FALSE);

        // item num
        nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "ItemNum");
        nItem = 1;
        while (nItem <= nItemNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Item" + IntToString(nItem) + "Taken", FALSE);
            nItem++;
        }

        nWaypoint++;
    }

    // trap waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointTrap");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointTrap" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        SetLocalInt(oImport, "b" + sWaypoint + "Triggered", FALSE);

        nWaypoint++;
    }

    // generic doors
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "GenericDoor");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "GenericDoor" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        SetLocalInt(oImport, "b" + sWaypoint + "Dead", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Unlocked", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Triggered", FALSE);

        nWaypoint++;
    }

    // plot waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointPlot");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // plot num
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "PlotNum");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // gone
            SetLocalInt(oImport, "b" + sWaypoint + "Plot" + IntToString(nSize) + "ObjectDead", FALSE);
            SetLocalInt(oImport, "b" + sWaypoint + "Plot" + IntToString(nSize) + "ObjectGone", FALSE);

            nSize++;
        }

        nWaypoint++;
    }

    // puzzle waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointPuzzle");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointPuzzle" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // item num
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "ItemNum");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Item" + IntToString(nSize) + "Taken", FALSE);
            nSize++;
        }

        // camp nodes
        nSizeNum = 6;
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Node" + IntToString(nSize) + "CreatureDead", FALSE);
            SetLocalInt(oImport, "b" + sWaypoint + "Node" + IntToString(nSize) + "Monster1Dead", FALSE);
            SetLocalInt(oImport, "b" + sWaypoint + "Node" + IntToString(nSize) + "Monster2Dead", FALSE);
            SetLocalInt(oImport, "b" + sWaypoint + "Node" + IntToString(nSize) + "Monster3Dead", FALSE);
            SetLocalInt(oImport, "b" + sWaypoint + "Node" + IntToString(nSize) + "Monster4Dead", FALSE);

            nSize++;
        }

        nWaypoint++;
    }

    // secret door waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecret");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecret" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        SetLocalInt(oImport, "b" + sWaypoint + "Detected", FALSE);

        nWaypoint++;
    }

    // secret encounter waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecretEncounter");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecretEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Dead", FALSE);

            // item num
            nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum");
            nItem = 1;
            while (nItem <= nItemNum)
            {
                SetLocalInt(oImport, "b" + sWaypoint + "Creature" + IntToString(nSize) + "Item" + IntToString(nItem) + "Taken", FALSE);
                nItem++;
            }

            nSize++;
        }

        nWaypoint++;
    }

    // secret treasure waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecretTreasure");
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecretTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        SetLocalInt(oImport, "b" + sWaypoint + "Dead", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Unlocked", FALSE);
        SetLocalInt(oImport, "b" + sWaypoint + "Triggered", FALSE);

        // item num
        nItemNum = GetLocalInt(oImport, "n" + sWaypoint + "ItemNum");
        nItem = 1;
        while (nItem <= nItemNum)
        {
            SetLocalInt(oImport, "b" + sWaypoint + "Item" + IntToString(nItem) + "Taken", FALSE);
            nItem++;
        }

        nWaypoint++;
    }

    string sLevel = sArea + "Level" + IntToString(nLevel);

    // activated
    SetLocalInt(oImport, "b" + sLevel + "Activated", FALSE);

    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    int nMicroDead = GetLocalInt(GetModule(), "nImportMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nImportMicroDead", nMicroDead);
    DebugMessage("  There are " + IntToString(nMicroNum) + " living and " + IntToString(nMicroDead) + " dead microprocesses.");
    if (nMicroDead >= nMicroNum)
    {
        AssignCommand(oParent, ActionResumeConversation());
    }
    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
