//::///////////////////////////////////////////////
//:: nsp_polysettings
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script sets Poly Default properties
    on spawn.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_balance"

void main()
{
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    object oFollow = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
        PLAYER_CHAR_IS_PC, oSelf);

    effect eGhost = EffectCutsceneGhost();
    effect eFlee = EffectAreaOfEffect(AOE_PER_CUSTOM_AOE, "exe_polyflee");
    int iUndead = GetLocalInt(oModule, "exe_a3_dead40");

    LevelUpNPC(oSelf);
    // JE: Delayed this slightly, so Poly doesn't spawn in the player
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSelf));
    DelayCommand(5.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlee, oSelf));

    // If the player should be undead set poly to appear as a bat
    if (iUndead == TRUE)
    {
        SetCreatureAppearanceType(oSelf, APPEARANCE_TYPE_BAT);
    }

    ActionForceFollowObject(oFollow, 1.0f);
}
