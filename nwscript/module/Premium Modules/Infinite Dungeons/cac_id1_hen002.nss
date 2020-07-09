#include "inc_id1_debug"

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetMaster(oSelf);

    // remove plot henchman from the player
    RemoveHenchman(oPC, oSelf);

    int bPlot = GetPlotFlag(oSelf);
    DebugMessage("Destroying self, and plot flag is " + IntToString(bPlot));
    if (bPlot == TRUE)
    {
        SetPlotFlag(oSelf, FALSE);
    }

    // destroy self
    DelayCommand(0.01, DestroyObject(oSelf));
}
