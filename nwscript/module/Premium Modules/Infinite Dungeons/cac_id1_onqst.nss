//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_onqst
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Actuon Taken script that flags the boss as having had the player accept
    their quest. This script should also cause the boss creature to give the
    player an unique item that will allow the player communication with the
    boss.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    string sTag = GetTag(OBJECT_SELF);
    DebugMessage("");
    DebugMessage("Boss teleporter activated.");
    DebugMessage("Boss tag is " + sTag);

    // Determine the base tag of the item in it's dormant state, based on the boss.
    if (sTag == ANTOINE_TAG)
    {
        DebugMessage("Tag is baccha.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("BACCHA_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bactel", GetLocation(oLairTeleporter));
    } else if (sTag == HAGATHA_TAG)
    {
        DebugMessage("Tag is hagatha.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("HAGATHA_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_hagtel", GetLocation(oLairTeleporter));
    } else if (sTag == MAGGRIS_TAG)
    {
        DebugMessage("Tag is maggris.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("MAGGRIS_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_magtel", GetLocation(oLairTeleporter));
    } else if (sTag == HARAT_TAG)
    {
        DebugMessage("Tag is harat.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("HARAT_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_hartel", GetLocation(oLairTeleporter));
    } else if (sTag == GZHORB_TAG)
    {
        DebugMessage("Tag is gzhorb.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("GZHORB_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_gzbtel", GetLocation(oLairTeleporter));
    } else if (sTag == MASTERIUS_TAG)
    {
        DebugMessage("Tag is masterius.");

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));

        // enable spawn dungeon entrance teleporter
        object oLairTeleporter = GetWaypointByTag("MASTERIUS_TELEPORTER");
        SetMapPinEnabled(oLairTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_mastel", GetLocation(oLairTeleporter));
    }
}
