//:://////////////////////////////////////////////
//:: ten_a0_mbshwarn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Warn the player about Delas trap, if they
    succeed an easy Search Check.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "nw_i0_plot"

const string sWarning = "Search Check : It seem the stone near here is soaked with lamp oil.";
const string sCheckFailed = "Failed a search check.";

void main()
{
    object oPC = GetEnteringObject();
    int iDelaPlot = GetLocalInt(GetModule(), "A0_AMBUSH");
    int iAutoDC;

    if((GetIsPC(oPC) == TRUE) && (iDelaPlot == 10))
    {
        iAutoDC = AutoDC(DC_EASY, SKILL_SEARCH, oPC);

        if(iAutoDC == TRUE)
        {
            FloatingTextStringOnCreature(sWarning, oPC, FALSE);
        }
        else
        {
            SendMessageToPC(oPC, sCheckFailed);
        }
    }
}
