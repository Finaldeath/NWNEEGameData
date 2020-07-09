//::///////////////////////////////////////////////
//:: nsc_gzhorb_npcs
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnSpellCastAt event script

    This is for the G'Zhorb boss fight cutscene.
    It ensures that when two NPC's get spells
    cast at them, that they die.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 7, 2006
//:://////////////////////////////////////////////

void main()
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), OBJECT_SELF);
}
