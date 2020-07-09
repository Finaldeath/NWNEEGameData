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

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
        object oWP = GetNearestObjectByTag("wp_ar0800_girl");

        // if not near the shoreside boat, return there after a bit
        // should also prevent her from chasing pc all over
        // if she doesn't catch them after a while to start convo

        if (GetIsObjectValid(oWP)) // in farmlands!
        {
            if ((GetCurrentAction() != ACTION_MOVETOPOINT) &&
                (!IsInConversation(OBJECT_SELF)) &&
                (!GetIsInCombat()))
            {
                float fDist = GetDistanceToObject(oWP);

                if (fDist >= 5.0f)
                {
                    int nTicks = GetLocalInt(OBJECT_SELF, "nTicks");

                    if (nTicks > 3)
                    {
                        ClearAllActions();
                        ActionMoveToObject(oWP);
                        SetLocalInt(OBJECT_SELF, "nTicks", 0);
                    }
                    else
                    {
                        nTicks += 1;
                        SetLocalInt(OBJECT_SELF, "nTicks", nTicks);
                    }
                }
            }
        }
        else
        {
            if (GetLocalInt(OBJECT_SELF, "HF_ARG") == 2) // at bottom of hole
            {
                // if not in convo, let's find a pc and start one

                if ((GetCurrentAction() != ACTION_MOVETOPOINT) &&
                    (GetCurrentAction() != ACTION_DIALOGOBJECT) &&
                    (GetCurrentAction() != ACTION_FOLLOW) &&
                    (!IsInConversation(OBJECT_SELF)) &&
                    (!GetIsInCombat()))
                {
                    object oArea = GetArea(OBJECT_SELF);

                    if (GetLocalInt(oArea, "nTriggered") == 1)
                    {
                        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);

                        if (GetIsObjectValid(oPC))
                        {
                            ActionStartConversation(oPC);
                            SignalEvent(oArea, EventUserDefined(502)); // re-freeze
                        }
                    }
                }
            }
        }
    }
    else if (nUser == EVENT_PERCEIVE) // PERCEIVE
    {
        // first time we see a pc, run to him/her and start convo

        object oPerc = GetLastPerceived();

        if (GetIsPC(oPerc) && (!GetIsEnemy(oPerc)))
        {
            if (GetLocalInt(OBJECT_SELF, "nGaveChase") == 0)
            {
                ActionStartConversation(oPerc);

                SetLocalInt(OBJECT_SELF, "nGaveChase", 1);
            }
        }
    }
    else if(nUser == EVENT_END_COMBAT_ROUND)
    {
        if (GetIsInCombat() && GetPlotFlag() && (GetLocalInt(OBJECT_SELF, "HF_ARG") == 2)) // at bottom of hole)
        {
            ClearAllActions(TRUE);
            SurrenderToEnemies();

            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);

            if (GetIsObjectValid(oPC))
            {
                object oArea = GetArea(OBJECT_SELF);

                ActionStartConversation(oPC);
                SignalEvent(oArea, EventUserDefined(502)); // re-freeze
            }
        }
    }
}


