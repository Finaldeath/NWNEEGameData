#include "nw_i0_generic"
#include "nw_i0_spells"

// ---------------------------------------------------------------------------
// Utility Functions
// ---------------------------------------------------------------------------

// return a timestamp in hours
int HenchmanGetCurrentTimeStamp()
{
    return ( GetCalendarYear()  * 8064 )
         + ( GetCalendarMonth() * 672 )
         + ( GetCalendarDay()   * 24 )
         + ( GetTimeHour());
}

// count the number of henchmen currently owned by this player
int HenchmanCount(object oPC)
{
    int i = 1;
    object oHenchman = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHenchman))
    {
        oHenchman = GetHenchman(oPC, ++i);
    }
    return(i-1);
}

// returns the size of the henchman's party (not including familiars, etc)
int HenchmanCountParty(object oHench)
{
    int nSize = 1;
    object oMaster = GetMaster(oHench);
    if (GetIsObjectValid(oMaster))
    {
        nSize += HenchmanCount(oMaster);
    }
    return(nSize);
}

// remove negative effects (there's a similar function in nw_i0_plot)
void HenchmanRemoveEffects(object oTarget)
{
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_ABILITY_DECREASE ||
            nEffectType == EFFECT_TYPE_AC_DECREASE ||
            nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE ||
            nEffectType == EFFECT_TYPE_ATTACK_DECREASE ||
            nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_CURSE ||
            nEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            nEffectType == EFFECT_TYPE_DAMAGE_DECREASE ||
            nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DISEASE ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_NEGATIVELEVEL ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_POISON ||
            nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SKILL_DECREASE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nEffectType == EFFECT_TYPE_STUNNED ||
            nEffectType == EFFECT_TYPE_TURNED)
        {
            DelayCommand(0.1, RemoveEffect(oTarget, eBad));
        }
        eBad = GetNextEffect(oTarget);
    }
}

// remove all uses of a feat for today
// ... after a certain level some feats can't be removed because
// ... they become permanent? Druid Wild Shape?
int HenchmanRemoveFeat(object oHenchman, int nFeat)
{
    int n = 0;
    while (GetHasFeat(nFeat, oHenchman))
    {
        if (++n >= 10)
            return(FALSE);
        DecrementRemainingFeatUses(oHenchman, nFeat);
    }
    return(TRUE);
}

// ---------------------------------------------------------------------------
// Companion Functions
// ---------------------------------------------------------------------------

// can the henchman summon an animal companion?
// .. (only do this if our party is "small" enough)
int HenchmanCanSummonCompanion(object oHenchman)
{
    if (GetHasFeat(FEAT_ANIMAL_COMPANION, oHenchman) &&
        GetLocalObject(oHenchman, "HF_HENCHMAN_COMPANION_OBJ") == OBJECT_INVALID &&
        HenchmanCountParty(oHenchman) <= 2)
    {
        return(TRUE);
    }
    return(FALSE);
}

// valid companions:
// nw_ac_badger, nw_ac_bear, nw_ac_boar, nw_ac_dwlf,
// nw_ac_spid, nw_ac_hawk, nw_ac_pant, nw_ac_wolf, x0_ac_drat0

// druids can summon their animal companion
void HenchmanSummonCompanion(object oHenchman)
{
    // get companion blueprint
    string sType = GetLocalString(oHenchman, "HF_HENCHMAN_COMPANION_TAG");
    if (sType == "")
        sType = "nw_ac_wolf";
    int nHD = GetLevelByClass(CLASS_TYPE_RANGER, oHenchman)-5;
    if (nHD < 0) nHD = 0;
    nHD += GetLevelByClass(CLASS_TYPE_DRUID, oHenchman);
    if (nHD == 0)
        return;
    else if (nHD < 10)
        sType = sType + "0" + IntToString(nHD);
    else
        sType = sType + IntToString(nHD);

    // summon the companion and add it as a henchman
    DecrementRemainingFeatUses(oHenchman, FEAT_ANIMAL_COMPANION);
    object oFam = CreateObject(OBJECT_TYPE_CREATURE, sType, GetLocation(OBJECT_SELF), FALSE);
    SetName(oFam, GetName(oHenchman) + "'s Animal Companion");
    SetLocalObject(oHenchman, "HF_HENCHMAN_COMPANION_OBJ", oFam);
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oFam));
    SetMaxHenchmen(GetMaxHenchmen() + 1);
    AddHenchman(oHenchman, oFam);
    SetMaxHenchmen(GetMaxHenchmen() - 1);
}

// can the henchman summon a familiar?
int HenchmanCanSummonFamiliar(object oHenchman)
{
    if (GetHasFeat(FEAT_SUMMON_FAMILIAR, oHenchman) &&
        GetLocalObject(oHenchman, "HF_HENCHMAN_FAMILIAR_OBJ") == OBJECT_INVALID)
    {
        return(TRUE);
    }
    return(FALSE);
}

// valid familiars:
// nw_fm_bat, nw_fm_crag, nw_fm_hell, nw_fm_imp, nw_fm_fire, nw_fm_ice,
// nw_fm_pixi, nw_fm_rave, x0_fm_fdrg0, x0_fm_pdrg0, x2_fm_eye0

// wizards can summon their familiars
void HenchmanSummonFamiliar(object oHenchman)
{
    // get companion blueprint
    string sType = GetLocalString(oHenchman, "HF_HENCHMAN_FAMILIAR_TAG");
    if (sType == "")
        sType = "nw_fm_bat";
    int nHD = GetLevelByClass(CLASS_TYPE_WIZARD, oHenchman) + GetLevelByClass(CLASS_TYPE_SORCERER, oHenchman);
    if (nHD == 0)
        return;
    else if (nHD < 10)
        sType = sType + "0" + IntToString(nHD);
    else
        sType = sType + IntToString(nHD);

    // summon the companion and add it as a henchman
    DecrementRemainingFeatUses(oHenchman, FEAT_SUMMON_FAMILIAR);
    object oFam = CreateObject(OBJECT_TYPE_CREATURE, sType, GetLocation(OBJECT_SELF), FALSE);
    SetName(oFam, GetName(oHenchman) + "'s Familiar");
    SetLocalObject(oHenchman, "HF_HENCHMAN_FAMILIAR_OBJ", oFam);
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oFam));
    SetMaxHenchmen(GetMaxHenchmen() + 1);
    AddHenchman(oHenchman, oFam);
    SetMaxHenchmen(GetMaxHenchmen() - 1);
}

// remove all the summoned companions from the henchman
void HenchmanRemoveCompanions(object oHenchman, object oPC)
{
    object oComp = GetLocalObject(oHenchman, "HF_HENCHMAN_COMPANION_OBJ");
    if (GetIsObjectValid(oComp))
    {
        location lLoc = GetLocation(oComp);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
        RemoveHenchman(oPC, oComp);
        DestroyObject(oComp);
        DeleteLocalObject(oHenchman, "HF_HENCHMAN_COMPANION_OBJ");
    }
    object oFam = GetLocalObject(oHenchman, "HF_HENCHMAN_FAMILIAR_OBJ");
    if (GetIsObjectValid(oFam))
    {
        location lLoc = GetLocation(oFam);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
        RemoveHenchman(oPC, oFam);
        DestroyObject(oFam);
        DeleteLocalObject(oHenchman, "HF_HENCHMAN_FAMILIAR_OBJ");
    }
}

// ---------------------------------------------------------------------------
// Query Functions
// ---------------------------------------------------------------------------

// henchmen can be hired if they have no masters
int HenchmanIsAvailable(object oHenchman, object oPC)
{
    return(GetMaster(oHenchman) == OBJECT_INVALID);
}

// is this henchman working for this player?
int HenchmanIsMine(object oHenchman, object oPC)
{
    return(GetMaster(oHenchman) == oPC);
}

// is this henchman dead?
int HenchmanIsDead(object oHenchman)
{
    return(GetAssociateState(NW_ASC_MODE_DYING, oHenchman));
}

// can this henchman talk?
int HenchmanIsAbleToSpeak(object oSelf)
{
   if (GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf) || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf)  ||
       GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf)  || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)   ||
       GetHasEffect(EFFECT_TYPE_STUNNED, oSelf)  || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf) ||
       GetHasEffect(EFFECT_TYPE_SLEEP, oSelf)    || HenchmanIsDead(oSelf))
    {
        return FALSE;
    }
   return TRUE;
}

// have we joined with this henchman in the past
int HenchmanKnowsPC(object oHenchman, object oPC)
{
    return(GetLocalInt(oHenchman, "HF_HENCHMAN_KNOWS_"+GetTag(oPC)));
}

// can the player hire this henchman?
int HenchmanCanHire(object oHenchman, object oPC)
{
    int nCount = HenchmanCount(oPC);
    int nMax = GetLocalInt(GetModule(), "HF_HENCHMAN_MAX");
    if (nMax > 0)
    {
        if (nCount >= nMax)
        {
            return(FALSE);
        }
    }
    return (nCount < GetMaxHenchmen());
}

// passive henchmen do not fight (but can talk and follow)
int HenchmanIsPassive(object oHenchman)
{
    return(GetLocalInt(OBJECT_SELF, "HF_HENCHMAN_PASSIVE"));
}

// ---------------------------------------------------------------------------
// Rest Functions
// ---------------------------------------------------------------------------

// is this henchman tired?
int HenchmanIsTired(object oHenchman)
{
    int nCounter = GetLocalInt(oHenchman, "HF_HENCHMAN_REST_COUNTER");
    if (nCounter == 0)
    {
        nCounter = HenchmanGetCurrentTimeStamp();
        SetLocalInt(oHenchman, "HF_HENCHMAN_REST_COUNTER", nCounter);
    }
    return (HenchmanGetCurrentTimeStamp() - nCounter >= 36);
}

// make a henchman tired for a certain period of time
// .. we're using the heartbeat duration to prevent player from dispeling tiredness
void HenchmanSetTired(object oHenchman, float fDur=6.0)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_STRENGTH, 1), oHenchman, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_DEXTERITY, 1), oHenchman, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1), oHenchman, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_WISDOM, 1), oHenchman, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_CHARISMA, 1), oHenchman, fDur);
}

// call this function after a henchman has finished resting
void HenchmanRest(object oHenchman)
{
    int nCounter = HenchmanGetCurrentTimeStamp();
    SetLocalInt(oHenchman, "HF_HENCHMAN_REST_COUNTER", nCounter);
    object oPC = GetMaster(oHenchman);
    HenchmanRemoveCompanions(oHenchman, oPC);
}

// ---------------------------------------------------------------------------
// Story Functions
// ---------------------------------------------------------------------------

// are we ready to tell a story? (queried from dialog file)
int HenchmanStoryReady(object oHenchman, int nStory)
{
    int nCur = GetLocalInt(oHenchman, "HF_HENCHMAN_STORY_NUM");
    int nMax = GetLocalInt(oHenchman, "HF_HENCHMAN_STORY_MAX");
    if (nStory == nCur)
    {
        if (nMax >= nCur)
        {
            return(TRUE);
        }
    }
    return(FALSE);
}

// make the next story available (called on henchman levelup)
void HenchmanStoryNext(object oHenchman)
{
    int nMax = GetLocalInt(oHenchman, "HF_HENCHMAN_STORY_MAX");
    SetLocalInt(oHenchman, "HF_HENCHMAN_STORY_MAX", ++nMax);
}

// finished telling the current story (called from dialog file)
void HenchmanStoryDone(object oHenchman)
{
    int nStory = GetLocalInt(oHenchman, "HF_HENCHMAN_STORY_NUM");
    SetLocalInt(oHenchman, "HF_HENCHMAN_STORY_NUM", ++nStory);
}

// initialize story variables if not already done (called on hire)
void HenchmanStoryInit(object oHenchman)
{
    int nStory = GetLocalInt(oHenchman, "HF_HENCHMAN_STORY_NUM");
    if (nStory == 0)
    {
        SetLocalInt(oHenchman, "HF_HENCHMAN_STORY_MAX", 1);
        SetLocalInt(oHenchman, "HF_HENCHMAN_STORY_NUM", 1);
    }
}

// ---------------------------------------------------------------------------
// Banter Functions
// ---------------------------------------------------------------------------

// is it time to banter?
int HenchmanBanterReady(object oHenchman, int nBanter)
{
    return(GetLocalInt(oHenchman, "HF_HENCHMAN_BANTER") == nBanter);
}

// start bantering with your master
void HenchmanBanter(object oHenchman, int nBanter)
{
    object oPC = GetMaster(oHenchman);
    SetLocalInt(oHenchman, "HF_HENCHMAN_BANTER", nBanter);
    AssignCommand(oHenchman, ClearAllActions());
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oHenchman, JumpToObject(oPC));
    AssignCommand(oHenchman, DelayCommand(0.1, ActionStartConversation(oPC)));
}

// finished with the bantering
void HenchmanBanterDone(object oHenchman)
{
    SetLocalInt(oHenchman, "HF_HENCHMAN_BANTER", 0);
}

// ---------------------------------------------------------------------------
// Level-up Functions
// ---------------------------------------------------------------------------

// the henchman level functions in x0_i0_henchman are so messed-up!!!
// * 0 = Balance all classes equally (if you have more than one class)
// * 1 = First Class: only take levels in your second class
// * 2 = Second Class: only take levels in your first class

void HenchmanLevelUp(object oHenchman, object oPC)
{
    int nClass1 = GetClassByPosition(1, oHenchman);
    int nClass2 = GetClassByPosition(2, oHenchman);
    int nLevel1 = GetLevelByClass(nClass1, oHenchman);
    int nLevel2 = GetLevelByClass(nClass2, oHenchman);
    int nClassToLevelUp;
    int nLevelGain;

    // have I reached my maximum level?
    int nMax = GetLocalInt(oHenchman, "HF_HENCHMAN_LIMIT_LEVELUP");
    if (nMax > 0 && (nLevel1+nLevel2) >= nMax)
    {
        return;
    }

    // would this make me higher level than the player?
    nLevelGain = GetHitDice(oPC) - (nLevel1+nLevel2) - 1;
    if (nLevelGain <= 0)
    {
        return;
    }

    // which class should I level-up?
    if (nClass2 == CLASS_TYPE_INVALID)
    {
        nClassToLevelUp = nClass1;
    }
    else
    {
        // which class?
        int nRule = GetLocalInt(oHenchman, "X0_L_LEVELRULES");
        if (nRule == 0)
        {
            // try to balance first and second classes
            if (nLevel1 > nLevel2)
                nClassToLevelUp = nClass2;
            else
                nClassToLevelUp = nClass1;
        }
        if (nRule == 1)
        {
            // only level in first class
            nClassToLevelUp = nClass1;
        }
        if (nRule == 2)
        {
            // only level in second class
            nClassToLevelUp = nClass2;
        }
    }

    // level up the chosen class
    int i;
    for (i=1; i<=nLevelGain; i++)
    {
        if (!LevelUpHenchman(oHenchman, nClassToLevelUp, FALSE))
        {
            SendMessageToPC(GetFirstPC(), "ERROR: Level Up Failed For "
                                      + GetName(oHenchman)
                                      + " in class "
                                      + IntToString(nClassToLevelUp));
            break;
        }
    }

    // make the next story node available
    HenchmanStoryNext(oHenchman);
}

// ---------------------------------------------------------------------------
// Hiring and Firing Functions
// ---------------------------------------------------------------------------

// define a henchman's home location (defaults to first hiring location)
void HenchmanSetHome(object oHenchman, location lHome)
{
    SetLocalLocation(oHenchman, "HF_HENCHMAN_HOME_LOC", lHome);
    SetLocalLocation(oHenchman, "X0_RESPAWN_LOC", lHome);
    SetLocalLocation(oHenchman, "NW_ASSOCIATE_START", lHome);
    SetLocalInt(oHenchman, "HF_HENCHMAN_HOME_DEFINED", 1);
}

// send a henchman home (he should be fired first)
void HenchmanGoHome(object oHenchman)
{
    location lHome = GetLocalLocation(oHenchman, "HF_HENCHMAN_HOME_LOC");
    location lCur  = GetLocation(oHenchman);
    float fDist = GetDistanceBetweenLocations(lHome, lCur);
    if (fDist > 10.0 || fDist < 0.0)
    {
        AssignCommand(oHenchman, ClearAllActions());
        AssignCommand(oHenchman, JumpToLocation(lHome));
        DelayCommand(1.0, HenchmanGoHome(oHenchman));
    }
}

// hire a henchman
void HenchmanHire(object oHenchman, object oPC)
{
    // set the maximum number of henchmen
    int nMax = GetLocalInt(GetModule(), "HF_HENCHMEN_MAX");
    if (nMax > 0)
    {
        SetMaxHenchmen(nMax);
    }

    // can any more henchmen be hired by this player?
    if (!HenchmanCanHire(oHenchman, oPC))
    {
        return;
    }

    // remember that we've met the PC and heal up (once only)
    if (GetLocalInt(oHenchman, "HF_HENCHMAN_KNOWS_"+GetTag(oPC)) == 0)
    {
        SetLocalInt(oHenchman, "HF_HENCHMAN_KNOWS_"+GetTag(oPC), 1);
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        int nHP = GetMaxHitPoints() - GetCurrentHitPoints();
        if (nHP > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_L), OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHP), OBJECT_SELF);
        }
        ForceRest(oHenchman);
    }

    // remember where our home location is
    if (GetLocalInt(oHenchman, "HF_HENCHMAN_HOME_DEFINED") == 0)
    {
        HenchmanSetHome(oHenchman, GetLocation(OBJECT_SELF));
    }

    // setup default henchman modes
    SetAssociateListenPatterns(oHenchman);
    SetLocalInt(oHenchman, "NW_COM_MODE_COMBAT", ASSOCIATE_COMMAND_ATTACKNEAREST);
    SetLocalInt(oHenchman, "NW_COM_MODE_MOVEMENT", ASSOCIATE_COMMAND_FOLLOWMASTER);

    // make sure henchman is not immortal
    SetImmortal(oHenchman, FALSE);
    SetPlotFlag(oHenchman, FALSE);

    // hire the henchman
    SetLocalObject(oHenchman, "HF_HENCHMAN_LAST_MASTER", oPC);
    AddHenchman(oPC, oHenchman);
    if (GetLocalInt(oHenchman, "HF_HENCHMAN_LEVELUP") >= 0)
    {
        HenchmanLevelUp(oHenchman, oPC);
    }

    // prime our first story node (does nothing if already primed)
    HenchmanStoryInit(oHenchman);
}

// fire a henchman
void HenchmanFire(object oHenchman, object oPC)
{
    DeleteLocalObject(oHenchman, "HF_HENCHMAN_LAST_MASTER");
    SetActionMode(oHenchman, ACTION_MODE_STEALTH, FALSE);
    AssignCommand(oHenchman, ClearAllActions());
    RemoveHenchman(oPC, oHenchman);
}

// ---------------------------------------------------------------------------
// Death Functions
// ---------------------------------------------------------------------------

// create or destroy a tombstone map note
void HenchmanTombstone(object oHenchman, int nState)
{
    if (nState == TRUE)
    {
        object oMarker = CreateObject(OBJECT_TYPE_WAYPOINT, "hf_tombstone", GetLocation(oHenchman));
        SetLocalObject(oHenchman, "HF_HENCHMAN_TOMBSTONE", oMarker);
    }
    else
    {
        object oMarker = GetLocalObject(oHenchman, "HF_HENCHMAN_TOMBSTONE");
        DeleteLocalObject(oHenchman, "HF_HENCHMAN_TOMBSTONE");
        SetMapPinEnabled(oMarker, FALSE);
        DestroyObject(oMarker);
    }
}

// henchman raise event
void HenchmanRaise(object oHench, object oPC)
{
    // raise from dead
    SetCommandable(TRUE, oHench);
    AssignCommand(oHench, ClearAllActions());
    AssignCommand(oHench, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 6.0));
    SetAssociateState(NW_ASC_MODE_DYING, FALSE, oHench);
    SetPlotFlag(oHench, FALSE);
    SetAssociateState(NW_ASC_IS_BUSY, FALSE, oHench);

    // make sure we have at least 5 hit points when we get up
    if (GetCurrentHitPoints(oHench) < 5)
    {
        int nHits = GetCurrentHitPoints(oHench);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5-nHits), oHench);
    }

    // remove any tombstones
    HenchmanTombstone(oHench, FALSE);

    // reset henchie state
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE, oHench);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND, FALSE, oHench);

    // automatically re-hire
    if (GetIsObjectValid(oPC))
    {
        ClearPersonalReputation(oPC, oHench);
        if (GetLocalObject(oHench, "HF_HENCHMAN_LAST_MASTER") == oPC)
        {
            if (GetMaster(oHench) != oPC)
            {
                if (!GetIsDead(oPC))
                {
                    HenchmanHire(oHench, oPC);
                }
            }
        }
    }
}

// henchman death event
void HenchmanDeath(object oHenchman)
{
    object oPC = GetMaster(oHenchman);

    // remove invisibility and negative effects
    SetActionMode(oHenchman, ACTION_MODE_STEALTH, FALSE);
    RemoveSpellEffects(SPELL_INVISIBILITY, oHenchman, oHenchman);
    RemoveSpellEffects(SPELL_IMPROVED_INVISIBILITY, oHenchman, oHenchman);
    RemoveSpellEffects(SPELL_SANCTUARY, oHenchman, oHenchman);
    RemoveSpellEffects(SPELL_ETHEREALNESS, oHenchman, oHenchman);
    HenchmanRemoveEffects(oHenchman);

    // familiars and companions vanish when the henchman dies
    HenchmanRemoveCompanions(oHenchman, oPC);

    // pretend that we've rested, otherwise we'll go into an endless death loop
    HenchmanRest(oHenchman);

    // set dying mode on
    SetAssociateState(NW_ASC_MODE_DYING, TRUE, oHenchman);
    SetPlotFlag(oHenchman, TRUE);
    SetAssociateState(NW_ASC_IS_BUSY, TRUE, oHenchman);
    AssignCommand(oHenchman, SetIsDestroyable(FALSE, TRUE, TRUE));
    AssignCommand(oHenchman, ClearAllActions(TRUE));

    // resurrect henchman to 1 HP but pretend to be dead
    if (GetAssociateType(oHenchman) == ASSOCIATE_TYPE_HENCHMAN)
    {
        HenchmanTombstone(oHenchman, TRUE);
        RemoveHenchman(oPC, oHenchman);
        DelayCommand(0.1, AddHenchman(oPC, oHenchman));
    }
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oHenchman));
    DelayCommand(0.3, AssignCommand(oHenchman, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 6500000000.0)));
    DelayCommand(0.4, SetCommandable(FALSE, oHenchman));
}
