#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oExit = GetNearestObjectByTag("WP_AR2104_EXIT", oPC);
    AssignCommand(OBJECT_SELF, ClearAllActions());
    AssignCommand(OBJECT_SELF, ActionMoveToObject(oExit, FALSE, 0.5));
}

