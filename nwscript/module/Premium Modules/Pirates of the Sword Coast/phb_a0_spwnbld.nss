//::///////////////////////////////////////////////
//:: phb_a0_spwnbld
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the heartbeat event for the object
    that handles the spawn of the Blood sailors.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

void SafestSpawn(string sResRef, string sWaypointTag);

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    location lSelf = GetLocation(oSelf);
    string sSpawn;

    int iSpawned = GetLocalInt(oSelf, "iBLDSpawned");
    int iCounter = GetLocalInt(oSelf, "iBLDCounter");
    int iOff = GetLocalInt(oSelf, "CONTROLLER_DISABLED");
    int iFlag = FALSE;

    object oPC = GetFirstPC();

    if (iOff == FALSE)
    {
        //check for a PC in the area before handling spawns
        while (GetIsObjectValid(oPC) == TRUE)
        {
            if (GetArea(oPC) == oArea)
            {
                iFlag = TRUE;
            }
            oPC = GetNextPC();
        }

        // Check if more sailors are nesseary.
        while ((iCounter > iSpawned) && (iFlag == TRUE))
        {
            iSpawned++;

            sSpawn = "sResRef" + IntToString(iSpawned);
            sSpawn = GetLocalString(oSelf, sSpawn);

            SafestSpawn(sSpawn, "A0_BLD_SAFESPAWN");
            SetLocalInt(oSelf, "iBLDSpawned", iSpawned);
        }
    }
}

void SafestSpawn(string sResRef, string sWaypointTag)
{
    object oWayCursor = OBJECT_INVALID;
    object oWayHolder = OBJECT_INVALID;
    object oNearestPC = OBJECT_INVALID;

    float fDistCurr = 0.0f;
    float fDistBest = 0.0f;

    int iCounter = 0;
    location lTarget;

    oWayCursor = GetObjectByTag(sWaypointTag, iCounter++);
    while (GetIsObjectValid(oWayCursor) == TRUE)
    {
        oNearestPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
            PLAYER_CHAR_IS_PC, oWayCursor);

        fDistCurr = GetDistanceBetween(oNearestPC, oWayCursor);

        if (fDistBest < fDistCurr)
        {
            fDistBest = fDistCurr;
            oWayHolder = oWayCursor;
        }

        oWayCursor = GetObjectByTag(sWaypointTag, iCounter++);
    }

    lTarget = GetLocation(oWayHolder);
    CreateObject(OBJECT_TYPE_CREATURE, sResRef, lTarget);
}
