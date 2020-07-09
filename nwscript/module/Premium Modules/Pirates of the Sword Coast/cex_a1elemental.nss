//::///////////////////////////////////////////////
//:: cex_a1elemental
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script end the cutscene with Edgrimm's
    Fire Elemental Avatar in the Jungle area.
    The monster disapears and the players exit
    cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
void FinishCutscene();

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    AssignCommand(oArea, FinishCutscene());
}

void FinishCutscene()
{
    object oArea = OBJECT_SELF;
    object oPCCopy0 = GetLocalObject(oArea, "a1_oPCCopy0");
    object oPCCopy1 = GetLocalObject(oArea, "a1_oPCCopy1");
    object oPCCopy2 = GetLocalObject(oArea, "a1_oPCCopy2");
    object oPCCopy3 = GetLocalObject(oArea, "a1_oPCCopy3");
    object oMonster = GetLocalObject(oArea, "a1_oMonster");
    object oFireTarg02 = GetObjectByTag("a1_CutTarg02");

    effect eDisapear = EffectDisappear();

    cs_ApplyVFXToObject(1.0f, DURATION_TYPE_INSTANT, VFX_FNF_IMPLOSION, oFireTarg02);
    cs_ApplyEffectToObject(1.2f, DURATION_TYPE_PERMANENT, eDisapear, oMonster);
    cs_CameraNightToDay(1.2f, 5.0f);

    cs_CameraDoFade(4.0f, CS_FADE_TYPE_TO_BLACK);

    cs_DestroyObject(6.0f, oPCCopy0);
    cs_DestroyObject(6.0f, oPCCopy1);
    cs_DestroyObject(6.0f, oPCCopy2);
    cs_DestroyObject(6.0f, oPCCopy3);

    cs_EndCutscene(6.5f, FALSE, TRUE);
}
