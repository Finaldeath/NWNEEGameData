//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndm_tm_magicglm
// DATE: March 1, 2006
// AUTH: Luke Scull
// NOTE: OnDamage script for magic golem, allows non-
//       magical weapons to keep harming it even after
//       the first blow.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    int i = 0;
    int nBoost = 0;
    int nReductionEffects = 5;
    int nReduct = 0;

    effect eNormalWeaponVulnerability;
    effect eScan = GetFirstEffect(OBJECT_SELF);

    //Determine how many reduction effects are currently applied
    while (GetIsEffectValid(eScan))
    {
        if (GetEffectCreator(eScan) == OBJECT_SELF && GetEffectType(eScan) == EFFECT_TYPE_DAMAGE_REDUCTION)
            nReduct++;
        eScan = GetNextEffect(OBJECT_SELF);
    }

    //Ensure we have at least 5 Damage Reduction effects to ensure multiple
    //non-magical attacks are not resisted
    nBoost = nReductionEffects - nReduct;
    for(i = 0; i < nBoost; i++)
    {
        eNormalWeaponVulnerability = EffectDamageReduction(2000, DAMAGE_POWER_PLUS_ONE, 1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eNormalWeaponVulnerability), OBJECT_SELF);
    }

    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
