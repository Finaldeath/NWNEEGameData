//::///////////////////////////////////////////////
//:: Howler Quill Attack
//:: dla_s1_quills
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Must make a melee touch attack, for each of 1d4
    quills. Each successful hit,
    the target is struck down with poison that
    scales with level.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Feb 20, 2006
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "dla_i0_const"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDC = 16;
    int nQuills = d4();
    int nDuration = GetScaledDuration(GetHitDice(OBJECT_SELF), oTarget);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_QUILLS));

// modified by : gaoneng erick
// modified on : May 11, 2006
// added quill vfx as visual cue
    effect eAttack = EffectAttackDecrease(1);
    effect eSave   = EffectSavingThrowDecrease(SAVING_THROW_ALL, 1);
    effect eSkill  = EffectSkillDecrease(SKILL_ALL_SKILLS, 1);
    effect vfx     = EffectVisualEffect(VFX_DUR_HOWLER_QUILL);

    effect eLink = EffectLinkEffects(eSave, eAttack);
    eLink        = EffectLinkEffects(eSkill, eLink);
    eLink        = EffectLinkEffects(eLink, vfx);


    int i;
    while (++i  <= nQuills)
        //Make a melee touch attack
        if (TouchAttackMelee(oTarget))
        {
            effect eDamage = EffectDamage(d4()+2, DAMAGE_TYPE_PIERCING);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);

            if (!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC))
            {
                if (GetIsPC(oTarget))
                    //(message)A quill broke on your flesh.
                    SendMessageToPCByStrRef(oTarget,16797874);

                //Apply effects
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

                effect eRemovalDamage = EffectDamage(d6(), DAMAGE_TYPE_PIERCING);
                DelayCommand(RoundsToSeconds(nDuration), ApplyEffectToObject(DURATION_TYPE_INSTANT, eRemovalDamage, oTarget));
            }
        }
}

