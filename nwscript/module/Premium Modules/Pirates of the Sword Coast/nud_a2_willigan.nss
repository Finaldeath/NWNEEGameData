//::///////////////////////////////////////////////
//:: nud_a2_willigan
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    User defined script for Whipped Willigan
    (act 2)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser==1)
    {
        // When Willigan escapes, he's jumped outside his manor. He needs
        // to talk to the player. This is a fail-safe method to make sure
        // he inits with the player - just in case the player hasn't made
        // the transition yet, or in a multiplayer game where the player
        // loses connection during the transition, or whatever.
        // Once the line of dialogue fires, the
        // plot variable is changed right away and we know that the dialogue
        // has fired properly.

        if(GetLocalInt(GetModule(), "A2_WHIPD") < 50)
        {
            // double-check that we're in the right area, just in case
            // Willigan hasn't fully transitioned to the town area yet
            if(GetTag(GetArea(OBJECT_SELF)) == "SpindriftIslandSpindrift")
            {
                // ok, find a nearby PC and try to init - don't init if the PC
                // is too far away
                object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
                if( GetIsObjectValid(oPC) &&
                    (GetDistanceBetween(OBJECT_SELF, oPC) < 5.0))
                {
                    ActionStartConversation(oPC);
                }
            }
            DelayCommand(1.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
        }
    }
}
