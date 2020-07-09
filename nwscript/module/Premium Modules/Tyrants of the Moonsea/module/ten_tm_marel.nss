//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_marel
//:: DATE: February 06, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Random Enounter: Seal Elves (Marels)
//:: Spawns the next wave of enemies
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_friend"

// Underwater cutscene trigger
const string WP_TAG_CUTSCENE = "WP_cut_marel_uw_pc_init";

const string NPC_TAG_SHIP_MAREL_SOLDIER = "CR_cut_marel_sh_marel";
const string WP_TAG_SHIP_MAREL_SOLDIER  = "WP_cut_marel_sh_marel_spawn";

const string RESREF_TAG_SHIP_MAREL_LEADER = "tm_cr_marel3";
const string NPC_TAG_SHIP_MAREL_LEADER = "CR_cut_marel_sh_leader";
const string WP_TAG_SHIP_MAREL_LEADER  = "WP_cut_marel_sh_leader_spawn";

const string LVAR_MAREL_ENEMIES_LEFT = "re_marel_enemy_cnt";
const string LVAR_MAREL_WAVES_DONE   = "re_marel_waves_done";
const string PVAR_MAREL_CURRENT_WAVE = "re_marel_wave_cnt";

const string WP_TAG_PLAYER_SHIP_INIT = "WP_cut_marel_sh_pc_init";

const string NPC_TAG_KETTIA = "CaptainKettia";

const int MAX_ATTACK_WAVES = 3;


int SpawnMarels(object oPC, string sWaypointTag)
{
    int nNumSpawned = 0;
    // If a single Marel is existing don't spawn any new ones
    object oExistingMarel = GetObjectByTag(NPC_TAG_SHIP_MAREL_SOLDIER);
    if (!GetIsObjectValid(oExistingMarel) || GetIsDead(oExistingMarel))
    {
        string sResRef = "";
        object oMarel = OBJECT_INVALID;
        object oWaypoint = GetObjectByTag(sWaypointTag, nNumSpawned);
        while (GetIsObjectValid(oWaypoint))
        {
            sResRef = GetLocalString(oWaypoint, "resref");
            oMarel = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oWaypoint), TRUE, NPC_TAG_SHIP_MAREL_SOLDIER);
            ExecuteScript("hf_ut_hostile", oMarel);

            nNumSpawned++;
            oWaypoint = GetObjectByTag(sWaypointTag, nNumSpawned);
        }
    }
    return nNumSpawned;
}


void main()
{
    object oPC = GetEnteringObject();

    int nCurrentWave = PlotLevelGet(PVAR_MAREL_CURRENT_WAVE);
    int nDoneWaves = GetLocalInt(OBJECT_SELF, LVAR_MAREL_WAVES_DONE);

    if (GetIsPC(oPC))
    {
        // Kettia is our friend in this area
        object oKettiaNearest = GetWaypointByTag(WP_TAG_PLAYER_SHIP_INIT);
        object oKettia = GetNearestObjectByTag(NPC_TAG_KETTIA, oKettiaNearest);
        if (GetIsObjectValid(oKettia))
        {
            FriendSetMaster(oPC, oKettia);
        }

        // When first entered start a cutscene immediately
        if (nCurrentWave <= 0)
        {
            SetLocalInt(OBJECT_SELF, LVAR_MAREL_WAVES_DONE, 0);

            object oCutsceneWaypoint = GetWaypointByTag(WP_TAG_CUTSCENE);
            DelayCommand(2.5f, AssignCommand(oPC, ClearAllActions(TRUE)));
            DelayCommand(3.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oCutsceneWaypoint))));
        }
        // Subsequent entries spawn enemies
        // Next cutscene gets triggered by "ndt_tm_marel" once all enemies are dead
        else if ((nCurrentWave <= MAX_ATTACK_WAVES) && (nCurrentWave > nDoneWaves) )
        {
            SetLocalInt(OBJECT_SELF, LVAR_MAREL_WAVES_DONE, nCurrentWave);

            int nNumMarels = SpawnMarels(oPC, WP_TAG_SHIP_MAREL_SOLDIER);
            // Final Stage, spawn in the leader
            if (nCurrentWave == MAX_ATTACK_WAVES)
            {
                object oWaypoint = GetWaypointByTag(WP_TAG_SHIP_MAREL_LEADER);
                object oMarel = CreateObject(OBJECT_TYPE_CREATURE, RESREF_TAG_SHIP_MAREL_LEADER, GetLocation(oWaypoint), TRUE, NPC_TAG_SHIP_MAREL_LEADER);
                ExecuteScript("hf_ut_hostile", oMarel);
                nNumMarels++;
            }
            // Save number of spawned marels
            SetLocalInt(GetFirstPC(), LVAR_MAREL_ENEMIES_LEFT, nNumMarels);
        }
    }
}
