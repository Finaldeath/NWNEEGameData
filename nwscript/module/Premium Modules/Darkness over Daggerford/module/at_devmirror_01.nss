// player has finished interacting with the mirror
// .. chest makes a snide remark if it hasn't been "oiled" yet

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    if (PlotLevelGet("ks_wise_chest") < 2)
    {
        object oChest = GetNearestObjectByTag("ks_wise_chest", oPC);
        if (GetIsObjectValid(oChest))
        {
            string sQuote = GetLocalString(GetModule(), "QUOTE");
            AssignCommand(oChest, ClearAllActions());
            AssignCommand(oChest, ActionSpeakString(sQuote+"Hey! If you stare any deeper into that mirror, you’re going to fall in!"+sQuote));
        }

        if (GetLocalInt(OBJECT_SELF, "nFirstComment") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nFirstComment", 1);
            object oSkully = GetNearestObjectByTag("ks_skully");
            if (GetIsObjectValid(oSkully))
            {
                string sQuote = GetLocalString(GetModule(), "QUOTE");
                AssignCommand(oSkully, ClearAllActions());
                AssignCommand(oSkully, ActionSpeakString(sQuote+"Is that box annoying or what? Pay no attention to it boss. Pfff! A talking box...yeah, right."+sQuote));
            }
        }
    }
}
