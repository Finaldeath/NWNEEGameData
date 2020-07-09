//:://////////////////////////////////////////////////
//:: X0_CH_HEN_CONV
/*

  OnDialogue event handler for henchmen/associates.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 01/05/2003
//:://////////////////////////////////////////////////


#include "x0_inc_henai"
#include "x0_i0_henchman"
#include "inc_id1_utility"

void bkRespondToHenchmenShout2(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID, int nBanInventory=FALSE);

//* GeorgZ - Put in a fix for henchmen talking even if they are petrified
int AbleToTalk(object oSelf)
{
   if (GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf) || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf) ||
        GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf) || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)   ||
        GetHasEffect(EFFECT_TYPE_STUNNED, oSelf) || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf))
    {
        return FALSE;
    }

   return TRUE;
}




void main()
{
    object oShouter = GetLastSpeaker();

    if (GetIsHenchmanDying() == TRUE)
    {
        return;
    }

    object oMaster = GetMaster();
    int nMatch = GetListenPatternNumber();

    object oIntruder;

    if (nMatch == -1)
    {
        // * September 2 2003
        // * Added the GetIsCommandable check back in so that
        // * Henchman cannot be interrupted when they are walking away
        if (GetCommandable(OBJECT_SELF) == TRUE && AbleToTalk(OBJECT_SELF) && (GetCurrentAction() != ACTION_OPENLOCK))
        {
            ClearActions(CLEAR_X0_CH_HEN_CONV_26);

            string sConversation = GetLocalString(OBJECT_SELF, "sConversation");
            BeginConversation(sConversation);
        }
    } else
    {
        // listening pattern matched
        if (GetIsObjectValid(oMaster))
        {
            // we have a master, only listen to them
            // * Nov 2003 - Added an AbleToTalk, so that henchmen
            // * do not respond to orders when 'frozen'
            if (GetIsObjectValid(oShouter) && oMaster == oShouter && AbleToTalk(OBJECT_SELF))
            {
                SetCommandable(TRUE);
                bkRespondToHenchmenShout2(oShouter, nMatch, oIntruder);
            }
        } else if (GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter)) // we don't have a master, behave in default way
        {
             object oIntruder = OBJECT_INVALID;

             // Determine the intruder if any
             if(nMatch == 4)
             {
                oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
             } else if (nMatch == 5)
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

// Handles responses to henchmen commands, including both radial
// menu and voice commands.
void bkRespondToHenchmenShout2(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID, int nBanInventory=FALSE)
{

    // * if petrified, jump out
    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // * MODIFIED February 19 2003
    // * Do not respond to shouts if in dying mode
    if (GetIsHenchmanDying() == TRUE)
        return;

    // Do not respond to shouts if you've surrendered.
/*    int iSurrendered = GetLocalInt(OBJECT_SELF,"Generic_Surrender");
    if (iSurrendered)
        return;*/
    if(GetLocalInt(OBJECT_SELF,"Generic_Surrender")) return;

    object oLastObject;
    object oTrap;
    object oMaster;
    object oTarget;

    //ASSOCIATE SHOUT RESPONSES
    switch(nShoutIndex)
    {

    // * toggle search mode for henchmen
    case ASSOCIATE_COMMAND_TOGGLESEARCH:
    {
        if (GetActionMode(OBJECT_SELF, ACTION_MODE_DETECT) == TRUE)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
        }
        else
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
        }
        break;
    }
    // * toggle stealth mode for henchmen
    case ASSOCIATE_COMMAND_TOGGLESTEALTH:
    {
        //SpeakString(" toggle stealth");
        if (GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
        }
        else
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
        }
        break;
    }
    // * June 2003: Stop spellcasting
    case ASSOCIATE_COMMAND_TOGGLECASTING:
    {
        if (GetLocalInt(OBJECT_SELF, "X2_L_STOPCASTING") == 10)
        {
           // SpeakString("Was in no casting mode. Switching to cast mode");
            SetLocalInt(OBJECT_SELF, "X2_L_STOPCASTING", 0);
            VoiceCanDo();
        }
        else
        if (GetLocalInt(OBJECT_SELF, "X2_L_STOPCASTING") == 0)
        {
         //   SpeakString("Was in casting mode. Switching to NO cast mode");
            SetLocalInt(OBJECT_SELF, "X2_L_STOPCASTING", 10);
            VoiceCanDo();
        }
      break;
    }
    case ASSOCIATE_COMMAND_INVENTORY:
        // feb 18. You are now allowed to access inventory during combat.
         if (nBanInventory == TRUE)
        {
            SpeakStringByStrRef(9066);
        }
        else
        {
            // * cannot modify disabled equipment
            if (GetLocalInt(OBJECT_SELF, "X2_JUST_A_DISABLEEQUIP") == FALSE)
            {
                OpenInventory(OBJECT_SELF, oShouter);
            }
            else
            {
                // * feedback as to why
                SendMessageToPCByStrRef(GetMaster(), 100895);
            }

        }

        break;

    case ASSOCIATE_COMMAND_PICKLOCK:
        bkManualPickNearestLock();
        break;

    case ASSOCIATE_COMMAND_DISARMTRAP: // Disarm trap
        bkAttemptToDisarmTrap(GetNearestTrapToObject(GetMaster()), TRUE);
        break;

    case ASSOCIATE_COMMAND_ATTACKNEAREST:
        ResetHenchmenState();
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        DetermineCombatRound();

        // * bonus feature. If master is attacking a door or container, issues VWE Attack Nearest
        // * will make henchman join in on the fun
        oTarget = GetAttackTarget(GetMaster());
        if (GetIsObjectValid(oTarget) == TRUE)
        {
            if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE || GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
            {
                ActionAttack(oTarget);
            }
        }
        break;

    case ASSOCIATE_COMMAND_FOLLOWMASTER:
        ResetHenchmenState();
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        DelayCommand(2.5, VoiceCanDo());

        //UseStealthMode();
        //UseDetectMode();
        ActionForceFollowObject(GetMaster(), GetFollowDistance());
        SetAssociateState(NW_ASC_IS_BUSY);
        DelayCommand(5.0, SetAssociateState(NW_ASC_IS_BUSY, FALSE));
        break;

    case ASSOCIATE_COMMAND_GUARDMASTER:
    {
        ResetHenchmenState();
        //DelayCommand(2.5, VoiceCannotDo());

        //Companions will only attack the Masters Last Attacker
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE);
        object oLastAttacker = GetLastHostileActor(GetMaster());
        // * for some reason this is too often invalid. still the routine
        // * works corrrectly
        SetLocalInt(OBJECT_SELF, "X0_BATTLEJOINEDMASTER", TRUE);
        HenchmenCombatRound(oLastAttacker);
        break;
    }
    case ASSOCIATE_COMMAND_HEALMASTER:
        //Ignore current healing settings and heal me now

        ResetHenchmenState();
        //SetCommandable(TRUE);
        if(TalentCureCondition())
        {
            DelayCommand(2.0, VoiceCanDo());
            return;
        }

        if(TalentHeal(TRUE, GetMaster()))
        {
            DelayCommand(2.0, VoiceCanDo());
            return;
        }

        DelayCommand(2.5, VoiceCannotDo());
        break;

    case ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK:
        //Check local for re-try locked doors
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND)
           && GetAssociateState(NW_ASC_RETRY_OPEN_LOCKS))
           {
            oLastObject = GetLockedObject(GetMaster());
            bkAttemptToOpenLock(oLastObject);
        }
        break;


    case ASSOCIATE_COMMAND_STANDGROUND:
        //No longer follow the master or guard him
        SetAssociateState(NW_ASC_MODE_STAND_GROUND);
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
        DelayCommand(2.0, VoiceCanDo());
        ActionAttack(OBJECT_INVALID);
        ClearActions(CLEAR_X0_INC_HENAI_RespondToShout1);
        break;



        // ***********************************
        // * AUTOMATIC SHOUTS - not player
        // *   initiated
        // ***********************************
    case ASSOCIATE_COMMAND_MASTERSAWTRAP:
        if(!GetIsInCombat())
        {
            if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                oTrap = GetLastTrapDetected(GetMaster());
                bkAttemptToDisarmTrap(oTrap);
            }
        }
        break;

    case ASSOCIATE_COMMAND_MASTERUNDERATTACK:
        // Just go to henchman combat round
        //SpeakString("here 728");

        // * July 15, 2003: Make this only happen if not
        // * in combat, otherwise the henchman will
        // * ping pong between targets
        if (!GetIsInCombat(OBJECT_SELF))
            HenchmenCombatRound();
        break;

    case ASSOCIATE_COMMAND_MASTERATTACKEDOTHER:

        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
        {
            if(!GetAssociateState(NW_ASC_MODE_DEFEND_MASTER))
            {
                if(!GetIsInCombat(OBJECT_SELF))
                {
                    //SpeakString("here 737");
                    object oAttack = GetAttackTarget(GetMaster());
                    // April 2003: If my master can see the enemy, then I can too.
                    if(GetIsObjectValid(oAttack) && GetObjectSeen(oAttack, GetMaster()))
                    {
                        ClearActions(CLEAR_X0_INC_HENAI_RespondToShout2);
                        HenchmenCombatRound(oAttack);
                    }
                }
            }
        }
        break;

    case ASSOCIATE_COMMAND_MASTERGOINGTOBEATTACKED:
        if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
        {
            if(!GetIsInCombat(OBJECT_SELF))
            {   // SpeakString("here 753");
                object oAttacker = GetGoingToBeAttackedBy(GetMaster());
                // April 2003: If my master can see the enemy, then I can too.
                // Potential Side effect : Henchmen may run
                // to stupid places, trying to get an enemy
                if(GetIsObjectValid(oAttacker) && GetObjectSeen(oAttacker, GetMaster()))
                {
                   // SpeakString("Defending Master");
                    ClearActions(CLEAR_X0_INC_HENAI_RespondToShout3);
                    ActionMoveToObject(oAttacker, TRUE, 7.0);
                    HenchmenCombatRound(oAttacker);

                }
            }
        }
        break;

    case ASSOCIATE_COMMAND_LEAVEPARTY:
        {
            oMaster = GetMaster();

            string sTag = GetTag(GetArea(oMaster));
            // * henchman cannot be kicked out in the reaper realm
            // * Followers can never be kicked out
            if (sTag == "GatesofCania" || GetIsFollower(OBJECT_SELF) == TRUE)
                return;

            if(GetIsObjectValid(oMaster))
            {
                ClearActions(CLEAR_X0_INC_HENAI_RespondToShout4);
                if(GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
                {
//                    FireHenchman(GetMaster(), OBJECT_SELF);

                    string sConversation = GetLocalString(OBJECT_SELF, "sConversation");
                    if (sConversation == "id1_plotgiver")
                    {
                        string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
                        object oDungeon = GetCurrentDungeon();
                        SetLocalInt(oDungeon, "b" + sVariable + "Gone", FALSE);
                    }

                    RemoveHenchman(oMaster);
                    DestroyObject(OBJECT_SELF);
                }
            }
            break;
        }
    }

}

