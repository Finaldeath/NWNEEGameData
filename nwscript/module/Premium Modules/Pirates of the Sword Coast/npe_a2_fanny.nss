//::///////////////////////////////////////////////
//:: Name npe_a2_fanny
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modified Perception system. Fanny and her
    sisters are looking for the PC, and if they
    catch one, they throw him out.

    Based on Keith's npe_a0_guarddog script.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 21/05
//:://////////////////////////////////////////////
#include "inc_global"
#include "NW_I0_GENERIC"

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oPerc = GetLastPerceived();

    // If I'm in my cutscene state, then abort the script. This variable should
    // be set to TRUE when the cutscene starts, and back to FALSE when it ends.
    if(GetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE) == l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE)
    {
        return;
    }

    int iHeard = GetLastPerceptionHeard();
    int iSeen = GetLastPerceptionSeen();
    int iVanished = GetLastPerceptionVanished();
    int iInaudible = GetLastPerceptionInaudible();

    //SendMessageToPC(GetFirstPC(), "** "+GetName(oSelf)+" Perceived object: " + GetName(oPerc));

    if (GetIsPCNotDM(oPerc) == TRUE)
    {
        if (iSeen == TRUE)
        {
            SetLocalInt(oSelf, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_CHASING);
            ClearAllActions(TRUE);
            // yell at PC
            SpeakString(s_A2_FANNY_SAW_PC);
            // this controls a "chasing" shout in the user defined script
            SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_CALLS, 0);
            // store the last known location of the PC
            SetLocalLocation(oSelf, l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC, GetLocation(oPerc));

            // this is where the magic happens
            SignalEvent(oSelf, EventUserDefined(1));

            //SendMessageToPC(GetFirstPC(), "**Perceived object was Seen");
        }
        // if I'm already chasing someone, then ignore further hearing events
        else if (iHeard == TRUE &&
                 GetLocalInt(oSelf, l_n_A2_WILLIGAN_FANNY_STATE) != l_nv_A2_WILLIGAN_FANNY_STATE_CHASING )
        {
            SetLocalInt(oSelf, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_INVESTIGATING);
            ClearAllActions(TRUE);
            // say something
            SpeakString(s_A2_FANNY_HEARD_PC);
            // store last known location of the PC
            SetLocalLocation(oSelf, l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC, GetLocation(oPerc));

            // this is where the magic happens
            SignalEvent(oSelf, EventUserDefined(1));

            //SendMessageToPC(GetFirstPC(), "**Perceived object was Heard");
        }
    }
    //ExecuteScript("nw_c2_default2", OBJECT_SELF);
}

