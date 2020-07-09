//::///////////////////////////////////////////////
//:: nsp_a3_ghost
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handle the spawn of act 3 ghosts.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    effect eVFX1 = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT);
    effect eVFX2 = EffectCutsceneGhost();

    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX1, OBJECT_SELF));
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX2, OBJECT_SELF));
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
