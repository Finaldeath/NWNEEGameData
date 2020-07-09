//::///////////////////////////////////////////////
//:: aen_a0_turfwar
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Generate Hostiles in the turfwar areas.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void SpawnHostile(string sResRef, location lSpawn);
void SpawnBRBNPCs(object oWayPoint);
void SpawnBLDNPCs(object oWayPoint);

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oCursor, oBoss;

    object oBRBFaction = GetObjectByTag("a0_spwnbnd");
    object oBLDFaction = GetObjectByTag("a0_spwnbld");

    int iDoOnce = GetLocalInt(oArea, "aen_a0_turfwar");
    int iGlobalLev = GetLocalInt(oModule, "GLOBAL_LEVEL");
    int iBRBAlly, iBLDSAlly;

    // If the entering object is PC poputlate the area.
    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oArea, "aen_a0_turfwar", TRUE);

        iBRBAlly = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");
        iBLDSAlly = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");

        iGlobalLev = 11;

        // cycle through all of the area objects
        oCursor = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            switch (GetObjectType(oCursor))
            {
                // update the faction of the traps
                case OBJECT_TYPE_TRIGGER :
                    if (iBRBAlly == TRUE)
                        SetIsTemporaryFriend(oCursor, oBRBFaction);
                    else if (iBLDSAlly == TRUE)
                        SetIsTemporaryFriend(oCursor, oBLDFaction);

                    // scale the traps in the area to inside the PCs skill range.
                    if ((GetTrapDisarmDC(oCursor) < iGlobalLev + 15)
                      || (GetTrapDisarmDC(oCursor) > iGlobalLev + 20))
                    {
                        SetTrapDisabled(oCursor);
                    }

                break;

                // Spawn hostiles on the waypoints
                case OBJECT_TYPE_WAYPOINT :
                    if (iBRBAlly == TRUE)
                        DelayCommand(0.5f, SpawnBLDNPCs(oCursor));
                    if (iBLDSAlly == TRUE)
                        DelayCommand(0.5f, SpawnBRBNPCs(oCursor));
                break;
            }

            oCursor = GetNextObjectInArea(oArea);
        }
    }
}

void SpawnBRBNPCs(object oWayPoint)
{
    object oCursor;
    string sTag = GetTag(oWayPoint);
    location lSpawn = GetLocation(oWayPoint);
    int iLevel = GetLocalInt(GetModule(), "A0_WARLEVEL");

    // Create a Boss according the the spawn order.
    if (sTag == "DW_BOSS")
    {
        if (iLevel == 0)
        {
            SpawnHostile("a0_blksorcerer", lSpawn);
        }
        else if (iLevel == 1)
        {
            SpawnHostile("a0_blkcleric", lSpawn);
        }
        else if (iLevel == 2)
        {
            SpawnHostile("a0_blkfighter", lSpawn);
        }
        else
        {
            SpawnHostile("a0_blkrogue", lSpawn);
        }

        SetLocalInt(GetModule(), "A0_WARLEVEL", (iLevel + 1));
    }

    // Create Pawns based on tag name and level
    else if ((sTag == "DW_PAWN1") && (iLevel >= 0))
    {
        SpawnHostile("a0_blkpawn1", lSpawn);
    }
    else if ((sTag == "DW_PAWN2") && (iLevel >= 1))
    {
        SpawnHostile("a0_blkpawn2", lSpawn);
    }
    else if ((sTag == "DW_PAWN3") && (iLevel >= 2))
    {
        SpawnHostile("a0_blkpawn3", lSpawn);
    }
    else if ((sTag == "DW_PAWN4") && (iLevel >= 3))
    {
        SpawnHostile("a0_blkpawn4", lSpawn);
    }

    return;
}

void SpawnBLDNPCs(object oWayPoint)
{
    string sTag = GetTag(oWayPoint);
    location lSpawn = GetLocation(oWayPoint);
    int iLevel = GetLocalInt(GetModule(), "A0_WARLEVEL");

    // Create a Boss according the the spawn order.
    if (sTag == "DW_BOSS")
    {
        if (iLevel == 0)
        {
            SpawnHostile("a0_bldcleric", lSpawn);
        }
        else if (iLevel == 1)
        {
            SpawnHostile("a0_bldfighter", lSpawn);
        }
        else if (iLevel == 2)
        {
            SpawnHostile("a0_bldrogue", lSpawn);
        }
        else
        {
            SpawnHostile("a0_bldsorcerer", lSpawn);
        }

        SetLocalInt(GetModule(), "A0_WARLEVEL", (iLevel + 1));
    }

    // Create Pawns based on tag name and level
    else if ((sTag == "DW_PAWN1") && (iLevel >= 0))
    {
        SpawnHostile("a0_bldpawn1", lSpawn);
    }
    else if ((sTag == "DW_PAWN2") && (iLevel >= 1))
    {
        SpawnHostile("a0_bldpawn2", lSpawn);
    }
    else if ((sTag == "DW_PAWN3") && (iLevel >= 2))
    {
        SpawnHostile("a0_bldpawn3", lSpawn);
    }
    else if ((sTag == "DW_PAWN4") && (iLevel >= 3))
    {
        SpawnHostile("a0_bldpawn4", lSpawn);
    }

    return;
}

void SpawnHostile(string sResRef, location lSpawn)
{
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn);
    //DelayCommand(0.5f, ChangeToStandardFaction(oSpawn, STANDARD_FACTION_HOSTILE));
}
