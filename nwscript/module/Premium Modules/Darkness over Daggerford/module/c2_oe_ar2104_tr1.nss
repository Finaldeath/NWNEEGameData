#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        string sClericTag = GetLocalString(GetModule(), "UmgatlikCleric");
        object oCleric = GetNearestObjectByTag(sClericTag, oPC);
        if (GetIsObjectValid(oCleric))
        {
            PlotLevelSet(sClericTag, 4);
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oCleric, ActionStartConversation(oPC, "", FALSE, FALSE));
            DestroyObject(OBJECT_SELF);
        }
    }
}
