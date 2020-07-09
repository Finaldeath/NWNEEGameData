// B W-Husey
// October 2005
// Light a torch if you have a tinderbox


#include "nw_i0_tool"

void main()
{
    object oPC = GetLastUsedBy();
    int nState = GetLocalInt(OBJECT_SELF,"nState"); //where 1 = off
    if (nState = 1)
    {
        if(HasItem(oPC, "Tinderbox")) //use the Tag
        {
            // debug line *****************
//            SendMessageToPC(oPC,"Found tnderbox");
            FloatingTextStringOnCreature("You light the torch using your tinderbox", oPC, FALSE);
            ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            SetLocalInt(OBJECT_SELF,"nState",0);
        }
        else
        {
            // debug line *****************
//            SendMessageToPC(oPC,"No tnderbox");
        SpeakString("You need flint and tinder to light a torch");
        }
    }
    else
    {
            // debug line *****************
//            SendMessageToPC(oPC,"Torch is on");
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF,"nState",1);
    }
}


