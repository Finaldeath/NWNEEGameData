// transition click script from Elventree to Elmwood
// player can't exit elventree until after "cut_tm_astdeath" runs

#include "hf_in_plot"

void main()
{
    object oClicker = GetClickingObject();
    if (GetIsPC(oClicker))
    {
        if (!GetIsInCombat(oClicker))
        {
            if (PlotLevelGet("ElmwoodOpen") > 0)
            {
                ExecuteScript("hf_map_show", OBJECT_SELF);
            }
            else
            {
                SpeakString("A sign reads: The trail is temporarily closed due to flooding.");
            }
        }
    }
}
