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
#include "ddf_util"

void main()
{
    string sVar = "ddf_guard_stop_teddy_attack";

    // If the party is Law Enforcement
    // And it is Teddy calling for help (assumed because the party is attacking him)
    // the guards will not rush to his help.
    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP)
    {
        object oShouter = GetLastSpeaker();
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
        if(oShouter == oTeddy)
        {
            int nMatch = GetListenPatternNumber();

            // When teddy dies, he does "NW_I_AM_DEAD" which is pattern 3.
            // "NW_I_WAS_ATTACKED" is 1.
            //debug("-- shout match #:" + IntToString(nMatch));

            if(nMatch != 3)
            {
                // teddy is not deaded. Ignore his shouts
                //ExecuteScript("nw_c2_default4", OBJECT_SELF);
                return;
            }

            // is anyone telling the party/player off?
            // if not, run up and stop the attack?
            // Or do we only do that after the combat?
            if(GetLocalInt(GetModule(), sVar) == TRUE)
            {
                // somebody is already telling the player off.
                //ExecuteScript("nw_c2_default4", OBJECT_SELF);
                return;
            }

            SetLocalInt(GetModule(), sVar, TRUE);

            // Remember my starting position.
            if(GetLocalInt(OBJECT_SELF, "first_time") == FALSE)
            {
                location lSelf = GetLocation(OBJECT_SELF);
                SetLocalLocation(OBJECT_SELF, "start_point", lSelf);
                SetLocalInt(OBJECT_SELF, "fist_time", TRUE);
            }

            object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTeddy);

            if(oTarget == OBJECT_INVALID)
            {
                debug("-- Unable to find closest PC to teddy...");
                //ExecuteScript("nw_c2_default4", OBJECT_SELF);
                return;
            }

            debug("-- guard telling off PC for attacking Teddy....");

            ActionMoveToObject(oTarget, TRUE);
            ActionStartConversation(oTarget, "day3g_001", TRUE);
            ActionDoCommand(SetLocalInt(GetModule(), sVar, FALSE));
            //ActionDoCommand(ActionMoveToLocation(GetLocalLocation(OBJECT_SELF, "start_point"), TRUE));

            return;
        }
    }

    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
