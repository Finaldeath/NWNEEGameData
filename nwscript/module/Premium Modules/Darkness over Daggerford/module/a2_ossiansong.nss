// the player, a bard, has used ossian's song
// .. this releases a burst of negative energy and protects the player
// .. from death magic and negative energy

#include "x2_inc_switches"

void DeathSong(object oPC)
{
    int nBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    float fDur = RoundsToSeconds(nBardLevels);

    // player gains some protection from death
    effect eImmune1 = EffectImmunity(IMMUNITY_TYPE_DEATH);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune1, oPC, fDur);
    effect eImmune2 = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune2, oPC, fDur);
    effect eImmune3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune3, oPC, fDur);
    effect eConceal = EffectConcealment(10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, oPC, fDur);

    // player gets a damage shield of negative energy
    int nDmg = nBardLevels/4 + 1;
    effect eShield = EffectDamageShield(nDmg, DAMAGE_BONUS_1d4, DAMAGE_TYPE_NEGATIVE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShield, oPC, fDur);
    effect eVfx1 = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx1, oPC);
    effect eVfx2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVfx2, oPC);

    // a burst of negative energy strikes enemies in the area
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_BURST, oPC, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
}

void Activate(object oPC)
{
    if (!GetHasFeat(FEAT_BARD_SONGS, oPC))
    {
        AssignCommand(oPC, SpeakStringByStrRef(40063));
    }
    else
    {
        DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
        FloatingTextStringOnCreature("... Singing: 'The Poet's Song' ...", oPC);
        AssignCommand(oPC, PlaySound("as_pl_evilchantm"));
        DelayCommand(2.0, DeathSong(oPC));
    }
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        Activate(GetItemActivator());
    }
}
