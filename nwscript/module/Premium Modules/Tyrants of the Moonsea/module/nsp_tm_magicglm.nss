//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nsp_tm_magicglm
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: onSpawn script for magic golem, grant immunity to magic weapons. Use hide to grant immunity to elemental damage.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    int i = 0;
    int nReductionEffects = 5;

    effect eMagicWeaponImmune = EffectDamageReduction(1000, 22);
    effect eNormalWeaponVulnerability;

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eMagicWeaponImmune), OBJECT_SELF);

    //Apply initial five damage reduction effects to simulate normal weapon vulnerability
    for(i = 1; i <= nReductionEffects; i++)
    {
        eNormalWeaponVulnerability = EffectDamageReduction(2000, DAMAGE_POWER_PLUS_ONE, 1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eNormalWeaponVulnerability), OBJECT_SELF);
    }

    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
