//:://////////////////////////////////////////////////
//:: dla_hrs_onconv
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnConversation event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated On: June 06, 2005

#include "x0_inc_henai"
#include "dla_i0_horse"

//* GeorgZ - Put in a fix for henchmen talking even if they are petrified
int AbleToTalk(object oSelf);

void main()
{
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
        return;
    }

    if(GetIsHenchmanDying() == TRUE)
         return;

    object oShouter = GetLastSpeaker();
    object oMaster = GetMaster();
    int nMatch = GetListenPatternNumber();
    object oIntruder;

    if(nMatch == -1)
    {
        // * September 2 2003
        // * Added the GetIsCommandable check back in so that
        // * Henchman cannot be interrupted when they are walking away
        if(GetCommandable(OBJECT_SELF) == TRUE && AbleToTalk(OBJECT_SELF))
        {
            ClearActions(CLEAR_X0_CH_HEN_CONV_26);
            BeginConversation(GetDialogFileToUse(GetLastSpeaker()));
        }
    }
    else
    {
        // listening pattern matched
        if(GetIsObjectValid(oMaster))
        {
            // we have a master, only listen to them
            // * Nov 2003 - Added an AbleToTalk, so that henchmen
            // * do not respond to orders when 'frozen'
            if(GetIsObjectValid(oShouter) && oMaster == oShouter && AbleToTalk(OBJECT_SELF))
            {
                SetCommandable(TRUE);

                if (nMatch == ASSOCIATE_COMMAND_LEAVEPARTY)
                {
                   if(GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
                       DLA_RemoveHenchman(oMaster, OBJECT_SELF, TRUE, TRUE);
                }
                else

                //Gale 10/06/05: No inventory access if don't have packs
                bkRespondToHenchmenShout(oShouter, nMatch, oIntruder, !DLA_GetHasPacks(OBJECT_SELF));
            }
        }

        // we don't have a master, behave in default way
        else if(GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter))
        {
            object oIntruder = OBJECT_INVALID;

            // Determine the intruder if any
            if(nMatch == 4)
            {
                oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
            }
            else if(nMatch == 5)
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

// Gale 07/06/05 - Changed implementation a little bit.
int AbleToTalk(object oSelf)
{
    return !((GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf)
        || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf)
        || GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf)
        || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)
        || GetHasEffect(EFFECT_TYPE_STUNNED, oSelf)
        || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf)));
}
