//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_announce2
//:: DATE: April 1, 2006.
//:: AUTH: Luke Scull
//:: NOTE: Dialog during arena cutscene.
//::////////////////////////////////////////////////////
//:: Player spares Blizzard
//::////////////////////////////////////////////////////

#include "cut_tm_arena_inc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Blizzard-Arena-Outcome", 0);  // Blizzard spared, friendly towards PC
}
