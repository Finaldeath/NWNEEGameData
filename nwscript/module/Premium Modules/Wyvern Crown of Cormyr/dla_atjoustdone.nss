//::///////////////////////////////////////////////
//:: dla_atjoustdone
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation action script that fires the poison mini-cutscene if
    the player has lost a match in the 2nd tournament.

    Modified: 14th August - joust poisoning safety variable
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 14 Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"
#include "dla_i0_cutscene"
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
//    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_DONE))
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST))
    {
        if (!GetCutsceneMode(oPC))
            SetCutsceneMode(oPC, TRUE);
        AllParty("nPoisonedByBK",oPC,1);
        object oWaypoint = GetWaypointByTag("WP_IllPC");
        object oHitchingPost = GetObjectByTag(DLA_TAG_HAWKLINHITCH);
        effect eVFX = EffectVisualEffect(VFX_IMP_POISON_S);
        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
        DelayCommand(1.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 3.0)));
        DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oPC, 8.0));
        DelayCommand(3.0, AssignCommand(OBJECT_SELF, SpeakString("Is there something wrong with you?")));
        DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC));
        DelayCommand(4.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0)));
        DelayCommand(7.0, FadeToBlack(oPC, FADE_SPEED_FAST));
        DelayCommand(9.0, DLA_NoHorseTransition(oPC,oWaypoint,FALSE,TRUE,oHitchingPost));
//        DelayCommand(9.0, DLA_IntToVoid(DLA_RemoveAllHenchmenHorses(oPC, GetObjectByTag(DLA_TAG_HAWKLINHITCH))));
//        DelayCommand(9.5, AssignCommand(oPC, JumpToObject(GetWaypointByTag("WP_IllPC"))));
    }

    else if (GetCutsceneMode(oPC))
        SetCutsceneMode(oPC, FALSE);
}
