//Heartbeat script for Kur-Tharsu Gate Courtyard Catapult Bolts

#include "hf_in_plot"
#include "inc_ktgate"

//Make an attack roll against target's AC
int MakeAttackRoll(object oTarget)
{
    int nAttackRoll = d20();
    int nBAB = 15;
    int nAdjustedRoll = nAttackRoll + nBAB;
    int nAC = GetAC(oTarget);

    //20 always hits, 1 always misses
    if(nAttackRoll == 20 || (nAdjustedRoll >= nAC && nAttackRoll > 1))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

//Fire a bolt at oTarget
void FireBolt(object oTarget)
{
    int nSpell;

    effect eDam;
    effect eDamType;
    effect ePierce = EffectDamage(d8() + 2, DAMAGE_TYPE_PIERCING);
    effect eVFX;

    if(d2() == 1)
    {
        eDamType = EffectDamage(d6(), DAMAGE_TYPE_FIRE);
        eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);
        nSpell = SPELLABILITY_BOLT_FIRE;
    }
    else
    {
        eDamType = EffectDamage(d6(), DAMAGE_TYPE_ACID);
        eVFX = EffectVisualEffect(VFX_IMP_ACID_S);
        nSpell = SPELLABILITY_BOLT_ACID;
    }

    //Check success of an attack roll against oTarget
    if(MakeAttackRoll(oTarget) == TRUE)
    {
        effect ePierce = EffectDamage(d8() + 2, DAMAGE_TYPE_PIERCING);
        eDam = EffectLinkEffects(eDamType, ePierce);

        ActionCastFakeSpellAtObject(nSpell, oTarget, PROJECTILE_PATH_TYPE_BALLISTIC);
        float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
    //Generate a bolt missing the intended target
    else
    {
        location lMiss = GetRandomMissLocation(oTarget);

        ActionCastFakeSpellAtLocation(nSpell,
                                      lMiss,
                                      PROJECTILE_PATH_TYPE_BALLISTIC);

        float fDist = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lMiss);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);
        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMiss));
    }
}

void main()
{
    object oTarget;

    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 0)
    {
        return;
    }

    oTarget = AcquireTarget(50.0);

    if(oTarget != OBJECT_INVALID)
    {
        DelayCommand(0.1 * (1 + Random(30)), FireBolt(oTarget));
    }
}
