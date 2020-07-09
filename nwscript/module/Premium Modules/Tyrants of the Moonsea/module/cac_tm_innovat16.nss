//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovat16
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: Fade screen, jump player to Gladiator Pit.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oWaypoint = GetObjectByTag("WP_cut_arena_pc_init");

    //Set Drizzle's end conversation
    PlotLevelSet("DrizzletheAlchemist", 2);

    FadeToBlack(oPC, FADE_SPEED_SLOW);
    DelayCommand(2.0, AssignCommand(oPC, JumpToObject(oWaypoint)));
}
