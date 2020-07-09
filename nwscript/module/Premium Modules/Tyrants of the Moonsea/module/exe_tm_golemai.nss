//Magic Golem combat AI script

#include "nw_i0_generic"
#include "x2_inc_switches"

//Golem attack is magical blast for 3d10 damage
void DoEnergyBlast(object oIntruder)
{
    int nDam = d10(3);

    float fDist = GetDistanceBetween(OBJECT_SELF, oIntruder);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    float fDelay2 = 0.1;
    float fTime;

    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
    effect eMissile = EffectVisualEffect(VFX_IMP_MIRV);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);

    fTime = fDelay;
    fTime += fDelay2;

    //Apply the MIRV and damage effect
    DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oIntruder));
    DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oIntruder));
    DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oIntruder));
}

//Perform animations and perform blast attack
void TakeAction(object oIntruder)
{
    ActionCastFakeSpellAtObject(SPELL_MAGIC_MISSILE, oIntruder);
    ActionDoCommand(DoEnergyBlast(oIntruder));
}

void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();
    ClearCreatureOverrideAIScriptTarget();

    // do we have a valid target?
    SetLocalInt(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT_OK", 1);;

    // do we have a valid target?
    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetLastAttacker();
    }

    if (GetIsDead(oIntruder) == TRUE)
    {
        return;
    }
    if (!GetIsEnemy(oIntruder))
        return;
    if (__InCombatRound() == TRUE)
    {
        return;
    }
    __TurnCombatRoundOn(TRUE);

    // Chance of casting healing spell on either own or PC faction

        TakeAction(oIntruder);
        __TurnCombatRoundOn(FALSE);
        return;
}
