//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: nhb_tm_thrender
//::////////////////////////////////////////////////////
//:: The Render - OnHeartbeat
//:: Only vulnerable to electrical damage
//::////////////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "nw_i0_plot"
#include "nw_i0_spells"

#include "rb_include"


// Will be immune to all types of damage except the following two
const int    TYPE_EFFECTIVE_DAMAGE_A = DAMAGE_TYPE_ELECTRICAL;
const string LVAR_EFFECTIVE_DAMAGE_A = "effective_dam_a";

const int    TYPE_EFFECTIVE_DAMAGE_B = 8192; // 8192 is never used = no 2nd damage vulnerability
const string LVAR_EFFECTIVE_DAMAGE_B = "effective_dam_b";


void RemoveImmunities()
{
    object oCreator = GetObjectByTag("EffectApplier");

    RemoveNamedEffectByCreator(EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE, OBJECT_SELF, oCreator);
}

void main()
{
    //PrintString("--------------");
    //PrintString("Heartbeat");
    //PrintString("--------------");

    // regenerate any damage (excluding the effective damage types)
    int nTotalDamageA = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_A);
    int nTotalDamageB = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_B);
    int nCurHP = GetCurrentHitPoints(OBJECT_SELF);
    int nMaxHP = GetMaxHitPoints(OBJECT_SELF) - nTotalDamageA - nTotalDamageB;
    int nTrackedHP = GetLocalInt(OBJECT_SELF, "nTrackedHP");
    int nStartingHP = GetLocalInt(OBJECT_SELF, "nStartingHP");
    int nKnockdownDuration = GetLocalInt(OBJECT_SELF, "nKnockdownDuration");

    /*PrintString("HB - My starting HP = " + IntToString(nStartingHP));
    PrintString("HB - My current HP = " + IntToString(GetCurrentHitPoints()));
    PrintString("HB - My tracked HP = " + IntToString(nTrackedHP));
    PrintString("HB - My max hp  = " + IntToString(nMaxHP));
    PrintString("HB - My fire damage = " + IntToString(nFireDmg));
    PrintString("HB - My acid damage = " + IntToString(nAcidDmg));
    SpeakString("My current hit points = " + IntToString(nTrackedHP)); */

    if(GetLocalInt(OBJECT_SELF, "nRecovered") == 1)
    {
         SetLocalInt(OBJECT_SELF, "nRecovered", 0);
         DetermineCombatRound(GetFirstPC());
    }

    //Track minus hp and if > 0 get back up
    if(GetLocalInt(OBJECT_SELF, "nKnockdown") > 0)
    {
        //PrintString("HB - I'm knocked down");

        nKnockdownDuration++;
        //PrintString("HB - Knockdown duration = " + IntToString(nKnockdownDuration));
        SetLocalInt(OBJECT_SELF, "nKnockdownDuration", nKnockdownDuration);

        if(nKnockdownDuration > 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectVisualEffect(VFX_IMP_RESTORATION_LESSER),
                                OBJECT_SELF);
        }
    }

    if (nTrackedHP < nMaxHP)
    {
        int nHeal = nMaxHP - nTrackedHP;
        if (nHeal > 5)
            nHeal = 5;

        nTrackedHP = nTrackedHP + nHeal;

        //PrintString("HB - Healing tracked hp by " + IntToString(nHeal));

        //Only heal current hit points if less than tracked hit points
        nHeal = nTrackedHP - nCurHP;

        //PrintString("HB - Regenerating current hp by " + IntToString(nHeal));

        if(nHeal > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), OBJECT_SELF);
        }

        SetLocalInt(OBJECT_SELF, "nTrackedHP", nTrackedHP);
        //PrintString("HB - Tracked hp after regeneration = " +
        //            IntToString(GetLocalInt(OBJECT_SELF, "nTrackedHP")));
    }

    //if healed above zero and been knocked down for at least 3 rounds, get up
    if(GetLocalInt(OBJECT_SELF, "nKnockdown") == 1 && nTrackedHP > 0 &&
       GetLocalInt(OBJECT_SELF, "nKnockdownDuration") > 3)
    {
        effect eKnockdown = EffectKnockdown();
        effect eKnockdownImmunity = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
        effect eParalyse = EffectCutsceneParalyze();

        ClearAllActions(TRUE);
        RemoveImmunities();
        RemoveSpecificEffect(GetEffectType(eParalyse),OBJECT_SELF);
        RemoveSpecificEffect(GetEffectType(eKnockdown),OBJECT_SELF);
        RemoveSpecificEffect(GetEffectType(eKnockdownImmunity),OBJECT_SELF);

        SetLocalInt(OBJECT_SELF, "nRecovered", 1);
        SetLocalInt(OBJECT_SELF, "nKnockdown", 0);
        SetLocalInt(OBJECT_SELF, "nKnockdownDuration", 0);
        //PrintString("HB - Getting back up");
    }

    //PrintString("--------------");
    //PrintString("Heartbeat ends");
    //PrintString("--------------");
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
