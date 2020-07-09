//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "inc_id1_debug"
#include "nw_i0_generic"

void StartCreatureConversation();

void main()
{
    int bFollower = GetLocalInt(OBJECT_SELF, "bFollower");
    if (bFollower == TRUE)
    {
        ExecuteScript("hen_id1_conv", OBJECT_SELF);
    } else
    {
        // * if petrified, jump out
        if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
        {
            return;
        }

        // * If dead, exit directly.
        if (GetIsDead(OBJECT_SELF) == TRUE)
        {
            return;
        }

        // See if what we just 'heard' matches any of our
        // predefined patterns
        int nMatch = GetListenPatternNumber();
        object oShouter = GetLastSpeaker();

        if (nMatch == -1)
        {
            // Not a match -- start an ordinary conversation
            if (GetCommandable(OBJECT_SELF))
            {
                ClearActions(CLEAR_NW_C2_DEFAULT4_29);
                StartCreatureConversation();
            }
            else
            // * July 31 2004
            // * If only charmed then allow conversation
            // * so you can have a better chance of convincing
            // * people of lowering prices
            if (GetHasEffect(EFFECT_TYPE_CHARMED) == TRUE)
            {
                ClearActions(CLEAR_NW_C2_DEFAULT4_29);
                StartCreatureConversation();
            }
        }
        // Respond to shouts from friendly non-PCs only
        else if (GetIsObjectValid(oShouter)
                   && !GetIsPC(oShouter)
                   && GetIsFriend(oShouter))
        {
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
                        if(!GetIsObjectValid(oIntruder))
                        {
                            oIntruder = OBJECT_INVALID;
                        }
                    }
                }
            }

            // Actually respond to the shout
            RespondToShout(oShouter, nMatch, oIntruder);
        }

        // Send the user-defined event if appropriate
        if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
        }
    }
}

void StartCreatureConversation()
{
    object oShouter = GetLastSpeaker();

    if (GetIsPC(oShouter) == TRUE)
    {
        SpeakString("*meow*");

        AddHenchman(oShouter);
        SetAssociateState(NW_ASC_DISTANCE_2_METERS);
        SetLocalInt(OBJECT_SELF, "bFollower", TRUE);
        SetLocalString(OBJECT_SELF, "sConversation", "id1_skrinkles");
    }
}

