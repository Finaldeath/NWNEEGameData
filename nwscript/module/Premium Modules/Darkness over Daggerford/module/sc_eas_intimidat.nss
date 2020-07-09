//returns true if the PC makes an easy intimidate check
//triggered from conversation
//Author: Brian Watson after Anya Clancy
//Date: May 9, 2006
#include "nw_i0_plot"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return AutoDC(DC_EASY, SKILL_INTIMIDATE, GetPCSpeaker());
}
