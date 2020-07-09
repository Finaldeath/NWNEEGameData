//::///////////////////////////////////////////////
//:: Vantabular's puzzle completed cutscene
//:: cut_a2_puzzw.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 8/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    location lPortal = GetLocation(GetObjectByTagInArea("cs_wp_portal"));
    // portal is deactive when spawned in (set on template)
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "a2_portal_lh", lPortal);

    // pc and henchmen
    effect eCutGhost = EffectCutsceneGhost();
    object oWP_PC1_Start = GetObjectByTagInArea("cs_wp_pc1");
    object oWP_PC2_Start = GetObjectByTagInArea("cs_wp_pc2");
    object oWP_PC3_Start = GetObjectByTagInArea("cs_wp_pc3");
    object oWP_PC4_Start = GetObjectByTagInArea("cs_wp_pc4");
    object oWP_Garm_Start = GetObjectByTagInArea("cs_wp_garm");
    object oWP_Nisar_Start = GetObjectByTagInArea("cs_wp_nisar");

    object oPC1Copy = cs_CopyPC(GetLocation(oWP_PC1_Start), FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC1Copy);
    object oPC2Copy = cs_CopyPC(GetLocation(oWP_PC2_Start), FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC2Copy);
    object oPC3Copy = cs_CopyPC(GetLocation(oWP_PC3_Start), FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC3Copy);
    object oPC4Copy = cs_CopyPC(GetLocation(oWP_PC4_Start), FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC4Copy);

    object oGarm = CopyObject(GetObjectByTagInArea("a1_hench_garm"), GetLocation(oWP_Garm_Start), OBJECT_INVALID, "garm_copy");
    AssignCommand(oGarm,ChangeToStandardFaction(oGarm,STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    object oNisar = CopyObject(GetObjectByTagInArea("a2_hench_nisar"), GetLocation(oWP_Nisar_Start), OBJECT_INVALID, "nisar_copy");
    AssignCommand(oNisar,ChangeToStandardFaction(oNisar,STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));

    // the Crystal Mechanisms
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 0, GetObjectByTag("a2_cryst_0_0"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 1, GetObjectByTag("a2_cryst_0_1"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 2, GetObjectByTag("a2_cryst_0_2"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 3, GetObjectByTag("a2_cryst_0_3"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 4, GetObjectByTag("a2_cryst_0_4"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 5, GetObjectByTag("a2_cryst_0_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 6, GetObjectByTag("a2_cryst_1_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 7, GetObjectByTag("a2_cryst_2_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 8, GetObjectByTag("a2_cryst_3_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 9, GetObjectByTag("a2_cryst_4_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 10, GetObjectByTag("a2_cryst_5_5"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 11, GetObjectByTag("a2_cryst_5_4"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 12, GetObjectByTag("a2_cryst_5_3"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 13, GetObjectByTag("a2_cryst_5_2"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 14, GetObjectByTag("a2_cryst_5_1"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 15, GetObjectByTag("a2_cryst_5_0"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 16, GetObjectByTag("a2_cryst_4_0"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 17, GetObjectByTag("a2_cryst_3_0"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 18, GetObjectByTag("a2_cryst_2_0"));
    SetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 19, GetObjectByTag("a2_cryst_1_0"));

    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK);

    int i;
    object oCrystal, oInvis, oInvisPrev;
    location lLoc;
    vector vLoc;
    float fDelay;
    effect eBeam;
    for(i=0; i<20; i++)
    {
        fDelay = IntToFloat(i)/4.0 + 1.0;
        oCrystal = GetObjectArray(OBJECT_SELF, "oaCrystalMechanisms", i);
        cs_PlayAnimation(fDelay, oCrystal, ANIMATION_PLACEABLE_ACTIVATE, 1.0, 0.0, TRUE);
        cs_ApplyVFXToObject(fDelay+0.5, DURATION_TYPE_INSTANT, VFX_IMP_MAGIC_PROTECTION, oCrystal, 0.0, FALSE, FALSE);

        vLoc = GetPosition(oCrystal);
        vLoc.z = 1.9;
        lLoc = Location(OBJECT_SELF, vLoc, 0.0);
        oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc);
        SetObjectArray(OBJECT_SELF, "oaInvisObj", i, oInvis);
        if(i > 0)
        {
            oInvisPrev = GetObjectArray(OBJECT_SELF, "oaInvisObj", i-1);
            eBeam = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, oInvisPrev, BODY_NODE_CHEST);
            cs_ApplyEffectToObject(fDelay+2.5, DURATION_TYPE_PERMANENT, eBeam, oInvis);
            if(i==19)
            {
                oInvisPrev = GetObjectArray(OBJECT_SELF, "oaInvisObj", 0);
                eBeam = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, oInvisPrev, BODY_NODE_CHEST);
                cs_ApplyEffectToObject(8.5, DURATION_TYPE_PERMANENT, eBeam, oInvis);
            }
        }
    }

    vLoc = GetPositionFromLocation(lPortal);
    vLoc.z = 6.0;
    lLoc = Location(OBJECT_SELF, vLoc, 0.0);
    object oInvisCenter = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc);

    eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oInvisCenter, BODY_NODE_CHEST);
    cs_ApplyEffectToObject(9.0, DURATION_TYPE_PERMANENT, eBeam, GetObjectArray(OBJECT_SELF, "oaInvisObj", 0));
    cs_ApplyEffectToObject(9.2, DURATION_TYPE_PERMANENT, eBeam, GetObjectArray(OBJECT_SELF, "oaInvisObj", 5));
    cs_ApplyEffectToObject(9.4, DURATION_TYPE_PERMANENT, eBeam, GetObjectArray(OBJECT_SELF, "oaInvisObj", 10));
    cs_ApplyEffectToObject(9.6, DURATION_TYPE_PERMANENT, eBeam, GetObjectArray(OBJECT_SELF, "oaInvisObj", 15));

    cs_ApplyVFXToObject(9.8, DURATION_TYPE_INSTANT, VFX_IMP_LIGHTNING_M, oPortal, 0.0, FALSE, FALSE);
    cs_ApplyVFXToObject(10.0, DURATION_TYPE_INSTANT, VFX_IMP_LIGHTNING_M, oPortal, 0.0, FALSE, FALSE);
    cs_DestroyObject(9.8, oInvisCenter);

    cs_CameraUseCameraWaypoint(0.2, 1);
    cs_CameraUseCameraWaypoint(0.45, 2);
    cs_CameraUseCameraWaypoint(7.0, 3);

    cs_PlayAnimation(9.8, oPortal, ANIMATION_PLACEABLE_ACTIVATE, 1.0, 0.0, TRUE);

    for(i=0; i<20; i++)
    {
        cs_DestroyObject(9.8, GetObjectArray(OBJECT_SELF, "oaInvisObj", i));
    }
    DeleteObjectArray(OBJECT_SELF, "oaInvisObj", 20);
    DeleteObjectArray(OBJECT_SELF, "oaCrystalMechanisms", 20);

    cs_CameraDoFade(12.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_DestroyObject(13.0, oPC1Copy);
    cs_DestroyObject(13.0, oPC2Copy);
    cs_DestroyObject(13.0, oPC3Copy);
    cs_DestroyObject(13.0, oPC4Copy);
    cs_DestroyObject(13.0, oGarm);
    cs_DestroyObject(13.0, oNisar);
    cs_EndCutscene(13.1, FALSE, TRUE, FADE_SPEED_FAST);
}
