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

#include "x0_i0_enemy"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;



void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {
        int nMatch = GetListenPatternNumber();
        object oShouter = GetLastSpeaker();
        object oIntruder = GetNearestEnemy();

        // If I recognize the shout and the shouter is a valid, friendly NPC
        if(nMatch != -1 && GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter))
        {
            // And the shout is "NW_ATTACK_MY_TARGET"
            if (nMatch == 5)
            {
                if (!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedAttackTarget();

                    if (!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = GetAttemptedSpellTarget();

                        if(!GetIsObjectValid(oIntruder))
                        {
                            oIntruder = OBJECT_INVALID;
                        }
                    }
                }

                // If I can see neither the shouter nor the enemy
                if (GetIsObjectValid(oShouter) && !GetObjectSeen(oIntruder) && !GetObjectSeen(oShouter))
                {
                    // Define the location of the shouter
                    location lShouter = GetLocation(oShouter);

                    // ...stop what I am doing
                    ClearAllActions();

                    // ...and move to that location
                    ActionMoveToLocation (lShouter, TRUE);
                }
                // Otherwise, if I can see the shouter but not the enemy
                else if (GetIsObjectValid(oShouter) && !GetObjectSeen(oIntruder) && GetObjectSeen(oShouter))
                {
                    // Stop what I am doing
                    ClearAllActions();

                    // ...and move towards the shouter
                    ActionMoveToObject(oShouter, TRUE);
                }
            }
        }
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
