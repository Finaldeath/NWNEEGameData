// area exit script for zhentil keep after the attack

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        //Switch off visual effects
        PlotLevelSet("ZKWarVFX", 0);
        //Factions may have been affected by NPCs being charmed, so reset
        ResetFactionReputation(oPC, oPC);
    }
}
