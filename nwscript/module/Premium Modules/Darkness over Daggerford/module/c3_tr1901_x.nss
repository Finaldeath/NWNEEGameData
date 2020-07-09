// the lizardfolk shaman appears when the player takes the knife

#include "hf_in_spawn"
#include "hf_in_plot"
#include "inc_polymorph"

void TakeAction(object oPC)
{
    if(GetObjectSeen(oPC, OBJECT_SELF))
    {
        SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
        if(IsPolymorphed(oPC))
        {
            ClearAllActions();
            ActionStartConversation(oPC);
        }
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
        PlaySound("as_an_lizhiss05");
        ActionSpeakString("Ziss taz kas?");
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 0));
    }
}

void main()
{
    object oPC = GetExitingObject();
    if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
    {
        if (GetIsPC(oPC))
        {
            object oKnife = GetItemPossessedBy(oPC, "ks_lizknife");
            if (GetIsObjectValid(oKnife))
            {
                // if the player doesn't already have the hag quest
                // .. then it can never be given.
                if (PlotLevelGet("ks_greenhag") == 0)
                {
                    PlotLevelSet("ks_greenhag", 3);
                }

                // spawn the shaman by the door
                object oWP = GetWaypointByTag("WP_AR1901_SHAMAN");
                object oShaman = CreateObject(OBJECT_TYPE_CREATURE, "ks_lizshaman", GetLocation(oWP));
                int nCR = SpawnGetPartyCR(oPC, 50);
                SpawnLevelupCreature(oShaman, nCR);
                DelayCommand(4.5, AssignCommand(oShaman, TakeAction(oPC)));

                // this trigger is no longer useful
                SetLocalInt(OBJECT_SELF, "nDone", 1);
            }
        }
    }
}
