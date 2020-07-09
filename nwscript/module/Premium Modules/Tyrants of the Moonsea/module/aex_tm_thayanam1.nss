//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: aex_tm_thayanam1
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors - Cleanup
//:: Moves and restores some NPC at the end of the quest
//::////////////////////////////////////////////////////

#include "hf_in_plot"


const string NPC_TAG_ZAMAKUS = "CaptainZamakus";

const string NPC_TAG_SELFARIL = "tm_cr_selfaril0";
const string WP_TAG_SELFARIL = "WP_cut_thayanam1_selfaril_spawn";

const string NPC_RESREF_THAYAN_OFFICER = "tm_cr_thayguard0";
const string NPC_TAG_THAYAN_OFFICER = "tm_cr_thayguard0"; // + Number
const string WP_TAG_THAYAN_OFFICER = "WP_cut_thayanam1_zamakus_init";

const string NPC_RESREF_THAYAN_GUARD = "tm_cr_thayguard1";
const string NPC_TAG_THAYAN_GUARD = "tm_cr_thayguard1_"; // + Number
const string WP_TAG_THAYAN_GUARD = "POST_tm_cr_thayguard1_"; // + Number


// Replacement cor Captain Zamakus
void RespawnOfficer(object oArea)
{
    object oWaypoint = GetObjectByTag(WP_TAG_THAYAN_OFFICER);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_THAYAN_OFFICER, GetLocation(oWaypoint));
}


// Replace dead guards
void RespawnGuards(object oArea)
{
    int nNth = 0;
    string sGuardTag = "";
    object oGuard = OBJECT_INVALID;
    object oPost = GetObjectByTag(WP_TAG_THAYAN_GUARD+IntToString(nNth));
    while (GetIsObjectValid(oPost))
    {
        sGuardTag = NPC_TAG_THAYAN_GUARD+IntToString(nNth);
        oGuard = GetObjectByTag(sGuardTag);
        if ( !GetIsObjectValid(oGuard) || GetIsDead(oGuard) )
        {
            oGuard = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_THAYAN_GUARD, GetLocation(oPost), FALSE);
        }
        AssignCommand(oGuard, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oGuard, SetFacing(GetFacing(oPost))));

        nNth++;
        oPost = GetObjectByTag(WP_TAG_THAYAN_GUARD+IntToString(nNth));
    }
}


void main()
{
    object oPC = GetExitingObject();
    object oArea = OBJECT_SELF;

    if (GetIsPC(oPC) &&
       (GetLocalInt(OBJECT_SELF, "nDone") == 0) &&
       (PlotLevelGet("thayanam_status") >= 5) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        RespawnGuards(oArea);
        // RespawnOfficer(oArea);

        object oSelfaril = GetObjectByTag(NPC_TAG_SELFARIL);
        object oSelfarilWP = GetWaypointByTag(WP_TAG_SELFARIL);
        AssignCommand(oSelfaril, ClearAllActions(TRUE));
        DelayCommand(1.0f, AssignCommand(oSelfaril, JumpToLocation(GetLocation(oSelfarilWP))));

        // Destroy all instances of Zamakus
        int nNth = 0;
        object oZamakus = GetObjectByTag(NPC_TAG_ZAMAKUS, 0);
        while (GetIsObjectValid(oZamakus))
        {
            DelayCommand(1.5f, DestroyObject(oZamakus));
            nNth++;
            oZamakus = GetObjectByTag(NPC_TAG_ZAMAKUS, nNth);
        }
    }
}
