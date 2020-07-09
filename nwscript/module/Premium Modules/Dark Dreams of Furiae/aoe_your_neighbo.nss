#include "ddf_util"
#include "ddf_ring_dialog"

void CreateLieutenant(object oPC);

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;

    //SetLocalInt(GetModule(), "ddf_in_area", AREA_YOUR_NEIGHBORHOOD);
    SetCurrentArea(oPC, AREA_YOUR_NEIGHBORHOOD);

    ExploreAreaForPlayer(OBJECT_SELF, oPC, TRUE);

    TryRingDialog(oPC);

    int iDay = GetCurrentDay();

    debug("-- current day: " + IntToString(iDay));


    // If it is NOT day 6, quit...
    if(GetCurrentDay() != 6) return;

    if(GetLocalInt(GetModule(), "setup_day6_dialog") == TRUE) return;

    SetLocalInt(GetModule(), "setup_day6_dialog", TRUE);

    // DEBUG
    debug("-- setup day 6 lieutenant dialog stuff");

    // ACTIVATE ENCOUNTER
    object oEncounter = GetObjectByTag("Day6LieutenantDialog");
    if(GetIsObjectValid(oEncounter))
    {
        //SetEncounterActive(TRUE, oEncounter);
    }
    else
    {
        debug("-- unable to find day 6 encounter...");
    }

    // CREATE GUARDS
    int i = 0;
    object oGuardWaypoint;

    // 2019-08-27 JY
    // Reducing the number of guards by 1, to 5 from 6. mes
    // https://app.asana.com/0/842177838074622/1135339449436949
    for(i = 0; i < 5; i++)
    {
        oGuardWaypoint = GetObjectByTag("POST_ddf_city_guard_0" + IntToString(i));
        CreateObject(OBJECT_TYPE_CREATURE, "ddfstaticguard03", GetLocation(oGuardWaypoint), FALSE, "ddf_city_guard_0" + IntToString(i));
    }


    // LOCK APARTMENT DOOR
    object oDoor = GetObjectByTag("YourApartmentExt");
    SetLocked(oDoor, TRUE);

    // CREATE WALLS
    string sWallWaypointTag = "DDF_LD6_WALL";

    string sBlueprint = "ddf_inviswal001";
    string sNewTag = "ddf_ld6_wall_tag";

    int wallCounter = 0;
    object oWaypoint = GetObjectByTag(sWallWaypointTag, wallCounter);
    location lTarget;
    object oNewWall;

    while(GetIsObjectValid(oWaypoint))
    {
        lTarget = GetLocation(oWaypoint);

        oNewWall = CreateObject(OBJECT_TYPE_PLACEABLE, sBlueprint, lTarget, FALSE, sNewTag);

        wallCounter = wallCounter + 1;
        oWaypoint = GetObjectByTag(sWallWaypointTag, wallCounter);
    }

    // CREATE LIEUTENANT

    sNewTag = "ddf_lieutenant";
    sBlueprint = "fraternityofo022";
    oWaypoint = GetObjectByTag("DDF_LD6_MAIN");
    lTarget = GetLocation(oWaypoint);
    object npc = CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lTarget, FALSE, sNewTag);

    //DelayCommand(1.0, CreateLieutenant(oPC));
    DelayCommand(1.0, AssignCommand(npc,   ActionStartConversation(oPC)));
}

void CreateLieutenant(object oPC)
{
    string sNewTag = "ddf_lieutenant";
    string sBlueprint = "fraternityofo022";
    object oWaypoint = GetObjectByTag("DDF_LD6_MAIN");
    location lTarget = GetLocation(oWaypoint);
    object npc = CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lTarget, FALSE, sNewTag);

    DelayCommand(1.0, AssignCommand(npc,   ActionStartConversation(oPC)));
}

