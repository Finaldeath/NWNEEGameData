// play Merrik cutscene if previously saved Merrik and Officer not killed

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            if(PlotLevelGet("IyraurothMerrik") == 1 &&
               !GetIsDead(GetNearestObjectByTag("IyraurothZhentarimOfficer")))
            {
                CutscenePlay(oPC, "cut_tm_merrik");
            }
        }
    }
}
