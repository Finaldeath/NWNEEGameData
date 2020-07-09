//::///////////////////////////////////////////////
//:: dla_inc_ride
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file of DLA Horse system.
   This deals with Mounted Combat, Mounted Archery, and Ride checks. It is called from OnHeartbeat at the moment.
*/
//:://////////////////////////////////////////////
//:: Created By: Stratovarius
//:: Created On: Oct 22, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_pdk"
#include "cu_functions"
#include "dla_i0_strings"

// This function will perform the checks required for the Ride Skill, Mounted Combat, and Mounted Archery
// It should be called from Onheartbeat, otherwise it will not function properly.
void DLA_DoRideChecks(object oPC);

void DLA_DoRideChecks(object oCreature)
{
    int nDuration = 1; //rounds

    // Gale 28 Nov 2005: Changed to allow ride checks on henchmans

    // Here we do the loops in combat for a PC
    if (GetIsInCombat(oCreature))
    {
        if (!DLA_GetMountIsWarhorse(oCreature))
        {
            // If you're not on a warhorse, make a check to see if you can control the mount
            // If you fail, it panics and runs
            int nSkillCheck = GetSkillCheckSucceeded(oCreature, SKILL_DLA_RIDE, 20);
            // If the check is failed
            if (!nSkillCheck)
            {
                //Gale 28 Nov 2005: Added visual effect to make it more clear that
                // the creature is suffering from fear
                effect eFear = EffectFrightened();
                effect eMind = EffectVisualEffect(VFX_DUR_DLA_HORSE_PANIC);
                effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
                effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                //Link the fear and mind effects

                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oCreature));

                // They should run away, because its the horse panicking, not the PC being immune to fear
                if (GetIsImmune(oCreature, IMMUNITY_TYPE_FEAR) || GetIsImmune(oCreature, IMMUNITY_TYPE_MIND_SPELLS || GetLevelByClass(CLASS_TYPE_PALADIN, oCreature) > 0))
                {
                    SetCommandable(FALSE, oCreature);
                    AssignCommand (oCreature, ClearAllActions());
                    // Causes the horse to flee from the nearest creature
                    // 6/15/2006 - Deva B. Winblood - Feedback
                    FloatingTextStringOnCreature(DLA_SetStringColor("The horse is not trained for combat and is afraid.","622"),oCreature,FALSE);
                    AssignCommand(oCreature, ActionMoveAwayFromObject(GetNearestObject(OBJECT_TYPE_CREATURE, oCreature) , TRUE, 100.0));
                    DelayCommand(RoundsToSeconds(nDuration), SetCommandable(TRUE, oCreature));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oCreature, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMind, oCreature, RoundsToSeconds(nDuration));
                }
                else
                {
                    effect eLink = EffectLinkEffects(eDur, eMind);
                    eLink = EffectLinkEffects(eLink, eFear);
                    // 6/15/2006 - Deva B. Winblood - Feedback
                    FloatingTextStringOnCreature(DLA_SetStringColor("The horse is not trained for combat and is afraid.","622"),oCreature,FALSE);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCreature, RoundsToSeconds(nDuration));
                }
            }
        }

        if (GetHasFeat(FEAT_DLA_MOUNTED_COMBAT, oCreature))
        {
            // Ride check here
            int nRide = GetSkillRank(SKILL_DLA_RIDE, oCreature);
            int nCheck = nRide + d20();
            // This will round the check down
            int nBonus = nCheck/5;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nBonus), oCreature, RoundsToSeconds(1));
        }
    }
}

//void main() { }
