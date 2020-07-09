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

    // encounter/boss/guard waypoints
    string sWaypoint;
    int nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointEncounter");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointEncounter", 0);
    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        SetLocalInt(oImport, "n" + sWaypoint + "Size", 0);
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // item num
            SetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum", 0);

            nSize++;
        }
        // plot num
        SetLocalInt(oImport, "n" + sWaypoint + "PlotNum", 0);

        nWaypoint++;
    }
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointBoss");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointBoss", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointBoss" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        SetLocalInt(oImport, "n" + sWaypoint + "Size", 0);
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // item num
            SetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum", 0);

            nSize++;
        }

        nWaypoint++;
    }
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointBossGuard");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointBossGuard", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointBossGuard" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        SetLocalInt(oImport, "n" + sWaypoint + "Size", 0);
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // item num
            SetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum", 0);

            nSize++;
        }

        nWaypoint++;
    }

    // treasure waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointTreasure");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointTreasure", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // item num
        SetLocalInt(oImport, "n" + sWaypoint + "ItemNum", 0);

        // plot num
        SetLocalInt(oImport, "n" + sWaypoint + "PlotNum", 0);

        nWaypoint++;
    }

    // decor waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointDecorOpen");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointDecorOpen", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointDecorOpen" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        nWaypoint++;
    }
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointDecorWall");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointDecorWall", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointDecorWall" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        nWaypoint++;
    }

    // trap waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointTrap");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointTrap", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointTrap" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        nWaypoint++;
    }

    // generic doors
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "GenericDoor");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "GenericDoor", 0);
    DebugMessage("  sWaypoint is n" + sArea + "GenericDoor");

    // plot waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointPlot");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointPlot", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // plot num
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "PlotNum");
        SetLocalInt(oImport, "n" + sWaypoint + "PlotNum", 0);
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // gone
            SetLocalInt(oImport, "b" + sWaypoint + "Plot" + IntToString(nSize) + "ObjectGone", FALSE);

            nSize++;
        }

        nWaypoint++;
    }

    // puzzle waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointPuzzle");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointPuzzle", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointPuzzle" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // item num
        SetLocalInt(oImport, "n" + sWaypoint + "ItemNum", 0);

        // camp
        SetLocalInt(oImport, "b" + sWaypoint + "Camp", FALSE);

        // camp nodes
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 0);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 1);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 2);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 3);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 4);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 5);
        SetLocalInt(oImport, "n" + sWaypoint + "Node0Type", 6);

        nWaypoint++;
    }

    // secret door waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecret");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointSecret", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecret" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        nWaypoint++;
    }

    // secret encounter waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecretEncounter");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointSecretEncounter", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecretEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // size
        nSizeNum = GetLocalInt(oImport, "n" + sWaypoint + "Size");
        SetLocalInt(oImport, "n" + sWaypoint + "Size", 0);
        nSize = 1;
        while (nSize <= nSizeNum)
        {
            // item num
            SetLocalInt(oImport, "n" + sWaypoint + "Creature" + IntToString(nSize) + "ItemNum", 0);

            nSize++;
        }

        nWaypoint++;
    }

    // secret treasure waypoints
    nWaypointNum = GetLocalInt(oImport, "n" + sArea + "WaypointSecretTreasure");
    SetLocalInt(oImport, "nArea" + IntToString(nNum) + "WaypointSecretTreasure", 0);
    nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = sArea + "WaypointSecretTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
        DebugMessage("  sWaypoint is " + sWaypoint);

        // used
        SetLocalInt(oImport, "b" + sWaypoint + "Used", FALSE);

        // item num
        SetLocalInt(oImport, "n" + sWaypoint + "ItemNum", 0);

        nWaypoint++;
    }

    string sLevel = sArea + "Level" + IntToString(nLevel);

    // used
    SetLocalInt(oImport, "b" + sLevel + "Used", FALSE);

    // X
    SetLocalInt(oImport, "n" + sLevel + "X", 0);

    // Y
    SetLocalInt(oImport, "n" + sLevel + "Y", 0);

    // north
    SetLocalInt(oImport, "n" + sLevel + "North", 0);

    // south
    SetLocalInt(oImport, "n" + sLevel + "South", 0);

    // east
    SetLocalInt(oImport, "n" + sLevel + "East", 0);

    // west
    SetLocalInt(oImport, "n" + sLevel + "West", 0);

    // activated
    SetLocalInt(oImport, "b" + sLevel + "Activated", FALSE);

    // generated
    SetLocalInt(oImport, "b" + sLevel + "Generated", FALSE);

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
