//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "ddf_util"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
const string SEENFLAG = "ddf_pc_seen_flag";

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {
        object oPC = GetLastPerceived();
        if(GetIsPC(oPC) == FALSE) return; // we only care about players.
        if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP) return; // don't care about cop players.

        if(GetLocalInt(OBJECT_SELF, "first_time") == FALSE)
        {
            location lSelf = GetLocation(OBJECT_SELF);
            SetLocalLocation(OBJECT_SELF, "start_point", lSelf);
            SetLocalInt(OBJECT_SELF, "fist_time", TRUE);
        }

        // Somebody spotted the players.
        if(GetLastPerceptionSeen())
        {
            if(GetLocalInt(GetModule(), SEENFLAG) == TRUE) return;

            //SetLocalInt(OBJECT_SELF, SEENFLAG, TRUE);
            SetLocalInt(GetModule(), SEENFLAG, TRUE);

            ActionMoveToObject(oPC, TRUE);

            // Pick random line. See: https://docs.google.com/document/d/1d98FBa6amzO6AbpUNjHRmn3rVMS9HeWvmbtTm6aPBHQ/edit#bookmark=id.lijdtwrjojrt
            int iValue = Random(3);
            if(iValue == 0)
            {
                ActionSpeakString("Hey, you aren't supposed to be here!");
            }
            else if(iValue == 1)
            {
                ActionSpeakString("Oi! What are doin' in here?");
            }
            else
            {
                ActionSpeakString("Hey, you!");
            }

            ActionSpeakString("You are not allowed here!");
            //void ActionMovePartyToObject(object oPC, object oTarget, int bFade = FALSE, int bForceAll = FALSE)

            debug("-- villa guard throwing you out.");

            object oTarget = GetObjectByTag("NW_DIVA_TALK");
            //AssignCommand(OBJECT_SELF, ActionMovePartyToObject(oPC, oTarget, TRUE, TRUE));
            ActionDoCommand(DelayCommand(2.0, ActionMovePartyToObject(oPC, oTarget, TRUE, TRUE)));
            //ActionDoCommand(DelayCommand(2.0, ResetPCSeenFlag()));
            //ActionDoCommand(DelayCommand(3.0, SetLocalInt(OBJECT_SELF, SEENFLAG, FALSE)));
            ActionDoCommand(DelayCommand(4.0, ActionMoveToLocation(GetLocalLocation(OBJECT_SELF, "start_point"), TRUE)));
        }
        else if(GetLastPerceptionVanished())
        {
           // SetLocalInt(OBJECT_SELF, SEENFLAG, FALSE);

            ClearAllActions();
            ActionMoveToLocation(GetLocalLocation(OBJECT_SELF, "start_point"), TRUE);
        }
    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {

    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}
