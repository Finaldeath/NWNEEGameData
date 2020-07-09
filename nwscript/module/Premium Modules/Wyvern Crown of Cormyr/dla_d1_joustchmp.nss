//::///////////////////////////////////////////////
//:: dla_d1_joustchmp
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation action script that plays the joust championship cutscene
    as determined by which tournament has been won.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 2 Mar 2006
//:://////////////////////////////////////////////

// Edit 11th July: Text spelling correction (Ben)
// Modified: 14th August - joust poisoning safety variable

#include "dla_i0_cutscene"
#include "dla_i0_joust"
#include "cu_magicspecific"
#include "cu_functions"

const string DLA_TAG_HAWKLIN = "sirgilbert";

void main()
{
    object oPC = GetPCSpeaker();
    object oHawklin = CreateObject(OBJECT_TYPE_CREATURE, DLA_TAG_HAWKLIN, GetLocation(GetWaypointByTag("WP_AwardHawklin")), FALSE, "HawklinAwarding");
    object oJoustRef = GetObjectByTag("DLA_JOUST_REF");
    SetPlotFlag(oHawklin, FALSE);
    SetImmortal(oHawklin, FALSE);
    float fCueTime = 0.0;
    int nXP = DLA_GetIsTourney(oPC, 2) ? 1500 : 500;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC, TRUE);
    DLA_SetAssociateStandGround(oPC);
    AssignCommand(oPC, ClearAllActions(TRUE));
    FadeToBlack(oPC, FADE_SPEED_FAST);
    DelayCommand(fCueTime+=2.0, AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_JoustChampion")))));
    DelayCommand(fCueTime+=0.1, FadeFromBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(fCueTime+=1.5, AssignCommand(oJoustRef, SpeakString("Presenting " + GetName(oPC) + ".")));
    DelayCommand(fCueTime+=2.0, AssignCommand(oJoustRef, SpeakString("Your Champion at the Joust!")));
    DelayCommand(fCueTime+=0.1, SoundObjectPlay(GetObjectByTag("dla_snd_joust_yays")));
    DelayCommand(fCueTime+=2.4, AssignCommand(oHawklin, SpeakString("Congratulations " + GetName(oPC) + ". You have done well.")));
    DelayCommand(fCueTime+=2.5, AssignCommand(oHawklin, SpeakString("Please accept these gifts for your fine performance on the field today.")));
    DelayCommand(fCueTime+=0.1, SoundObjectPlay(GetObjectByTag("dla_snd_joust_champ")));
    DelayCommand(fCueTime+=1.9, GetTreasureType("Jewelry", oPC, 100, 2, 1));
    DelayCommand(fCueTime+=0.1, GiveGoldToCreature(oPC, 500));
    DelayCommand(fCueTime+=0.1, GiveXPToCreature(oPC, nXP));
    if (DLA_GetStateIsSet(DLA_GetJoustState(oPC), DLA_JOUSTSTATE_T2_CHAMP))
    {
        AllParty("nPoisonedByBK",oPC,1);
        object oWaypoint = GetWaypointByTag("WP_IllPC");
        object oHitchingPost = GetObjectByTag(DLA_TAG_HAWKLINHITCH);
        effect eVFX = EffectVisualEffect(VFX_IMP_POISON_S);
        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
        DelayCommand(fCueTime+=1.8, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 3.0)));
        DelayCommand(fCueTime+=0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oPC, 8.0));
        DelayCommand(fCueTime+=1.5, AssignCommand(oHawklin, SpeakString("Are you alright " + GetName(oPC) + "?")));
        DelayCommand(fCueTime+=0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC));
        DelayCommand(fCueTime+=0.5, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0)));
        DelayCommand(fCueTime+=3.0, FadeToBlack(oPC, FADE_SPEED_FAST));
        if (DLA_GetIsMounted(oPC))
        {
            DelayCommand(fCueTime+=1.5, DLA_Dismount(oPC, FALSE));
        }

        DelayCommand(fCueTime+=0.5, DLA_NoHorseTransition(oPC,oWaypoint,FALSE,TRUE,oHitchingPost));

/* replaced by previous line
        DelayCommand(fCueTime+=0.5, DLA_IntToVoid(DLA_RemoveAllHenchmenHorses(oPC, GetObjectByTag(DLA_TAG_HAWKLINHITCH), FALSE)));
        object oWaypoint = GetWaypointByTag("WP_IllPC");
        DelayCommand(fCueTime+=0.5, AssignCommand(oPC, JumpToObject(oWaypoint)));
        object oAssoc;
        int i = 1;
        while (GetIsObjectValid(oAssoc = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,i)))
        {
            if (!DLA_GetIsDLAHorse(oAssoc))
            {
                DelayCommand(fCueTime+=0.01, AssignCommand(oAssoc, JumpToObject(oWaypoint)));
            }
            i++;
        }
 */
        DelayCommand(fCueTime+=0.5, DestroyObject(oHawklin));
    }
    else
    {
        DelayCommand(fCueTime+=1.8, FadeToBlack(oPC, FADE_SPEED_MEDIUM));
        DelayCommand(fCueTime+=1.0, DestroyObject(oHawklin));
        DelayCommand(fCueTime+=0.5, AssignCommand(oPC, JumpToObject(GetObjectByTag("WP_JoustDone"))));
        DelayCommand(fCueTime+=0.5, DLA_SetAssociatesFollow(oPC));
        DelayCommand(fCueTime+=0.1, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
        DelayCommand(fCueTime+=0.1, SetCutsceneMode(oPC, FALSE));
    }
    DelayCommand(fCueTime+=2.0, SoundObjectStop(GetObjectByTag("dla_snd_joust_champ")));
    DelayCommand(fCueTime+=1.0, SoundObjectStop(GetObjectByTag("dla_snd_joust_yays")));
}
