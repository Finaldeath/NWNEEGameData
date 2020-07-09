// the sewer door is locked until jackdaw "opens" it
// the tricky bit is that the "door" is actually an area transition which can't be locked
// so this script prevents access to the sewers until the player has spoken with jackdaw

#include "hf_in_plot"
#include "hf_in_npc"

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        if (PlotLevelGet("Jackdaw") < 1)
        {
            SpeakString("A sign reads: Sewers are closed for repairs. Come back later.");
        }
        else
        {
            object oTarget = GetTransitionTarget(OBJECT_SELF);
            TeleportToObject(oPC, oTarget, TRUE);
        }
    }
}
