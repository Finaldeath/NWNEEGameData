// deldarine opens a portal to the tower

#include "hf_in_plot"

void CreatePortal(object oPC)
{
    object oWP1 = GetWaypointByTag("WP_AR1100_PORTAL_1");
    location lLoc1 = GetLocation(oWP1);
    object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal2", lLoc1);
    SetLocalString(oPortal1, "DESTINATION_DOWN", "WP_AR1100_PORTAL_1_EXIT");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUNSTRIKE), lLoc1);
    object oSnd1 = GetNearestObjectByTag("snd_ar1100_portal", oPortal1);
    SoundObjectPlay(oSnd1);

    object oWP2 = GetWaypointByTag("WP_AR1100_PORTAL_2");
    location lLoc2 = GetLocation(oWP2);
    object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal2", lLoc2);
    SetLocalString(oPortal2, "DESTINATION_DOWN", "WP_AR1100_PORTAL_2_EXIT");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUNSTRIKE), lLoc2);
    object oSnd2 = GetNearestObjectByTag("snd_ar1100_portal", oPortal2);
    SoundObjectPlay(oSnd2);

    AddJournalQuestEntry("j83", 2, oPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    ActionPauseConversation();
    PlaySound("vs_chant_conj_lf");
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0);
    ActionDoCommand(CreatePortal(oPC));
    ActionResumeConversation();
    PlotLevelSet("ks_deldarine", 2);
}
