// September 2005
// B W-Husey
// Default spawn script - very basic behaviours and no treasure
// Modified from Bioware standard spawn script.

#include "x0_i0_anims"
#include "x2_inc_switches"

void main()
{
    SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
    //--------------------------------------------------------------------------
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
   }


    //Next lines for wyvern combat behaviour
    if (GetResRef(OBJECT_SELF) == "wyvern" || GetResRef(OBJECT_SELF) == "juvenilewyvern" ||GetResRef(OBJECT_SELF) == "hugewyvern" ||GetResRef(OBJECT_SELF) == "greatwyvern" ||GetResRef(OBJECT_SELF) == "immaturewyvern")
    {
        SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION, TRUE);
    }

    if (GetLocalInt(OBJECT_SELF,"nCombat")>0)        SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    if (GetLocalInt(OBJECT_SELF,"nPerceive")>0)   SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    if (GetLocalInt(OBJECT_SELF,"nBandit")==1)   SetSpawnInCondition(NW_FLAG_DEATH_EVENT);
    if (GetLocalInt(OBJECT_SELF,"nOneLine")>0)   SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
    if (GetLocalInt(OBJECT_SELF,"nNightSleep")>0)   SetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT);
    SetListeningPatterns();
    WalkWayPoints();

    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //

    // * If Incorporeal, apply changes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

    }

}


