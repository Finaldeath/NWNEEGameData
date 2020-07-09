//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: aen_tm_thayanam0
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: Cleans up cutscene at the docks upon leavin the
//:: area
//::////////////////////////////////////////////////////

#include "hf_in_plot"


const string NPC_TAG_GUARD = "CR_cut_thayanam0_guard";

const string NPC_TAG_AMBASSADOR = "CR_cut_thayanam0_ambassador";

const string NPC_TAG_SPECTATOR = "CR_cut_thayanam0_spectator";

const string NPC_TAG_GOLEM = "CR_cut_thayanam0_golem";

const string NPC_RESREF_ZAMAKUS = "captainzamakus";
const string NPC_TAG_ZAMAKUS = "CaptainZamakus";
const string WP_TAG_ZAMAKUS_JUMP = "WP_cut_thayanam0_zama_jump";

const string WP_TAG_EXIT_ALL = "WP_cut_thayanam0_move_all";


void thayanam_cleanup(object oPC)
{
    if (PlotLevelGet("thayanam_status") == 1)
    {
        object oAreaWaypoint = GetWaypointByTag(WP_TAG_EXIT_ALL);
        int nNth = 0;

        // Removes Guards
        nNth = 0;
        object oGuard = GetObjectByTag(NPC_TAG_GUARD, nNth);
        while (GetIsObjectValid(oGuard))
        {
            DestroyObject(oGuard);

            nNth++;
            oGuard = GetObjectByTag(NPC_TAG_GUARD, nNth);
        }

        // Removes Golems
        nNth = 0;
        object oGolem = GetObjectByTag(NPC_TAG_GOLEM, nNth);
        while (GetIsObjectValid(oGolem))
        {
            DestroyObject(oGolem);

            nNth++;
            oGolem = GetObjectByTag(NPC_TAG_GOLEM, nNth);
        }

        // Remove Spectators
        nNth = 0;
        object oSpecator = GetObjectByTag(NPC_TAG_SPECTATOR, nNth);
        while (GetIsObjectValid(oSpecator))
        {
            DestroyObject(oSpecator);

            nNth++;
            oSpecator = GetObjectByTag(NPC_TAG_SPECTATOR, nNth);
        }

        // Remove Ambassador
        object oAmbassador = GetNearestObjectByTag(NPC_TAG_AMBASSADOR, oAreaWaypoint);
        DestroyObject(oAmbassador);

        // Remove Zamakus
        object oZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oAreaWaypoint);
        DestroyObject(oZamakus);

        // Move Zamakus in front of Thayan Embassy
        object oZamakusWaypoint = GetWaypointByTag(WP_TAG_ZAMAKUS_JUMP);
        oZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oZamakusWaypoint);
        if (!GetIsObjectValid(oZamakus))
            oZamakus = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ZAMAKUS, GetLocation(oZamakusWaypoint));
        // Set Plot (Dialog) level
        if (PlotLevelGet(NPC_TAG_ZAMAKUS) < 2)
            PlotLevelSet(NPC_TAG_ZAMAKUS, 2);
    }
}


void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        thayanam_cleanup(oPC);
    }
}
