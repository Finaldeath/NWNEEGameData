// player enters the purple portal area

#include "hf_in_plot"

void spawnRex()
{
    object oWP = GetWaypointByTag("WP_MEPP_REX");
    CreateObject(OBJECT_TYPE_CREATURE, "thewrecker", GetLocation(oWP));
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // rex has been built and is ready for deployment
        if (PlotLevelGet("HighArtificerHlessen") == 4)
        {
            if (GetLocalInt(OBJECT_SELF, "nRexSpawn1") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nRexSpawn1", 1);
                spawnRex();
            }
        }

        // the player borrow rex and has completed the battle at the gates
        if (PlotLevelGet("HighArtificerHlessen") == 6)
        {
            if (GetLocalInt(OBJECT_SELF, "nRexSpawn2") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nRexSpawn2", 1);
                PlotLevelSet("TheWrecker", 4);
                spawnRex();
            }
        }
    }
}
