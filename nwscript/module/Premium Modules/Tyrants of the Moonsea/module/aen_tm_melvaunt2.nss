// area enter for melevaunt central market area

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
        }

        // sidequest: murgah's magnificent machine
        // .. murgah is building the machine and instantly finishes
        // .. as soon as the player leaves the shop!
        if (PlotLevelGet("HighArtificerHlessen") == 3)
        {
            PlotLevelSet("HighArtificerHlessen", 4);
        }
    }
}
