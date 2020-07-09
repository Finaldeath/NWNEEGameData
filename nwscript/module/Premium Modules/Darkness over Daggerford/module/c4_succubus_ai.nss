/*
The main purpose of this AI is to ensure that the Beholder doesn't
move during combat. This is because he is supposed to 'hang back'
and not risk himself, and because he needs to hold position for the
next cutscene (assuming he survives the battle of course)
*/

#include "hf_in_util"
#include "nw_i0_generic"
#include "x0_i0_spells"
#include "x2_inc_switches"

void PlayRandomTaunt(object oIntruder)
{
    string s;
    int n = d4();
    if      (n == 1) s = "Umgatlik will devour your soul!";
    else if (n == 2) s = "Join us in eternal death!";
    else if (n == 3) s = "Death is your reward!";
    else if (n == 4) s = "Prepare the way for Umgatlik!";
    SpeakString(s, TALKVOLUME_SHOUT);
}

void PlayRandomSound(object oIntruder)
{
    string s;
    int n = d4();
    if      (n == 1) s = "c_succubus_atk1";
    else if (n == 2) s = "c_succubus_atk2";
    else if (n == 3) s = "c_succubus_bat1";
    else if (n == 4) s = "c_succubus_bat2";
    PlaySound(s);
}

// raise a creature from the dead and make it my slave
void RaiseDead(object o)
{
    if (GetLocalInt(o, "UNDEAD") == 0)
    {
        SetLocalInt(o, "UNDEAD", 1);
        object oHide = CreateItemOnObject("nw_it_creitemunh", o);
        AssignCommand(o, ActionEquipItem(oHide, INVENTORY_SLOT_CARMOUR));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE), o);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(3), o);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedDecrease(50), o);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(10), o);
    }
    effect eBeam1 = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam1, o, 0.5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), o);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_FLIES), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(100), o);
    ClearPersonalReputation(OBJECT_SELF, o);
    ClearPersonalReputation(o, OBJECT_SELF);
    ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);

    int i = 1;
    object oWorker = GetObjectInArea("ks_dig_worker", o, i);

    while (GetIsObjectValid(oWorker))
    {
        if(GetLocalInt(oWorker, "UNDEAD") == 1)
        {
            ClearPersonalReputation(oWorker, o);
            ClearPersonalReputation(o ,oWorker);
        }
        oWorker = GetObjectInArea("ks_dig_worker", o, ++i);
    }

    AssignCommand(o, DetermineCombatRound());
}

// look for dead workers to raise as slaves
int ActionRaiseDead()
{
    int nDone = FALSE;
    int i = 1;
    object o = GetNearestObjectByTag("ks_dig_worker", OBJECT_SELF, i);

    while (GetIsObjectValid(o))
    {
        if (GetIsDead(o) && GetLocalInt(o, "UNDEAD") == 0)
        {
            //FloatingTextStringOnCreature("... Create Undead ...", OBJECT_SELF);
            SpeakString("Arise!");
            PlaySound("vs_chant_necr_hf");
            SetFacingPoint(GetPosition(o));
            ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.0);
            DelayCommand(1.0, RaiseDead(o));
            nDone = TRUE;
            break;
        }
        o = GetNearestObjectByTag("ks_dig_worker", OBJECT_SELF, ++i);
    }
    return(nDone);
}

// look for workers to kill
int ActionKillWorker()
{
    int nDone = FALSE;
    int i = 1;
    object o = GetNearestObjectByTag("ks_dig_worker", OBJECT_SELF, i);

    while (GetIsObjectValid(o))
    {
        if (!GetIsDead(o) && GetLocalInt(o, "UNDEAD") == 0)
        {
            ActionAttack(o);
            nDone = TRUE;
            break;
        }
        o = GetNearestObjectByTag("ks_dig_worker", OBJECT_SELF, ++i);
    }
    return(nDone);
}

void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();

    ClearCreatureOverrideAIScriptTarget();
    SetCreatureOverrideAIScriptFinished();
    ClearAllActions();

    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if (GetIsObjectValid(oIntruder) && GetIsDead(oIntruder) == TRUE)
    {
        return;
    }

    if (!GetIsEnemy(oIntruder))
    {
        return;
    }

    if (__InCombatRound() == TRUE)
    {
        return;
    }

    __TurnCombatRoundOn(TRUE);

    if(GetIsObjectValid(oIntruder))
    {
        // random taunts
        if (d10() == 1)
        {
            PlayRandomTaunt(oIntruder);
            PlayRandomSound(oIntruder);
        }
        else
        if((d10() == 1) && GetLocalInt(OBJECT_SELF, "iCastDoom") == 0)
        {
            SetLocalInt(OBJECT_SELF, "iCastDoom", 1);
            ActionCastSpellAtObject(SPELL_DOOM, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
        }

        // look for a dead worker to raise as a slave
        int nDone = ActionRaiseDead();

        // look for a worker to kill
        if (!nDone)
            nDone = ActionKillWorker();

        // just attack the enemy
        if (!nDone)
        {
            ActionAttack(oIntruder);
        }
    }

    __TurnCombatRoundOn(FALSE);
    return;
}
