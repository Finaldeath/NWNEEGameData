//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_killboss
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Action Taken script for when the player refuses to cooperate with the boss
    creature, choosing instead to kill them. This script runs when the boss has
    had a chance to recuperate and return to full sterngth.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oThis = OBJECT_SELF;

    // Heal the boss to half hitpoints to present a challenge.
    int nMaxHitPoints = GetMaxHitPoints(oThis);
    effect eHeal = EffectHeal(nMaxHitPoints);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oThis);

    // Make the creature killable.
    SetImmortal(oThis, FALSE);
    SetPlotFlag(oThis, FALSE);

    string sTag = GetTag(OBJECT_SELF);
    string sBoss = "";
    if (sTag == ANTOINE_TAG)
    {
        sBoss = "Baccha";

        DestroyObject(GetObjectByTag("id1_bactel"));
    } else if (sTag == HAGATHA_TAG)
    {
        sBoss = "Hagatha";

        DestroyObject(GetObjectByTag("id1_hagtel"));
    } else if (sTag == MAGGRIS_TAG)
    {
        sBoss = "Maggris";

        DestroyObject(GetObjectByTag("id1_magtel"));
    } else if (sTag == HARAT_TAG)
    {
        sBoss = "Harat";

        DestroyObject(GetObjectByTag("id1_hartel"));
    } else if (sTag == GZHORB_TAG)
    {
        sBoss = "Gzhorb";

        DestroyObject(GetObjectByTag("id1_gzbtel"));
    } else if (sTag == MASTERIUS_TAG)
    {
        sBoss = "Masterius";

        DestroyObject(GetObjectByTag("id1_mastel"));
    } else if (sTag == HALASTER_TAG)
    {
        sBoss = "Halaster";

        DestroyObject(GetObjectByTag("id1_haltel"));
    }
    DebugMessage("sBoss is " + sBoss);
    SetLocalInt(GetModule(), "b" + sBoss + "Hostile", TRUE);

    // find and destroy teleporter
    object oWaypoint = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");
    object oTeleporter = GetNearestObjectByTag("id1_bosstel", oWaypoint);
    if (oTeleporter != OBJECT_INVALID)
    {
        // remove map pin
        SetMapPinEnabled(oWaypoint, FALSE);

        // destroy teleporter
        DestroyObject(oTeleporter);
    }

    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "bBossTeleporter", FALSE);


    // Create an invisible hostile creature in order to change oThis' faction.
    location lLoc = GetLocation(GetObjectByTag("CPU"));
    object oHostile = DB_CreateObject(OBJECT_TYPE_CREATURE, HOSTILE_RESREF, lLoc);
    ChangeFaction(oThis, oHostile);

    object oPC = GetPCSpeaker();
    DelayCommand(0.1, ActionAttack(oPC));

    DestroyObject(oHostile);
}
