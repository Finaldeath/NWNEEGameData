#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            string sClericTag = GetLocalString(GetModule(), "UmgatlikCleric");
            if (sClericTag != "")
            {
                // destroy the old one outside
                int i = 0;
                object oCleric = GetObjectByTag(sClericTag, i);
                while (GetIsObjectValid(oCleric))
                {
                    DestroyObject(oCleric);
                    oCleric = GetObjectByTag(sClericTag, ++i);
                }

                // create the cleric and move to the bridge
                object oWP  = GetWaypointByTag("WP_AR2104_SHRINE_ENTER");
                object oDst = GetWaypointByTag("WP_AR2104_BRIDGE");
                oCleric = CreateObject(OBJECT_TYPE_CREATURE, sClericTag, GetLocation(oWP));
                AssignCommand(oCleric, ActionSpeakString("Follow me!"));
                AssignCommand(oCleric, ActionMoveToObject(oDst, TRUE, 0.5));
                AssignCommand(oCleric, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));
                PlotLevelSet(sClericTag, 3);
            }
        }
    }
}
