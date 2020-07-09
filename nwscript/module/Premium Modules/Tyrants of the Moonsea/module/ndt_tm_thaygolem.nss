//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_thaygolem
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: OnDeath script for Diamond Golems
//:: Starts next cutscene once all golems are destroyed
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_cutscene"


const int NUM_TOTAL_ENEMIES = 12;
const string LVAR_DEAD_ENEMIES = "ndt_tm_thaygolem_cnt";


void main()
{
    object oPC = GetFirstPC();

    int nDeadEnemies = GetLocalInt(oPC, LVAR_DEAD_ENEMIES)+1;
    SetLocalInt(oPC, LVAR_DEAD_ENEMIES, nDeadEnemies);

    if ((nDeadEnemies >= NUM_TOTAL_ENEMIES) && (PlotLevelGet("thayanam_status") < 4))
    {
        DeleteLocalInt(oPC, LVAR_DEAD_ENEMIES);

        AddJournalQuestEntry("ThayanAmbassadors", 40, oPC);
        PlotLevelSet("thayanam_status", 4);
        
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);
        
        DelayCommand(3.0f, CutscenePlay(oPC, "cut_tm_thayanam2"));
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
