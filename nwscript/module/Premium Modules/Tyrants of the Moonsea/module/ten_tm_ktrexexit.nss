//The Wrecker exits Kur-Tharsu if the PC moves beyond the now destroyed main gate
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0 &&
       PlotLevelGet("TheWrecker") == 3)
    {
        object oWrecker = GetNearestObjectByTag("TheWrecker", oPC);

        if(GetIsObjectValid(oWrecker) && !GetIsDead(oWrecker) && !IsInConversation(oWrecker))
        {
            AssignCommand(oWrecker, ClearAllActions(TRUE));
            FloatingTextStringOnCreature("The Wrecker has returned to its master.", oPC);
            PlotLevelSet("TheWrecker", 4);
            SetLocalString(oWrecker, "HF_EXIT_NAME", "WP_THKTMG_REX_EXIT");
            ExecuteScript("hf_cs_exit", oWrecker);
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
        }
    }
}
