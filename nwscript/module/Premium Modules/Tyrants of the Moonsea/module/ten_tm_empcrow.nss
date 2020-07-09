//Create Kornah's crow messenger and initiate dialog with PC

#include "x0_i0_position"

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && PlotLevelGet("KornahtheCrazy") == 9 &&
       PlotLevelGet("KornahCrowSpawned") == 0)
    {
        object oCrow = CreateObject(OBJECT_TYPE_CREATURE, "empathycrow", GetOppositeLocation(oPC));
        AssignCommand(oCrow, ActionStartConversation(oPC));
        PlotLevelSet("KornahCrowSpawned", 1);
    }

    if(PlotLevelGet("KornahCrowSpawned") == 1)
    {
        DestroyObject(OBJECT_SELF);
    }
}
