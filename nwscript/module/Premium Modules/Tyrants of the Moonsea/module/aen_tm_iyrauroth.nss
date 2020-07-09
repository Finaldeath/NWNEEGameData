//Iyrauroth lair OnEnter
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        //Iyrauroth speaks on first enter
        if(GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            object oDragonVoice = GetObjectByTag("IyraurothVoice");
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            AssignCommand(oDragonVoice, ActionStartConversation(oPC, "", FALSE, FALSE));
        }
        //Set Zhents to follow if they are in cave and Iyrauroth lives
        if(PlotLevelGet("IyraurothMerrik") == 2 &&
           PlotLevelGet("IyraurothDead") == 0)
        {
            PlotLevelSet("ZhentsFollowing", 1);
        }
    }
}
