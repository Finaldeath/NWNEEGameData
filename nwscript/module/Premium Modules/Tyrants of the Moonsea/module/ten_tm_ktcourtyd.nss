//OnEnter trigger in Kur-Tharsu Gate courtyard to switch on missile attacks
//within courtyard if gate not yet destroyed  and switch off further bridge
//missile attacks

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        PlotLevelSet("KTBridgeMissile", 0);
        DestroyObject(GetNearestObjectByTag("BridgeTriggerOil1"));
        DestroyObject(GetNearestObjectByTag("BridgeTriggerOil2"));

        if(PlotLevelGet("KTGateDestroyed") == 0)
        {
            PlotLevelSet("KTCourtyardMissile", 1);
        }
    }
}
