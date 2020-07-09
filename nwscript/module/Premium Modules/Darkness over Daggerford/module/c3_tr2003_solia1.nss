// at the end of the plot, soliana speaks to the player to give thanks

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oSoliana = GetNearestObjectByTag("ks_soliana");
        if (GetIsObjectValid(oSoliana) && !GetIsDead(oSoliana))
        {
            if (PlotLevelGet("ks_soliana") == 2)
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionStartConversation(oSoliana));
            }
        }
    }
}
