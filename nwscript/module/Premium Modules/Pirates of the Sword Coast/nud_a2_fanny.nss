//::///////////////////////////////////////////////
//:: nud_a2_fanny
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    On User Defined Event script for Fanny and
    her sisters.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 21/05
//:://////////////////////////////////////////////
#include "inc_willigan"
#include "nw_i0_generic"

const float fCAUGHT_DISTANCE = 2.5;

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

object GetNearestPCSeen(object oSource = OBJECT_SELF);
object GetNearestPCHeard(object oSource = OBJECT_SELF);

void main()
{
    int nUser = GetUserDefinedEventNumber();

    // This event gets called when Fanny (or a sister) perceives a player.
    // It will keep calling itself (on a delay) until she either catches
    // the PC, or until she can't perceive the pc anymore.
    if(nUser==1)
    {
        int nState = GetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE);

        if(nState == l_nv_A2_WILLIGAN_FANNY_STATE_CHASING ||
           nState == l_nv_A2_WILLIGAN_FANNY_STATE_INVESTIGATING )
        {
            SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
            object oPC = GetNearestPCSeen();
            // can I see a PC right now?
            if(GetIsObjectValid(oPC))
            {
                // store last known location
                SetLocalLocation(OBJECT_SELF, l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC, GetLocation(oPC));

                // if so, how close am I? If I'm close enough, then that PC
                // is "caught". Otherwise keep going for them.
                if(GetDistanceBetween(oPC, OBJECT_SELF) < fCAUGHT_DISTANCE)
                {
                    // caught!!

                    // fail-safe: if this pc has already been caught, do nothing
                    if(!GetLocalInt(oPC, l_n_A2_WILLIGAN_PC_KICKED_OUT))
                    {
                        SpeakString(s_A2_FANNY_CAUGHT_PC);
                        SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE);

                        // If the player has any of Willigan's items, destroy them
                        // and replace them.
                        object oBoots = GetItemPossessedBy(oPC, a2i_Willigan_Boots);
                        object oCutlass = GetItemPossessedBy(oPC, a2i_Willigan_Cutlass);
                        object oGarb = GetItemPossessedBy(oPC, a2i_Willigan_Garb);
                        object oModule = GetModule();

                        // Update plot states and journal entries.
                        if(GetIsObjectValid(oBoots))
                        {
                            DestroyObject(oBoots);
                            // delayed slightly to ensure that the item is
                            // destroyed before creating the new one. this is because
                            // the function ensures we don't create duplicate items
                            SetLocalInt(oModule, "A2_WWBOOT", 30);
                            AddJournalQuestEntry("a2_wwboot", 30, oPC, TRUE, TRUE, TRUE);
                            DelayCommand(0.1, A2WillyChestSpawnItem(a2i_Willigan_Boots));
                        }
                        if(GetIsObjectValid(oCutlass))
                        {
                            DestroyObject(oCutlass);
                            SetLocalInt(oModule, "A2_WWCTLS", 30);
                            AddJournalQuestEntry("a2_wwctls", 30, oPC, TRUE, TRUE, TRUE);
                            DelayCommand(0.1, A2WillyChestSpawnItem(a2i_Willigan_Cutlass));
                        }
                        if(GetIsObjectValid(oGarb))
                        {
                            DestroyObject(oGarb);
                            SetLocalInt(oModule, "A2_WWGARB", 30);
                            AddJournalQuestEntry("a2_wwgarb", 30, oPC, TRUE, TRUE, TRUE);
                            DelayCommand(0.1, A2WillyChestSpawnItem(a2i_Willigan_Garb));
                        }


                        // This controls a condition in the Spindrift Town OnEnter
                        // script, to fire a small little cutscene in that area.
                        // It also prevents other sisters from catching the
                        // same PC at the same time.
                        SetLocalInt(oPC, l_n_A2_WILLIGAN_PC_KICKED_OUT, TRUE);
                        // This is for a conditional on Willigan's dialogue.
                        SetLocalInt(oPC, l_n_A2_WILLIGAN_PC_FAILED, TRUE);

                        SetCutsceneMode(oPC, TRUE);
                        AssignCommand(oPC, ClearAllActions(TRUE));
                        object oWP = GetWaypointByTag(a2w_Willigan_Town_Kicked_Out);
                        DelayCommand(2.5, AssignCommand(oPC, ActionJumpToObject(oWP)));

                        // start walking around again
                        DelayCommand(2.5, SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_WALKING));
                        DelayCommand(3.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
                    }
                }
                else
                {
                    // should we shout at the PC? only shout every few
                    // calls to this event, so we're not continually shouting.
                    int nCalls = GetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_CALLS);
                    nCalls++;
                    if(nCalls > 5)
                    {
                        nCalls = 0;
                    }
                    else if(nCalls == 3)
                    {
                        // I do the speakstring on the third call to the function
                        // Normally the first call will do the perception SpeakString,
                        // so I don't want the two to overlap, but I don't want
                        // to wait too long to start saying something.
                        SpeakString(s_A2_FANNY_CHASING_PC);
                    }
                    SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_CALLS, nCalls);

                    ClearAllActions(TRUE);
                    ActionMoveToObject(oPC, TRUE); // always run if we see someone
                    // signal event on a delay, so we keep chasing PC
                    // I use a fairly small delay here, so that the distance check
                    // is checked often enough.
                    DelayCommand(1.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
                }
            }
            else
            {
                // if I was chasing someone, but I can no longer see them, say something
                if(nState == l_nv_A2_WILLIGAN_FANNY_STATE_CHASING)
                {
                    SpeakString(s_A2_FANNY_SAW_PC_GONE);
                }

                // ok, I can't currently see anyone. Am I close to the last
                // known location of the culprit? If so, give up chasing,
                // otherwise keep moving to that location.
                location lLoc = GetLocalLocation(OBJECT_SELF, l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC);
                if(GetDistanceBetweenLocations(lLoc, GetLocation(OBJECT_SELF)) < 1.5)
                {
                    // ok, give up the chase.
                    // Can I hear anyone? If so, switch state to Investigating,
                    // otherwise go back to walking waypoints
                    object oPC = GetNearestPCHeard();
                    if(GetIsObjectValid(oPC))
                    {
                        // store last known location
                        SetLocalLocation(OBJECT_SELF, l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC, GetLocation(oPC));

                        SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_INVESTIGATING);
                        DelayCommand(2.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
                    }
                    else
                    {
                        // No PC's seen or heard.

                        if(nState == l_nv_A2_WILLIGAN_FANNY_STATE_INVESTIGATING)
                        {
                            // say something if we're investigating but can't
                            // find any pc's.
                            SpeakString(s_A2_FANNY_HEARD_PC_GONE);
                        }

                        SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_WALKING);
                        DelayCommand(2.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
                    }
                }
                else
                {
                    ClearAllActions(TRUE);
                    if(nState == l_nv_A2_WILLIGAN_FANNY_STATE_CHASING)
                    {
                        // if chasing, we run until we hit the last known location
                        ActionMoveToLocation(lLoc, TRUE);
                    }
                    else
                    {
                        // if investigating, we walk
                        ActionMoveToLocation(lLoc, FALSE);
                    }
                    // signal event on a delay, so we keep chasing PC
                    DelayCommand(2.0, SignalEvent(OBJECT_SELF, EventUserDefined(1)));
                }
            }
        }
        else if(nState == l_nv_A2_WILLIGAN_FANNY_STATE_WALKING)
        {
            SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE);
            WalkWayPoints();
        }
    }

/*
// I don't use any of this stuff, but I'll keep it around for reference,
// just in case I decide to use any of it later.
    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

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
*/
}

object GetNearestPCSeen(object oSource = OBJECT_SELF)
{
    int nIndex = 1;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSource, nIndex);
    while(GetIsObjectValid(oPC))
    {
        if(GetObjectSeen(oPC, oSource)) return oPC;
        nIndex++;
        oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSource, nIndex);
    }
    return OBJECT_INVALID;
}

object GetNearestPCHeard(object oSource = OBJECT_SELF)
{
    int nIndex = 1;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSource, nIndex);
    while(GetIsObjectValid(oPC))
    {
        if(GetObjectHeard(oPC, oSource)) return oPC;
        nIndex++;
        oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSource, nIndex);
    }
    return OBJECT_INVALID;
}
