// during a cutscene dialog, edalseye rains destruction down upon his apprentice

#include "hf_in_graphics"

void Blast(object oSelf, object oPC)
{
    // vfx on tower top
    location lLoc = GetLocation(oSelf);
    DrawCircle(lLoc, 2.0, VFX_IMP_LIGHTNING_S);
    DrawLineVert(lLoc, VFX_IMP_LIGHTNING_S);

    // lightning bolts
    effect eLightning = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    int i = 1;
    object oWP = GetNearestObjectByTag("WP_AR1100_CUT1_LIGHTNING", oPC, i);
    while (GetIsObjectValid(oWP))
    {
        location lLoc = GetLocation(oWP);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLightning, lLoc);
        oWP = GetNearestObjectByTag("WP_AR1100_CUT1_LIGHTNING", oPC, ++i);
    }

    // thunder
    lLoc = GetLocation(oPC);
    effect eThunder = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eThunder, lLoc);
    PlaySound("as_wt_thundercl1");
}

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    ActionPauseConversation();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY), OBJECT_SELF);
    PlaySound("vs_chant_evoc_hm");
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0);
    DelayCommand(2.9, Blast(oSelf, oPC));
    ActionResumeConversation();
}
