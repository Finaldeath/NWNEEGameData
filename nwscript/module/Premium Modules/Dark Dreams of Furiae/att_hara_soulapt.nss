#include "ddf_util"

void main()
{
    object oEnter = GetEnteringObject();

    // Early out if a player character didn't trigger this
    if (GetIsPC(oEnter) == FALSE)
    {
        return;
    }

    int iHaraIntro = GetLocalInt(OBJECT_SELF, "HaraIntro");

    if (iHaraIntro == FALSE)
    {
        SetCutsceneMode(oEnter, TRUE);

        // Set our flag
        SetLocalInt(OBJECT_SELF, "HaraIntro", TRUE);

        // Get Harasi
        object oHara = GetObjectByTag("DDF_NPC_HarasiF");

        // Make her shout the text bubble
        AssignCommand(oHara, SpeakString("I want you all on the streets in every part of the city. Gauge interest in the districts we aren't in yet. We're expanding. You mercs keep an eye on them. One to one. I don't want anyone messing with my supply. And keep an ear out for a *real* good alchemist. Hey! Who in the Nine Hells is this?"));

        // After awile maker her go and engage the player in dialog
        DelayCommand(4.0, AssignCommand(oHara, ActionStartConversation(oEnter, "hara_001")));
        DelayCommand(4.0, SetCutsceneMode(oEnter, FALSE));
    }
}
