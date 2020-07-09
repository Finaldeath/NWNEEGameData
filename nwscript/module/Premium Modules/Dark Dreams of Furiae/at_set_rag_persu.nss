//::///////////////////////////////////////////////
//:: FileName at_set_rag_persu
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2018 1:45:25 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    // Set the variables
    int bPassed = AutoDC(DC_MEDIUM, SKILL_PERSUADE, GetPCSpeaker());
    SetLocalInt(GetModule(), "ddf_rag_persuade", bPassed);

    SetLocalInt(GetModule(), "ddf_rag_check", 1);

}
