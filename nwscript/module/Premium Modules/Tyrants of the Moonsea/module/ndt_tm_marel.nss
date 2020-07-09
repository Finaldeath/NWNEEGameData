//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_marel
//:: DATE: February 06, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Random Enounter: Seal Elves (Marels)
//:: Starts next cutscene/ wave once enough enemies have
//:: been destroyed.
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_cutscene"


const string TRG_TAG_CUTSCENE = "trg_cut_marel0";
const string WP_TAG_CUTSCENE = "WP_cut_marel_uw_pc_init";

const int MAX_ATTACK_WAVES = 3;

const string LVAR_MAREL_DONT_COUNT = "re_marel_dont_count";
const string LVAR_MAREL_ENEMIES_LEFT = "re_marel_enemy_cnt";
const string PVAR_MAREL_CURRENT_WAVE = "re_marel_wave_cnt";


void main()
{
    // Cancel this if this marel shouldn't be counted towards the number of dead marel
    // (i.e. underwater spawns)
    if (GetLocalInt(OBJECT_SELF, LVAR_MAREL_DONT_COUNT) > 0)
        return;

    object oPC = GetFirstPC();

    int nEnemiesLeft = GetLocalInt(oPC, LVAR_MAREL_ENEMIES_LEFT)-1;
    SetLocalInt(oPC, LVAR_MAREL_ENEMIES_LEFT, nEnemiesLeft);

    if (nEnemiesLeft <= 0)
    {
        int nCurrentWave = PlotLevelGet(PVAR_MAREL_CURRENT_WAVE);
        if (nCurrentWave < MAX_ATTACK_WAVES)
        {
            // Re-activate cutscene trigger
            object oCutsceneTrigger = GetObjectByTag(TRG_TAG_CUTSCENE);
            SetLocalInt(oCutsceneTrigger, "nDone", 0);

            // Jump to cutscene trigger
            object oCutsceneWaypoint = GetWaypointByTag(WP_TAG_CUTSCENE);
            AssignCommand(oPC, ClearAllActions(TRUE));
            DelayCommand(1.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oCutsceneWaypoint))));
        }
        else
        {
            // Encounter is over, open the navigation cabin
            object oDoor = GetNearestObjectByTag("dt_marel_navicabi", OBJECT_SELF);
            SetLocked(oDoor, FALSE);

            GiveXPToCreature(oPC, 500);
        }
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
