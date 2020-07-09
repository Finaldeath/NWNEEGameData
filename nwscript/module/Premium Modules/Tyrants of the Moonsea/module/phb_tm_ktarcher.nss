//Heartbeat script for Kur-Tharsu arrowslit archers

#include "hf_in_plot"
#include "inc_ktgate"

//Make an attack roll against target's AC
int MakeAttackRoll(object oTarget)
{
    int nAttackRoll = d20();
    int nBAB = 10;
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

//Fire an arrow at oTarget
void FireArrow(object oTarget)
{
    //Check success of an attack roll against oTarget
    if(MakeAttackRoll(oTarget) == TRUE)
    {
        effect eArrow;
        effect eDam ;
        effect ePierce = EffectDamage(d8() + 2, DAMAGE_TYPE_PIERCING);
        effect eVFX;

        //One in eight arrows are fire arrows
        if(d8() == 1)
        {
            eArrow = EffectVisualEffect(VFX_IMP_MIRV_FLAME);
            effect eFire = EffectDamage(d6(), DAMAGE_TYPE_FIRE);
            eDam = EffectLinkEffects(eFire, ePierce);
            eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);
        }
        else
        {
            eArrow = EffectVisualEffect(357);
            eDam = ePierce;
            eVFX = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);
        float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
    //Generate an arrow missing the intended target
    else
    {
        //One in eight arrows are fire arrows (flaming bolt in this case)
        if(d8() == 1)
        {
            effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);

            location lMiss = GetRandomMissLocation(oTarget);

            ActionCastFakeSpellAtLocation(SPELLABILITY_BOLT_FIRE,
                                          lMiss,
                                          PROJECTILE_PATH_TYPE_HOMING);

           float fDist = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lMiss);
           float fDelay = fDist / 25.0;
           DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMiss));

        }
        else
        {
            ActionCastSpellAtLocation(SPELL_TRAP_ARROW,
                                      GetRandomMissLocation(oTarget),
                                      METAMAGIC_ANY,
                                      TRUE,
                                      PROJECTILE_PATH_TYPE_HOMING,
                                      TRUE);
        }
    }
}

void main()
{
    float fRange = GetLocalFloat(OBJECT_SELF, "fRange");

    object oTarget;

    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 0)
    {
        return;
    }

    //Set maximum range of target, defaulting to 25 if fRange not set
    if(fRange == 0.0f)
    {
        fRange = 25.0f;
    }

    oTarget = AcquireTarget(fRange);

    if(oTarget != OBJECT_INVALID)
    {
        DelayCommand(0.1 * (1 + Random(30)), FireArrow(oTarget));
    }
}
