//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

const string S_UNDEAD_CASTER = "On second thought, that's probably not a good idea.";

void main()
{
    //Undead players, henchmen, and crewmembers should not cast this on each other.
    object oTarget = GetSpellTargetObject();
    int bUndeadCaster = GetLocalInt(OBJECT_SELF, "IOP_CUST_UNDEAD");
    string sUndeadCasterPrefix = GetStringLeft(GetTag(OBJECT_SELF), 3);
    string sUndeadCasterSuffix = GetStringRight(GetTag(OBJECT_SELF), 5);
    int bUndeadTarget = GetLocalInt(oTarget, "IOP_CUST_UNDEAD");
    string sUndeadTargetPrefix = GetStringLeft(GetTag(oTarget), 3);
    string sUndeadTargetSuffix = GetStringRight(GetTag(oTarget), 5);
    if ((bUndeadCaster == TRUE ||
         (sUndeadCasterPrefix == "a3_" &&
          sUndeadCasterSuffix == "_dead")) &&
        (bUndeadTarget == TRUE ||
         (sUndeadTargetPrefix == "a3_" &&
          sUndeadTargetSuffix == "_dead")))
    {
        FloatingTextStringOnCreature(S_UNDEAD_CASTER, OBJECT_SELF, FALSE);
        return;
    }


/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

  //Declare major variables
  effect eKill, eHeal;
  int nDamage, nHeal, nModify, nMetaMagic, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);

    //Check to see if the target is an undead
    if ((GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        || (GetLocalInt(oTarget, "IOP_CUST_UNDEAD") == TRUE))
    {

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            //Make a touch attack
            if (TouchAttackMelee(oTarget))
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Roll damage
                    nModify = d4();
                    nMetaMagic = GetMetaMagicFeat();
                    //Make metamagic check
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 1;
                    }
                    //Figure out the amount of damage to inflict
                    nDamage =  GetCurrentHitPoints(oTarget) - nModify;
                    //Set damage
                    eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }

    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        //Figure out how much to heal
        nHeal = GetMaxHitPoints(oTarget);
        //Set the heal effect
        eHeal = EffectHeal(nHeal);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
