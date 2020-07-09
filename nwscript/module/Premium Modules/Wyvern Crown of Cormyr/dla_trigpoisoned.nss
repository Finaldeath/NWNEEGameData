


// dla_trigpoisoned
// A safety trigger in the jousting area to fire the cutscene if the PC is poisoned but tries to leave
// the area without a resolution in jousting 2 (i.e. part way through)

#include "dla_i0_joust"
#include "dla_i0_cutscene"
#include "cu_functions"

void main()
{
        object oPC = GetEnteringObject();
        if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nPoisonedByBK")>0)
    {
        if (!GetCutsceneMode(oPC))
            SetCutsceneMode(oPC, TRUE);
        object oWaypoint = GetWaypointByTag("WP_IllPC");
        object oHitchingPost = GetObjectByTag(DLA_TAG_HAWKLINHITCH);
        effect eVFX = EffectVisualEffect(VFX_IMP_POISON_S);
        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);

        // Handle joust state as if we lost to our second opponent (closes joust)
        int nJoustState = DLA_JOUSTSTATE_T1_STARTED |
                      DLA_JOUSTSTATE_T1_1 |
                      DLA_JOUSTSTATE_T1_2 |
                      DLA_JOUSTSTATE_T1_LOST |
                      DLA_JOUSTSTATE_T1_DONE |
                      DLA_JOUSTSTATE_T2_STARTED |
                      DLA_JOUSTSTATE_T2_LOST;
        DeleteLocalInt(oPC, DLA_VAR_JOUST_STATE);
        DLA_SetJoustState(oPC, nJoustState);
        DLA_SetTourneyWins(oPC, 0);
        DLA_SetTourneyMatches(oPC, 0);

    nJoustState = DLA_GetJoustState(oPC);
    int bJoust2 = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED);
    int bJoust1Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST);
    int bJoust2Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST);
    SetLocalInt(oPC, DLA_VAR_JOUST_OPP_SET, DLA_OPPONENT_SET_TOURNEY);
    if (bJoust2)
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_1);
        if (!bJoust2Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_2);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_DONE);
    }
    else
    {
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_1);
        if (!bJoust1Lost)
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_2);
        else
            DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);
    }
    if ((bJoust2 && !bJoust2Lost) || (!bJoust2 && !bJoust1Lost))
    {
        DLA_SetTourneyWins(oPC, 2);
        DLA_SetTourneyMatches(oPC, 2);
    }
    else
    {
        DLA_SetTourneyWins(oPC, 0);
        DLA_SetTourneyMatches(oPC, 0);
    }


        //Handle cutscene poisoning the player and sending them to Hawklin Castle
        DelayCommand(1.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 3.0)));
        DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oPC, 8.0));
//        DelayCommand(3.0, AssignCommand(OBJECT_SELF, SpeakString("Is there something wrong with you?")));
        DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC));
        DelayCommand(4.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0)));
        DelayCommand(7.0, FadeToBlack(oPC, FADE_SPEED_FAST));
        DelayCommand(9.0, DLA_NoHorseTransition(oPC,oWaypoint,FALSE,TRUE,oHitchingPost));
//        DelayCommand(9.0, DLA_IntToVoid(DLA_RemoveAllHenchmenHorses(oPC, GetObjectByTag(DLA_TAG_HAWKLINHITCH))));
//        DelayCommand(9.5, AssignCommand(oPC, JumpToObject(GetWaypointByTag("WP_IllPC"))));
        DestroyObject(OBJECT_SELF,12.0);
    }

}
