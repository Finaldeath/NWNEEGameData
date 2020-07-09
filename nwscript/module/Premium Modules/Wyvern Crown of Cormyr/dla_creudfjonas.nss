// April 2004
// B W-Husey
// Henchman UDF expanded to add commands
// CREDITS: Open & disarm sections by Rick Burton

// Syrsnein, 26 April 2006: Modified to include an event to start the barrow
//  battlefield escape cutscene.

// Jonas has his own version as he does not listen to shouted commands (in case it inteferes after he switches sides)

#include "X0_i0_equip"
#include "X0_INC_HENAI"
#include "dla_i1_battle"

int CheckSpell(int nSpell, object oMaster);
void CheckForDisabledPartyMembers();

object GetNearestLock(object Center)
    {
    int x=1;
    object Lock = GetNearestObject(OBJECT_TYPE_ALL,Center);
    while (!GetLocked(Lock) && GetIsObjectValid(Lock) && GetDistanceBetween(Lock,Center)<=7.0)
        {
        x++;
        Lock = GetNearestObject(OBJECT_TYPE_ALL,Center,x);
        }
    if (GetLocked(Lock))
        return Lock;
    else
        return OBJECT_INVALID;
    }

void main()
{
    int nEvent = GetUserDefinedEventNumber();
/* removed 29 April 2006, Syrsnein
    if (nEvent == DLA_EVENT_BARROWEXIT)
    {// Do Barrow Exit cutscene for finalle
        ExitBattle();
    }
    else if (nEvent == DLA_EVENT_BARROWEXIT_JONAS)
    {// Do Barrow Exit routine for Jonas (should only be fire on jonas)
        ExitBattleJonas(OBJECT_SELF);
    }
    else if (nEvent == DLA_EVENT_BARROWEXIT_WL)
    {// Do Barrow Exit routine for the WL (should only be fire on the witchlord)
        ExitBattleWL(OBJECT_SELF);
    }
    else
end removal by Syrsnein */

    /*
    if (nEvent == 1004)
    {
        string sArea = GetTag(GetArea(OBJECT_SELF));
        int nMatch = GetListenPatternNumber();
        object oShouter = GetLastSpeaker();
        object oMaster = GetMaster();
        switch (nMatch)
        {
            case 1:    //Open locks "open"
            case 11:
            {
                ClearAllActions();
                object oLock = GetNearestLock(oMaster);
                if (GetIsObjectValid (oLock))
                {
                    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                    ClearAllActions();
                    if (GetLockUnlockDC(oLock)-20 <= GetSkillRank(SKILL_OPEN_LOCK))
                    {
                        PlayVoiceChat(VOICE_CHAT_PICKLOCK);
                        ActionUseSkill (SKILL_OPEN_LOCK,oLock);
                    }
                    else
                    {
                        ActionMoveToObject(oLock,TRUE);
                        PlayVoiceChat(VOICE_CHAT_CUSS);
                    }
                    ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE));
                }
                else
                {
                    PlayVoiceChat(VOICE_CHAT_CANTDO);
                    SpeakString("I don't see any locks near you.");
                }
                break;
            }
            case 2:    //DISARM   "disarm"
            case 12:
            {
                ClearAllActions();
                object oTrap = GetNearestTrapToObject(GetFirstPC());
                if(GetIsObjectValid(oTrap))
                {
                    object oTrapSaved = GetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP");
                    int nTrapDC = GetTrapDisarmDC(oTrap);
                    int nSkill = GetSkillRank(SKILL_DISABLE_TRAP);
                    nSkill = nSkill + 20 - nTrapDC;

                    if(nSkill > 0 && GetSkillRank(SKILL_DISABLE_TRAP) > 0 && GetTrapDisarmable(oTrap))
                    {
                        ClearAllActions();
                        ActionUseSkill(SKILL_DISABLE_TRAP, oTrap);
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE));
                    }
                    else if(oTrap != oTrapSaved && GetSkillRank(SKILL_DISABLE_TRAP) > 0)
                    {
                        PlayVoiceChat(VOICE_CHAT_CANTDO);
                        SetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP", oTrap);
                    }
                }
                break;
            }
            case 3: //FLEE "flee"
            case 13:
            {
                ClearAllActions();
                PlayVoiceChat(VOICE_CHAT_FLEE);
                TalentFlee(GetNearestSeenEnemy());
                DelayCommand(4.0,SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE));
                break;
            }
            case 4:     //COME  "come"
            case 14:
            {
//              if (GetTag(GetArea(OBJECT_SELF))!="Gorge") //not in the gorge due to scripted conversations requiring Erlik as the nearest
//              {
                SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE);
                ClearAllActions();
                PlayVoiceChat(VOICE_CHAT_YES);
                ActionMoveToLocation(GetLocation(oMaster),TRUE);
                ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE));
//              }
                break;
            }
            case 5: //HIDE  "hide"
            case 15:
            {
                ClearAllActions();
                ActionUseSkill(SKILL_HIDE,OBJECT_SELF);
                break;
            }
            case 6:  //SEARCH "search"
            case 16:
            {
                ClearAllActions();
                ActionUseSkill(SKILL_SEARCH,OBJECT_SELF);
                break;
            }
            case 7://combat  "combat"
            case 17:
            {
                ClearAllActions();
                ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE));
                PlayVoiceChat(VOICE_CHAT_BATTLECRY2);
                ActionAttack(GetNearestPerceivedEnemy());
                DetermineCombatRound();
                break;
            }
            case 8:// weapon  "melee"
            case 18:
            {
                ClearAllActions();
                bkEquipMelee(OBJECT_SELF);
                break;
            }
            case 9:// weapon  "ranged"
            case 19:
            {
                ClearAllActions();
                bkEquipRanged(OBJECT_SELF);
                break;
            }
            case 10:// stand ground  "stop"
            case 20:
            {
                ClearAllActions();
                ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE));
                PlayVoiceChat(VOICE_CHAT_YES);
                break;
            }
        }
    }
    */
    if (nEvent == 20000 + ACTION_MODE_STEALTH)
    {
        int bStealth = GetActionMode(GetMaster(), ACTION_MODE_STEALTH);
        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, bStealth);
    }
    else if (nEvent == 20000 + ACTION_MODE_DETECT)
    {
        int bDetect = GetActionMode(GetMaster(), ACTION_MODE_DETECT);
        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, bDetect);
    }
    else if (nEvent == 46500)
    {// *
     // * This event is triggered whenever an NPC or PC in the party
     // * is disabled (or potentially disabled).
     // * This is a migration of a useful heartbeat routine Yaron made
     // * into a less AI extensive route
        CheckForDisabledPartyMembers();
    }
}

int CheckSpell(int nSpell, object oMaster)
{
    if(GetHasSpell(nSpell))
    {
        ClearAllActions();
        ActionCastSpellAtObject(nSpell, oMaster);
        return 1;
    }
    return 0;
}

// Check whether the creature has disabling effects that are magical and therefor and can removed by
// dispel magic spells.
int HasDisablingMagicalEffect(object oCreature)
{
    effect eEff = GetFirstEffect(oCreature);
    while(GetIsEffectValid(eEff))
    {
        if(GetEffectType(eEff) == EFFECT_TYPE_CONFUSED ||
           GetEffectType(eEff) == EFFECT_TYPE_PARALYZE ||
           GetEffectType(eEff) == EFFECT_TYPE_FRIGHTENED ||
           GetEffectType(eEff) == EFFECT_TYPE_DOMINATED ||
           GetEffectType(eEff) == EFFECT_TYPE_DAZED ||
           GetEffectType(eEff) == EFFECT_TYPE_STUNNED)
        {
            if(GetEffectSubType(eEff) == SUBTYPE_MAGICAL)
                return TRUE; // can be dispelled
            else
                return FALSE;
        }
        eEff = GetNextEffect(oCreature);
    }
    return FALSE;
}

// Checks a single creature for disabling effects, trying to remove them if possible.
void CheckCreature(object oCreature)
{
    // First, trying to cast specific-purpose spells and then trying more general spells.
    if(GetHasEffect(EFFECT_TYPE_FRIGHTENED, oCreature))
        if(CheckSpell(SPELL_REMOVE_FEAR, oCreature)) return;
    if(GetHasEffect(EFFECT_TYPE_PARALYZE, oCreature))
        if(CheckSpell(SPELL_REMOVE_PARALYSIS, oCreature)) return;

    if(GetHasEffect(EFFECT_TYPE_CONFUSED, oCreature) ||
       GetHasEffect(EFFECT_TYPE_FRIGHTENED, oCreature) ||
       GetHasEffect(EFFECT_TYPE_PARALYZE, oCreature) ||
       GetHasEffect(EFFECT_TYPE_DOMINATED, oCreature) ||
       GetHasEffect(EFFECT_TYPE_DAZED, oCreature) ||
       GetHasEffect(EFFECT_TYPE_STUNNED, oCreature))
    {
        if(CheckSpell(SPELL_GREATER_RESTORATION, oCreature)) return;
        if(CheckSpell(SPELL_RESTORATION, oCreature)) return;
        if(HasDisablingMagicalEffect(oCreature) &&
            GetLocalInt(OBJECT_SELF, "X2_HENCH_DO_NOT_DISPEL") == 0)
        {
            if(CheckSpell(SPELL_GREATER_DISPELLING, oCreature)) return;
            if(CheckSpell(SPELL_DISPEL_MAGIC, oCreature)) return;
            if(CheckSpell(SPELL_LESSER_DISPEL, oCreature)) return;
        }

    }
}

void CheckForDisabledPartyMembers()
{
    object oMaster = GetMaster(OBJECT_SELF);
    if(oMaster != OBJECT_INVALID)
        CheckCreature(oMaster);
    int i = 1;
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster, i);
    while(oHench != OBJECT_INVALID)
    {
        CheckCreature(oHench);
        i++;
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster, i);
    }
}

