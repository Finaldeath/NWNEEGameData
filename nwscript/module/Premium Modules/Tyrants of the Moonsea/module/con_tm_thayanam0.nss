//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_thayanam0
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Checks whether the PC can ask for a invitation:
//:: - Quest has to be started (cutscene cut_tm_thayanam0)
//:: - This NPC has not given the PC an invitation yet
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    object oNPC = OBJECT_SELF;

    return ( (PlotLevelGet("thayanam_status") >= 1) && (GetLocalInt(oNPC, "thayanam_invitation") == 0) );
}

