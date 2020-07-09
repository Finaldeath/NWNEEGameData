//::///////////////////////////////////////////////
//:: Name: am_suitofarmor
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Turns an NPC into a static suit of armour.
*/
//:://////////////////////////////////////////////
//:: Created By: Alan Miranda
//:://////////////////////////////////////////////


void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneParalyze(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION), OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "X1_L_IMMUNE_TO_DISPEL", 10);
}
