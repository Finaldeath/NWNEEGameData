//::///////////////////////////////////////////////
//:: Nightmare : Smoke For Wyvern Crown
//:: OnHeartbeat of AoE
//:: DLA_S1_NMSMOKEC.nss
//:://////////////////////////////////////////////
/*
    In the excitement of battle, the nightmare snorts and
    neighs with rage, filling the area with smoke.

    This provides concealment bonus to the nightmare.

    Additionally, the act of snorting is a free action the
    nightmare performs once per round in combat, and
    targets hit by the snorted cone of smoke suffer penalty
    in attack and damage.

    NOT FOR USE WITH ACTUAL NIGHTMARE. SPECIFICALLY WRITTEN
    FOR "TAILS" HORSES.
*/
//:://////////////////////////////////////////////
//:: Created By: gaoneng
//:: Created On: May 11, 2006
//:://////////////////////////////////////////////

#include "DLA_I0_CONST"
#include "NW_I0_SPELLS"

void main()
{
    object nightmare = GetAreaOfEffectCreator();

    if (!GetIsInCombat(nightmare)) // smoke is a by-product of nightmare getting excited in combat
    {                              // if nightmare is no longer in combat, remove smoke aoe
//        DeleteLocalInt(nightmare, "GN_NMROUND");
        AssignCommand(nightmare, ForceRest(nightmare)); // rest the nightmare so it can use the smoke effect again next combat
        DestroyObject(OBJECT_SELF);
        return;
    }

    // nightmare gains concealment bonus while in combat
    effect conmelee = EffectConcealment(50, MISS_CHANCE_TYPE_VS_MELEE),
           conrange = EffectConcealment(100, MISS_CHANCE_TYPE_VS_RANGED);
    effect conceal = EffectLinkEffects(conmelee, conrange);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SupernaturalEffect(conceal), nightmare, 6.0);

/*    if (GetLocalInt(nightmare, "GN_NMROUND") == 2) // every three rounds nightmare breaths smoke
    {
        DeleteLocalInt(nightmare, "GN_NMROUND");
        AssignCommand(nightmare, gn_NightmareBreath());
    }
    else
    {
        SetLocalInt(nightmare, "GN_NMROUND", GetLocalInt(nightmare, "GN_NMROUND") + 1);
    }
} */

// gaoneng erick :
// the tail models do not have the proper impact nodes on them and cannot carry
// the breath vfx properly. So breath spell cone sequence is removed, and
// penalties are automatically applied if enemies are in the AoE.

    int DC = 16; // from Monster Manual
    effect cessate = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE),
           save    = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE),
           headhit = EffectVisualEffect(VFX_IMP_NIGHTMARE_HEAD_HIT),
           blind   = EffectBlindness(),
           attack  = EffectAttackDecrease(2);
//           damage = EffectDamageDecrease(2, DAMAGE_TYPE_BASE_WEAPON);  // doesn't work
    effect penalty = EffectLinkEffects(attack, cessate);

    string feed = " is choked ";

    object enemy = GetFirstInPersistentObject();
    while (GetIsObjectValid(enemy))
    {
        if (!GetHasSpellEffect(SPELLABILITY_NIGHTMARE_SMOKE, enemy))
        {
            if (GetIsEnemy(enemy, nightmare) && !GetIsReactionTypeFriendly(enemy, nightmare))
            {
                SignalEvent(enemy, EventSpellCastAt(nightmare, SPELLABILITY_NIGHTMARE_SMOKE));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, save, enemy);
                if (!MySavingThrow(SAVING_THROW_FORT, enemy, DC, SAVING_THROW_TYPE_NONE, nightmare))
                {
                    if (!GetIsImmune(enemy, IMMUNITY_TYPE_BLINDNESS) && !MySavingThrow(SAVING_THROW_FORT, enemy, DC))
                    {   // not immune to blind, and fail saving second time
                        penalty = EffectLinkEffects(penalty, blind);
                        feed += "and blinded ";
                    }  // reduce attack (and damage) (and blind) enemy
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SupernaturalEffect(penalty), enemy, IntToFloat(d6()*60));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, headhit, enemy);
                    if (GetIsPC(enemy)) SendMessageToPC(enemy, GetName(enemy) + feed + "by the smoke.");
                }
            }
        }
        enemy = GetNextInPersistentObject();
    }
}
