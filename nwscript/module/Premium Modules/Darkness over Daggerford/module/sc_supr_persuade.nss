//returns true if the PC makes a superior persuade check
//triggered from conversation
//Author: Damian Brown (Luspr)
//Date: 27-07-2005
#include "nw_i0_plot"
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "astriel_persuade_true")==1)//pc has already persuaded Astriel
    return TRUE;
    else
    {
    return AutoDC(DC_SUPERIOR, SKILL_PERSUADE, GetPCSpeaker());
    //carry out skill check - level related difficulty
    }
}
