//::///////////////////////////////////////////////
//:: FileName con_ac_wildelve3
//:: Kylee does not go hostile and set appropriate variable
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcFade(object oPC)
{
    FadeToBlack(oPC, FADE_SPEED_FAST);
    DelayCommand(3.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
}

void main()
{
    object oPC = GetPCSpeaker();
    FloatingTextStringOnCreature("Border Dispute resolved peacefully: 500xp!", oPC);
    GiveXPToCreature(oPC, 500);
    SetLocalInt(oPC, "ac_wildelves_quest", 3);
    SetCutsceneMode(oPC, TRUE);
    SpeakString("Now I shall unblock those streams.");
    DelayCommand(2.0, ahcFade(oPC));
    DelayCommand(5.0, AssignCommand(oPC, PlaySound("as_na_watcliff")));
    DelayCommand(3.0, SoundObjectPlay(GetObjectByTag("ac_snd_stream1")));
    DelayCommand(3.0, SoundObjectPlay(GetObjectByTag("ac_snd_stream2")));
    DelayCommand(3.0, SoundObjectPlay(GetObjectByTag("ac_snd_stream3")));
    DelayCommand(3.0, SoundObjectPlay(GetObjectByTag("ac_snd_stream4")));
    int nC = 1;
    object oBlock = GetNearestObjectByTag("ac_riverblock", oPC, nC);
    while(GetIsObjectValid(oBlock))
    {
        SetPlotFlag(oBlock, FALSE);
        DestroyObject(oBlock);
        nC++;
        oBlock = GetNearestObjectByTag("ac_riverblock", oPC, nC);
    }
    DelayCommand(3.0, SetCutsceneMode(oPC, FALSE));
    SetLocalInt(GetModule(), "nWildElfStreamsUnblocked", 1);
}
