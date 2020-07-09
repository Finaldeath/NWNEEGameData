//::///////////////////////////////////////////////
//:: Cutscene system - Special Apply Visual Effect script
//:: _cs_applyvfx.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script gets executed on a special invisible
    object used by the cutscene system. When the system
    later checks to see who the creator of the effect
    was, if it was created by this object (via this
    script) the system knows that it should remove
    the effect from the object it was applied to.

    This is such a hack. I would kill for a
    SetLocalEffect() function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 26, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    int nDurationType = GetLocalInt(OBJECT_SELF, CS_VAR_VFX_N_DURATION_TYPE);
    object oTarget = GetLocalObject(OBJECT_SELF, CS_VAR_VFX_O_TARGET);
    float fDuration = GetLocalFloat(OBJECT_SELF, CS_VAR_VFX_F_DURATION);
    int nVisualEffectId = GetLocalInt(OBJECT_SELF, CS_VAR_VFX_N_VISUAL_EFFECT_ID);
    int nMissEffect = GetLocalInt(OBJECT_SELF, CS_VAR_VFX_N_MISS_EFFECT);
    ApplyEffectToObject(nDurationType, EffectVisualEffect(nVisualEffectId, nMissEffect), oTarget, fDuration);
}
