//returns true if the PC makes a medium intimidate check
//triggered from conversation
//Author: Anya Clancy
//Date: Oct. 9, 2005
#include "nw_i0_plot"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return AutoDC(DC_MEDIUM, SKILL_INTIMIDATE, GetPCSpeaker());
}
