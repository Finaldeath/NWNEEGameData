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
//#include "_inc_cutscene"

void main()
{
    int nDurationType = GetLocalInt(OBJECT_SELF, "nDurationType");
    object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
    float fDuration = GetLocalFloat(OBJECT_SELF, "fDuration");
    int nVisualEffectId = GetLocalInt(OBJECT_SELF, "nVisualEffectId");
    int nMissEffect = GetLocalInt(OBJECT_SELF, "nMissEffect");
    ApplyEffectToObject(nDurationType, EffectVisualEffect(nVisualEffectId, nMissEffect), oTarget, fDuration);
}
