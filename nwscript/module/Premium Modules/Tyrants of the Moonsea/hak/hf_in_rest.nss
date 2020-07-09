#include "hf_in_cutscene"
#include "nw_i0_generic"

const int   nRestCheckHours = 35;

// ---------------------------------------------------------------------------
// Tired Functions
// ---------------------------------------------------------------------------

// return the current time in hours
int RestGetCurrentTimeStamp()
{
    return ( GetCalendarYear()  * 8064 )
         + ( GetCalendarMonth() * 672 )
         + ( GetCalendarDay()   * 24 )
         + ( GetTimeHour());
}

// apply the "tired" penalty to the player
// .. these effects can only be removed by resting (they are "extraordinary")
void RestApplyPenalty(object oPC)
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, 1)), oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 1)), oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1)), oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_WISDOM, 1)), oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CHARISMA, 1)), oPC);
}

// are rest animations disabled for this player?
int RestAnimationsDisabled(object oPC)
{
    object oArea = GetArea(oPC);
    return(GetLocalInt(oArea, "HF_REST_ANIM_DISABLE") == 1);
}

// if the player has not rested for a while, apply a penalty for a certain duration
// .. henchman tiredness is handled via the henchman's heartbeat
void RestSetTired(object oPC, int nTired)
{
    if (nTired)
    {
        // make sure they player didn't dispel the tired effects using a potion
        if (GetLocalInt(oPC, "HF_REST_IS_TIRED") == 1)
        {
            if (!GetHasEffect(EFFECT_TYPE_ABILITY_DECREASE, oPC))
            {
                RestApplyPenalty(oPC);
            }
        }

        // apply the tired effect (ability decreases)
        if (GetLocalInt(oPC, "HF_REST_IS_TIRED") == 0)
        {
            RestApplyPenalty(oPC);
        }
        SetLocalInt(oPC, "HF_REST_IS_TIRED", 1);

        // play some ambient animations
        if (!IsInConversation(oPC) && !GetIsInCombat(oPC) &&
            !CutsceneIsPlaying() && !RestAnimationsDisabled(oPC))
        {
            if (GetCurrentAction(oPC) == ACTION_INVALID)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 4.0));
                if (d10() == 1)
                    AssignCommand(oPC, SpeakString("*yawn*"));
            }
        }
    }
    else
    {
        // remove the tired effect (actually removes all ability decreases)
        effect e = GetFirstEffect(oPC);
        while (GetIsEffectValid(e))
        {
            if (GetEffectType(e) == EFFECT_TYPE_ABILITY_DECREASE)
            {
                RemoveEffect(oPC, e);
            }
            e = GetNextEffect(oPC);
        }
        SetLocalInt(oPC, "HF_REST_LAST_TIME", RestGetCurrentTimeStamp());
        SetLocalInt(oPC, "HF_REST_IS_TIRED", 0);
    }
}

// check if the player is tired and apply effects if tired
void RestCheckTired(object oPC)
{
    int nLastRestTime = GetLocalInt(oPC, "HF_REST_LAST_TIME");
    if (nLastRestTime == 0)
    {
        SetLocalInt(oPC, "HF_REST_LAST_TIME", RestGetCurrentTimeStamp());
    }
    else
    {
        if (RestGetCurrentTimeStamp() - nLastRestTime >= nRestCheckHours)
        {
            if (GetLocalInt(oPC, "HF_REST_IS_TIRED") == 0)
            {
                FloatingTextStringOnCreature("... You are getting tired ...", oPC);
            }
            RestSetTired(oPC, TRUE);
        }
    }
}

