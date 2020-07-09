//::///////////////////////////////////////////////
//:: cut_a3_undead2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarr turns the PC and his crew, but soon
    realizes that he doesn't have control of the
    PC. Combat ensues.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_undead"

const string sKolmarr1 = "Hahaharrr! The Skull an' Bones be crewed again!";
const string sKolmarr2 = "Now, lick yer captain's boots!";
const string sKolmarr3 = "What!? You're supposed to be under my control!";
const string sKolmarr4 = "Avast, me loyal crew! Attack the mutinous traitor!";
const string sNisar1 = "Lick mine, Kolmarr!";

void main()
{
    object oModule = GetModule();
    object oWayPoint, oDead;
    object oNPCCrew1, oNPCCrew2, oNPCCrew3, oNPCCrew4, oNPCCrew5;
    object oNPDCrew1, oNPDCrew2, oNPDCrew3, oNPDCrew4, oNPDCrew5;
    object oNPCSpwn1, oNPCSpwn2, oNPCSpwn3, oNPCSpwn4, oNPCSpwn5;

    string sNPCDel = "PLACEHOLDER_";
    string sNPCRes;

    location lSpawn;
    float fDelay = 1.0f;
    int iCounter = 1;

    object oKolmarr = GetObjectByTag("a3_necro_fight");
    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");
    object oNisar = GetObjectByTag("A3_NDD_NISAR");
    object oGarm = GetObjectByTag("A3_NDD_GARM");

    object oWPNisar1 = GetObjectByTag("A3_NDD_NISARSPWN");
    object oWPNisar2 = GetObjectByTag("A3_NDD_NISAR2");
    object oWPGarm1 = GetObjectByTag("A3_NDD_GARMSPWN");
    object oWPGarm2 = GetObjectByTag("A3_NDD_GARM2");
    object oWPKolmar1 = GetObjectByTag("A3_NECROFIGHT0");
    object oWPKolmar2 = GetObjectByTag("A3_NECROFIGHT1");
    object oWPKolmar3 = GetObjectByTag("A3_NECROFIGHT2");

    object oSPWNPlayer1_1 = GetObjectByTag("A3_NDD_PLAYERSPWN1");
    object oSPWNPlayer2_1 = GetObjectByTag("A3_NDD_PLAYERSPWN2");
    object oSPWNPlayer3_1 = GetObjectByTag("A3_NDD_PLAYERSPWN3");
    object oSPWNPlayer4_1 = GetObjectByTag("A3_NDD_PLAYERSPWN4");

    object oWPPlayer1_1 = GetObjectByTag("A3_NDD_PLAYER1_1");
    object oWPPlayer2_1 = GetObjectByTag("A3_NDD_PLAYER2_1");
    object oWPPlayer3_1 = GetObjectByTag("A3_NDD_PLAYER3_1");
    object oWPPlayer4_1 = GetObjectByTag("A3_NDD_PLAYER4_1");

    effect eGhost = EffectCutsceneGhost();
    effect eSummon2 = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
    effect eSummon3 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);

    object oPCCopy1 = GetObjectByTag("A3_NDD_PC1");
    object oPCCopy2 = GetObjectByTag("A3_NDD_PC2");
    object oPCCopy3 = GetObjectByTag("A3_NDD_PC3");
    object oPCCopy4 = GetObjectByTag("A3_NDD_PC4");

    oNPCCrew1 = GetObjectByTag("PLACEHOLDER_1");
    oNPCCrew2 = GetObjectByTag("PLACEHOLDER_2");
    oNPCCrew3 = GetObjectByTag("PLACEHOLDER_3");
    oNPCCrew4 = GetObjectByTag("PLACEHOLDER_4");
    oNPCCrew5 = GetObjectByTag("PLACEHOLDER_5");

    AssignCommand(oNPCCrew1, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPCCrew2, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPCCrew3, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPCCrew4, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPCCrew5, SetIsDestroyable(TRUE, FALSE, FALSE));

    oNPCSpwn1 = GetObjectByTag("A3_NFIGHT_NPC1");
    oNPCSpwn2 = GetObjectByTag("A3_NFIGHT_NPC2");
    oNPCSpwn3 = GetObjectByTag("A3_NFIGHT_NPC3");
    oNPCSpwn4 = GetObjectByTag("A3_NFIGHT_NPC4");
    oNPCSpwn5 = GetObjectByTag("A3_NFIGHT_NPC5");

    oNPDCrew1 = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oModule,
        "NPC_CREW_DEAD1"), GetLocation(oWPNisar1));
    oNPDCrew2 = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oModule,
        "NPC_CREW_DEAD2"), GetLocation(oSPWNPlayer1_1));
    oNPDCrew3 = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oModule,
        "NPC_CREW_DEAD3"), GetLocation(oSPWNPlayer2_1));
    oNPDCrew4 = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oModule,
        "NPC_CREW_DEAD4"), GetLocation(oSPWNPlayer3_1));
    oNPDCrew5 = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oModule,
        "NPC_CREW_DEAD5"), GetLocation(oSPWNPlayer4_1));

    AssignCommand(oNPDCrew1, SetIsDestroyable(FALSE, FALSE, FALSE));
    AssignCommand(oNPDCrew2, SetIsDestroyable(FALSE, FALSE, FALSE));
    AssignCommand(oNPDCrew3, SetIsDestroyable(FALSE, FALSE, FALSE));
    AssignCommand(oNPDCrew4, SetIsDestroyable(FALSE, FALSE, FALSE));
    AssignCommand(oNPDCrew5, SetIsDestroyable(FALSE, FALSE, FALSE));

    //spin the camera to face the various transformations
    cs_CameraSetFacing(1.5f, 70.0f, 13.0f, 55.0f, CAMERA_TRANSITION_TYPE_MEDIUM);
    cs_CameraSetFacing(3.5f, 320.0f, 13.0f, 55.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraSetFacing(7.5f, 250.0f, 13.0f, 55.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraSetFacing(9.5f, 210.0f, 8.0f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_ActionPlayAnimation(1.0f, oKolmarr, ANIMATION_LOOPING_CONJURE1, 1.0f, 22.0f);
    cs_ApplyVFXToObject(1.5f, DURATION_TYPE_TEMPORARY, VFX_DUR_PROTECTION_EVIL_MAJOR, oKolmarr, 23.5f);
    cs_ApplyVFXToObject(1.5f, DURATION_TYPE_INSTANT, VFX_FNF_LOS_EVIL_20, oKolmarr);

    // Kolmar transforms the crew
    cs_SetFacingPoint(2.0f, oKolmarr, GetPosition(oNPCSpwn1));
    cs_ApplyVFXToObject(3.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon2, GetLocation(oNPCSpwn1)));
    cs_JumpToLocation(3.5f, oNPDCrew1, GetLocation(oNPCSpwn1));
    cs_DestroyObject(3.5f, oNPCCrew1);

    cs_SetFacingPoint(5.0f, oKolmarr, GetPosition(oNPCSpwn2));
    cs_ApplyVFXToObject(6.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon2, GetLocation(oNPCSpwn2)));
    cs_JumpToLocation(6.5f, oNPDCrew2, GetLocation(oNPCSpwn2));
    cs_DestroyObject(6.5f, oNPCCrew2);

    cs_SetFacingPoint(8.0f, oKolmarr, GetPosition(oNPCSpwn3));
    cs_ApplyVFXToObject(9.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    DelayCommand(9.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon2, GetLocation(oNPCSpwn3)));
    cs_JumpToLocation(9.5f, oNPDCrew3, GetLocation(oNPCSpwn3));
    cs_DestroyObject(9.5f, oNPCCrew3);

    cs_SetFacingPoint(11.0f, oKolmarr, GetPosition(oNPCSpwn4));
    cs_ApplyVFXToObject(12.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    DelayCommand(12.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon2, GetLocation(oNPCSpwn4)));
    cs_JumpToLocation(12.5f, oNPDCrew4, GetLocation(oNPCSpwn4));
    cs_DestroyObject(12.5f, oNPCCrew4);

    cs_SetFacingPoint(15.0f, oKolmarr, GetPosition(oNPCSpwn5));
    cs_ApplyVFXToObject(15.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon2, GetLocation(oNPCSpwn5)));
    cs_JumpToLocation(15.5f, oNPDCrew5, GetLocation(oNPCSpwn5));
    cs_DestroyObject(15.5f, oNPCCrew5);

    // then the player and party
    cs_CameraSetFacing(17.0f, 270.0f, 8.0f, 75.0f, CAMERA_TRANSITION_TYPE_MEDIUM);
    cs_SetFacingPoint(17.0f, oKolmarr, GetPosition(oPCCopy1));
    cs_ApplyVFXToObject(18.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    cs_ActionPlayAnimation(18.0f, oPCCopy1, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
    DelayCommand(18.5, ApplyVFXEyes(oPCCopy1));
    DelayCommand(18.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon3, GetLocation(oPCCopy1)));

    cs_ApplyVFXToObject(19.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    cs_ActionPlayAnimation(19.0f, oNisar, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
    DelayCommand(19.5, ApplyVFXEyes(oNisar));
    DelayCommand(19.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon3, GetLocation(oNisar)));

    cs_ApplyVFXToObject(20.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
    cs_ActionPlayAnimation(20.0f, oGarm, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
    DelayCommand(20.5, ApplyVFXEyes(oGarm));
    DelayCommand(20.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon3, GetLocation(oGarm)));

    if (GetIsObjectValid(oPCCopy2))
    {
        cs_ApplyVFXToObject(21.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
        cs_ActionPlayAnimation(21.0f, oPCCopy2, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
        DelayCommand(21.5, ApplyVFXEyes(oPCCopy2));
        DelayCommand(21.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon3, GetLocation(oPCCopy2)));
    }
    if (GetIsObjectValid(oPCCopy3))
    {
        cs_ApplyVFXToObject(22.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
        cs_ActionPlayAnimation(22.0f, oPCCopy3, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
        DelayCommand(22.5, ApplyVFXEyes(oPCCopy3));
        DelayCommand(22.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon3, GetLocation(oPCCopy3)));
    }
    if (GetIsObjectValid(oPCCopy4))
    {
        cs_ApplyVFXToObject(23.0f, DURATION_TYPE_INSTANT, VFX_IMP_PULSE_NEGATIVE, oKolmarr);
        cs_ActionPlayAnimation(23.0f, oPCCopy4, ANIMATION_LOOPING_SPASM, 1.0f, 2.0f);
        DelayCommand(23.5, ApplyVFXEyes(oPCCopy4));
        DelayCommand(23.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon3, GetLocation(oPCCopy4)));
    }

    cs_ActionPlayAnimation(23.0f, oKolmarr, ANIMATION_LOOPING_TALK_LAUGHING, 1.0f, 6.0f);
    cs_SpeakString(24.0f, oKolmarr, sKolmarr1);

    cs_SetFacingPoint(25.0f, oPCCopy1, GetPosition(oKolmarr));
    cs_SetFacingPoint(25.4f, oNisar, GetPosition(oKolmarr));
    cs_SetFacingPoint(25.8f, oGarm, GetPosition(oKolmarr));

    cs_SpeakString(27.0f, oKolmarr, sKolmarr2);

    cs_ActionPlayAnimation(29.0f, oNisar, ANIMATION_FIREFORGET_TAUNT, 1.0f);
    cs_SpeakString(30.0f, oNisar, sNisar1);
    cs_ActionPlayAnimation(31.0f, oPCCopy1, ANIMATION_LOOPING_TALK_LAUGHING, 1.0f);

    cs_ActionPlayAnimation(32.0f, oKolmarr, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 4.0f);
    cs_SpeakString(33.0f, oKolmarr, sKolmarr3);

    cs_ActionPlayAnimation(37.0f, oKolmarr, ANIMATION_FIREFORGET_VICTORY1, 1.0f);
    cs_SpeakString(37.0f, oKolmarr, sKolmarr4);

    cs_ActionMoveToObject(39.0f, oKolmarr, oWPKolmar1, TRUE);

    cs_CameraDoFade(40.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);

    cs_JumpToObject(42.0f, cs_GetPCObject(0), oWPPlayer1_1);
    cs_JumpToObject(42.0f, cs_GetPCObject(1), oWPPlayer2_1);
    cs_JumpToObject(42.0f, cs_GetPCObject(2), oWPPlayer3_1);
    cs_JumpToObject(42.0f, cs_GetPCObject(3), oWPPlayer4_1);

    cs_JumpToObject(42.0f, oRealNisar, oWPNisar2);
    cs_JumpToObject(42.0f, oRealGarm, oWPGarm2);

    cs_DestroyObject(42.5f, oNisar);
    cs_DestroyObject(42.5f, oGarm);

    cs_DestroyObject(42.5f, oPCCopy1);
    cs_DestroyObject(42.5f, oPCCopy2);
    cs_DestroyObject(42.5f, oPCCopy3);
    cs_DestroyObject(42.5f, oPCCopy4);

    cs_EndCutscene(43.0f, TRUE, TRUE, FADE_SPEED_FASTEST);
}
