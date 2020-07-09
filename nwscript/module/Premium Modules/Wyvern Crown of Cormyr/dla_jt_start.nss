#include "dla_i0_joust"
#include "dla_i0_cutscene"

//starts cutscene and calls cutscene script
//created by: Takamura 10/26/2005
// Modified 30th March - switch off sound object
void main()
{
    object oPC = GetEnteringObject();
    object oInvis = GetObjectByTag("DLA_INVIS_CONV");
    float fCueTime = 0.0;
    if(GetIsPC(oPC) && GetLocalInt(oPC, DLA_VAR_JOUST_ON))
    {
        object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);

        DelayCommand(fCueTime+=2.0, FadeFromBlack(oPC));
//        MusicBackgroundStop(GetArea(oPC));
//        MusicBattlePlay(GetArea(oPC));
        SetCutsceneMode(oPC);
        AssignCommand(oPC, SetCameraFacing(100.0, 10.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP));
        DelayCommand(fCueTime+=1.5, AssignCommand(oInvis, ActionStartConversation(oPC)));
        DelayCommand(fCueTime+=0.1, SoundObjectPlay(GetObjectByTag("dla_snd_joust_booters")));
//        DelayCommand(15.0,SoundObjectStop(GetObjectByTag("DLA_CHEER_SND")));
    }
}
