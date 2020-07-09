void SpawnBRBNPCs(object oWayPoint);
void SpawnBSRNPCs(object oWayPoint);

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oCursor, oFaction, oBoss;

    int iDoOnce = GetLocalInt(oArea, "aen_a0_turfshltr");
    int iBRBAlly, iBLDSAlly;

    // If the entering object is PC poputlate the area.
    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oArea, "aen_a0_turfshltr", TRUE);

        //SendMessageToPC(oPC, "TEST!");

        iBRBAlly = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");
        iBLDSAlly = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");

        // cycle through all of the area objects
        oCursor = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            if (GetObjectType(oCursor) == OBJECT_TYPE_WAYPOINT)
            {
                if (iBLDSAlly == TRUE)
                    DelayCommand(0.5f, SpawnBSRNPCs(oCursor));
                if (iBRBAlly == TRUE)
                    DelayCommand(0.5f, SpawnBRBNPCs(oCursor));
            }

            oCursor = GetNextObjectInArea(oArea);
        }
    }
}

void SpawnBRBNPCs(object oWayPoint)
{
    string sTag = GetTag(oWayPoint);
    location lSpawn = GetLocation(oWayPoint);
    int iLevel = GetLocalInt(GetModule(), "A0_TURFLEVEL");

    // Create a Boss according the the spawn order.
    if (sTag == "DW_BOSS")
    {
        if (iLevel == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_blksorcerer", lSpawn);
        }
        else if (iLevel == 1)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_blkcleric", lSpawn);
        }
        else if (iLevel == 2)
        {
        //    CreateObject(OBJECT_TYPE_CREATURE, "a0_blkfighter", lSpawn);
        }
        else
        {
        //    CreateObject(OBJECT_TYPE_CREATURE, "a0_blkrogue", lSpawn);
        }

        SetLocalInt(GetModule(), "A0_TURFLEVEL", (iLevel + 1));
    }

    // Create Pawns based on tag name and level
    else if (sTag == "DW_PAWN1")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_blkpawn1", lSpawn);
    }
    else if (sTag == "DW_PAWN2")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_blkpawn2", lSpawn);
    }
    else if (sTag == "DW_PAWN3")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_blkpawn3", lSpawn);
    }
    else if (sTag == "DW_PAWN4")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_blkpawn4", lSpawn);
    }

    return;
}

void SpawnBSRNPCs(object oWayPoint)
{
    string sTag = GetTag(oWayPoint);
    location lSpawn = GetLocation(oWayPoint);
    int iLevel = GetLocalInt(GetModule(), "A0_TURFLEVEL");

    // Create a Boss according the the spawn order.
    if (sTag == "DW_BOSS")
    {
        if (iLevel == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_bldcleric", lSpawn);
        }
        else if (iLevel == 1)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_bldfighter", lSpawn);
        }
        else if (iLevel == 2)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_bldrogue", lSpawn);
        }
        else
        {
            CreateObject(OBJECT_TYPE_CREATURE, "a0_bldsorcerer", lSpawn);
        }

        SetLocalInt(GetModule(), "A0_TURFLEVEL", (iLevel + 1));
    }

    // Create Pawns based on tag name and level
    else if (sTag == "DW_PAWN1")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_bldpawn1", lSpawn);
    }
    else if (sTag == "DW_PAWN2")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_bldpawn2", lSpawn);
    }
    else if (sTag == "DW_PAWN3")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_bldpawn3", lSpawn);
    }
    else if (sTag == "DW_PAWN4")
    {
        CreateObject(OBJECT_TYPE_CREATURE, "a0_bldpawn4", lSpawn);
    }

    return;
}
