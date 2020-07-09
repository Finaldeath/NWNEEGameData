//::///////////////////////////////////////////////
//:: aen_trogcutcapt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a short cutscene where the PC is
    knocked unconcience by the stench of the
    Troglodyte cutscene. After falling, the
    screen blanks out, a short cutscene plays,
    theres a blacked out conversation, then the
    PC jumps to the Garm Fight area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_global"
#include "inc_polyflee"

const string sNausea1 = "The cloying stench of the troglodyte village overwhelms you.";
const string sNausea2 = "You fall to your knees and all goes black around you...";

void main()
{
    object oPC = GetEnteringObject();
    object oPCClone = OBJECT_INVALID;
    object oSpeaker = OBJECT_INVALID;
    string sConvStr = "";

    location lStart1 = GetLocation(GetObjectByTag("wp_a1cutstart1"));
    location lEnd = GetLocation(GetObjectByTag("wp_a1cutend"));
    location lStart2 = GetLocation(GetObjectByTag("wp_a1cutstart2"));

    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eSmoke =  EffectVisualEffect(517);
    effect eDizzy = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDizzyImp = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eNausia = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);

    if (GetIsPCNotDM(oPC) == TRUE)
    {
        sConvStr = "a1_conv" + GetPCPublicCDKey(oPC);
        oSpeaker = CreateObject(OBJECT_TYPE_PLACEABLE, "a1_convobj", lStart2, FALSE, sConvStr);

        SetCutsceneMode(oPC, TRUE);
        BlackScreen(oPC);

        oPCClone = CopyObject(oPC, lStart1);
        AssignCommand(oPCClone, JumpToLocation(lStart1));
        AssignCommand(oPC, JumpToLocation(lEnd));

        DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPC));
        DelayCommand(0.7f, AssignCommand(oPC,
            SetCameraFacing(0.0f, 14.0f, 63.0f, CAMERA_TRANSITION_TYPE_SNAP)));

        DelayCommand(1.0f, AssignCommand(oPC,
            SetCameraFacing(0.0f, 10.0f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW)));

        DelayCommand(1.0f, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));

        DelayCommand(1.0f, AssignCommand(oPCClone, ActionMoveToLocation(lEnd, TRUE)));

        DelayCommand(2.5f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDizzyImp, oPCClone));
        DelayCommand(2.5f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDizzy, oPCClone));
        DelayCommand(2.5f, AssignCommand(oPCClone, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0f, 2.0f)));

        DelayCommand(4.0f, FloatingTextStringOnCreature(sNausea1, oPC, FALSE));
        DelayCommand(4.0f, AssignCommand(oPCClone, PlayAnimation(ANIMATION_FIREFORGET_SPASM, 1.0f, 1.0f)));

        DelayCommand(5.0f, AssignCommand(oPCClone, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 99.0f)));

        DelayCommand(6.0f, FloatingTextStringOnCreature(sNausea2, oPC, FALSE));
        DelayCommand(9.0f, FadeToBlack(oPC, FADE_SPEED_SLOW));

        DelayCommand(10.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSmoke, oPCClone));

        DelayCommand(12.0f, AssignCommand(oPC, JumpToLocation(lStart2)));
        DelayCommand(12.0f, DestroyObject(oPCClone));

        DelayCommand(12.0f, AssignCommand(oPC, ActionStartConversation(
            oSpeaker, "a1_captureconv", TRUE, FALSE)));
    }
    else
    {
        // if Poly enters, make it flee
        if(GetTag(oPC)==a1c_tag_Poly)
        {
            effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oPC, 10.0);
            PolyFlee(oPC, TRUE);
        }
    }
}
