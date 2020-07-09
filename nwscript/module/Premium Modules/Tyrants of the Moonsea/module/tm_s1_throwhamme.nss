//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: tm_s1_throwhamme
//:: DATE: March 12, 2019
//::////////////////////////////////////////////////////
//:: Throw effect for the Warhammer: Dwarven Thrower
//::////////////////////////////////////////////////////

const int SPELL_ID_THROW_HAMMER = 15001;
const int HAMMER_IMPACT_VFX = VFX_IMP_SUNSTRIKE;
const float MAX_THROW_RANGE = 15.0f;  // For auto selecting a hostile target

#include "x2_inc_itemprop"
#include "x2_inc_switches"


// Get damage based on racial type
int CalculateDamageAmount(object oUser, object oTarget, object oWeapon = OBJECT_INVALID)
{
    int nDamage = d8(2) +
        GetAbilityModifier(ABILITY_STRENGTH, oUser) +
        GetHasFeat(FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER, oUser) +
        (GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_WARHAMMER, oUser)*4);
    // Grab enhancement bonus from weapon if one was specified
    if (GetIsObjectValid(oWeapon))
        nDamage = nDamage + IPGetWeaponEnhancementBonus(oWeapon);
    // Add damage bonus for Giants
    if (GetRacialType(oTarget) == RACIAL_TYPE_GIANT )
        nDamage = nDamage + d8();
    return nDamage;
}


// Calculates the flight time of the hammer.
float CalculateHitDelay(object oUser, object oTarget)
{
    return (GetDistanceBetween(oUser, oTarget)/20.0);
}


// Return the result of a trwo weapon attack roll.
// - Can supply weapon foci matching the weapon type
// - Use nModification for things like an improvised throwing weapon (-4)
int ThrowWeaponAttackRoll(object oUser,
                          object oWeapon=OBJECT_INVALID,
                          int nFeatWeaponFocus=FEAT_WEAPON_FOCUS_WAR_HAMMER,
                          int nFeatEpicWeaponFocus=FEAT_EPIC_WEAPON_FOCUS_WARHAMMER,
                          int nModification = 0)
{
    int nAttackRoll = d20() +
                      GetBaseAttackBonus(oUser) +
                      GetAbilityModifier(ABILITY_DEXTERITY, oUser) +
                      GetHasFeat(nFeatWeaponFocus, oUser) +
                      GetHasFeat(FEAT_EPIC_PROWESS, oUser) +
                      (GetHasFeat(nFeatEpicWeaponFocus, oUser)*2) +
                      GetHasFeat(FEAT_GOOD_AIM, oUser) +
                      nModification;
    if (GetIsObjectValid(oWeapon))
        nAttackRoll = nAttackRoll + IPGetWeaponEnhancementBonus(oWeapon);
    return nAttackRoll;
}


void ApplyDamageEffects(object oUser,
                        object oTarget,
                        object oWeapon=OBJECT_INVALID,
                        int nDefaultDamageType=DAMAGE_TYPE_BLUDGEONING)
{
    int nDamageAmount = CalculateDamageAmount(oUser, oTarget, oWeapon);
    int nDamagePower = IPGetWeaponEnhancementBonus(oWeapon);
    int nDamageType = nDefaultDamageType;

    effect eDamage = EffectDamage(nDamageAmount, nDamageType, nDamagePower);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);

    effect eVisual = EffectVisualEffect(HAMMER_IMPACT_VFX);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}


// Get the attack target.
// If Target is invalid, will select a random hostile one within range.
object GetThrowTarget(object oUser,
                      object oItemActivatedTarget = OBJECT_INVALID,
                      float fRange = 15.0f)
{
    object oTarget = OBJECT_INVALID;
    if (!GetIsObjectValid(oItemActivatedTarget) || (oItemActivatedTarget == oUser))
    {
        location lUser = GetLocation(oUser);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lUser, TRUE, OBJECT_TYPE_CREATURE);
        while (GetIsObjectValid(oTarget))
        {
            if (GetIsEnemy(oUser, oTarget) && !GetIsDead(oTarget))
                return oTarget;
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRange, lUser, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    else
    {
        oTarget = oItemActivatedTarget;
    }
    return oTarget;
}


void main()
{
    object oUser = GetLastSpellCaster();
    object oItem = GetSpellCastItem();
    object oTarget = GetThrowTarget(oUser, GetSpellTargetObject(), MAX_THROW_RANGE);

    if (GetIsObjectValid(oTarget))
    {
        if (ThrowWeaponAttackRoll(oUser, oItem) >= GetAC(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oUser, SPELL_ID_THROW_HAMMER, TRUE));
            DelayCommand(CalculateHitDelay(oUser, oTarget), ApplyDamageEffects(oUser, oTarget, oItem));
        }
    }
}
