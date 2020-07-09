//returns true if the PC makes a medium bluff check
//triggered from conversation
//Author: Anya Clancy (based on Damian's script)
//Date: Oct. 9, 2005
#include "nw_i0_plot"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return AutoDC(DC_MEDIUM, SKILL_BLUFF, GetPCSpeaker());
}
