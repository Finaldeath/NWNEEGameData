// player has interacted with the mirror in Edalseye's bedroom
// .. the chest makes a few snide comments if it hasn't been "oiled" yet

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("ks_wise_chest") < 2)
    {
        object oChest = GetNearestObjectByTag("ks_wise_chest", oPC);
        string sQuote = GetLocalString(GetModule(),"QUOTE");
        AssignCommand(oChest, ActionSpeakString(sQuote+"You'll never turn on that fountain! Know why? Because only my master has the key!"+sQuote));
    }
}
