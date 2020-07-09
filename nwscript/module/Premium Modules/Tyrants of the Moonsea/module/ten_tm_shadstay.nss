//Shadovar Assassins won't leave the vicinity without finding Dominion
#include "hf_in_plot"
#include "inc_ktgate"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if(PlotLevelGet("ShadovarAssassinKT") == 5)
        {
            int i = 1;
            object oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, i);
            while(oAssassin != OBJECT_INVALID)
            {
                if(!GetIsDead(oAssassin))
                {
                    AssignCommand(oAssassin,
                        SpeakString("We will not leave without Dominion!", TALKVOLUME_SHOUT));
                    break;
                }
                oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, ++i);
            }
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
        }
    }
}
