#include "hf_in_henchman"
#include "x0_inc_henai"

void main()
{
    if (HenchmanIsDead(OBJECT_SELF))
    {
        return;
    }

    object oShouter = GetLastSpeaker();
    object oMaster = GetMaster();
    object oIntruder;

    int nMatch = GetListenPatternNumber();
    if (nMatch == -1)
    {
        // no pattern matched, so start our default dialog
        if (GetCommandable(OBJECT_SELF) == TRUE &&
            HenchmanIsAbleToSpeak(OBJECT_SELF)  &&
            GetCurrentAction() != ACTION_OPENLOCK)
        {
            string sDialogFile = GetLocalString(OBJECT_SELF, "HF_HENCHMAN_DIALOG");
            ClearAllActions();
            BeginConversation(sDialogFile);
        }
    }
    else
    {
        // listening pattern matched
        if (GetIsObjectValid(oMaster))
        {
            // only listen to our master when we are able to talk
            if (GetIsObjectValid(oShouter) && oMaster == oShouter && HenchmanIsAbleToSpeak(OBJECT_SELF))
            {
                SetCommandable(TRUE);
                bkRespondToHenchmenShout(oShouter, nMatch, oIntruder);
            }
        }
        else if (GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter))
        {
             // we don't have a master, so behave in default way
             object oIntruder = OBJECT_INVALID;

             // Determine the intruder if any
             if(nMatch == 4)
             {
                 oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
             }
             else if (nMatch == 5)
             {
                 oIntruder = GetLastHostileActor(oShouter);
                 if(!GetIsObjectValid(oIntruder))
                 {
                     oIntruder = GetAttemptedAttackTarget();
                     if(!GetIsObjectValid(oIntruder))
                     {
                         oIntruder = GetAttemptedSpellTarget();
                     }
                 }
             }

             // Actually respond to the shout
             RespondToShout(oShouter, nMatch, oIntruder);
         }
    }

    // Signal user-defined event
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
}

