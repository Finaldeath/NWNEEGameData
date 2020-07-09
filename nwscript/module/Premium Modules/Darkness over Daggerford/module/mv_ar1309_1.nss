// this is the cutscene where hester talks to her parrot

#include "hf_in_cutscene"
#include "hf_in_util"

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1309_CUT1_START");
}

// parrot and hester bicker
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oParrot = GetObjectInArea("ks_druid_parrot", oPC);
    object oHester = GetObjectInArea("ks_hester", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, 50.0, 1.0, 88.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oParrot, PlaySound("c_parrot_bat3"));
        AssignCommand(oParrot, ActionSpeakString(q+"By Mielikki, I said *brwack* that you must set me FREE!"+q));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oHester, ActionSpeakString(q+"I am pretty? Oh, you are such a darling creature!"+q));
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        AssignCommand(oParrot, PlaySound("c_parrot_bat2"));
        AssignCommand(oParrot, ActionSpeakString(q+"Arrraghhh *brwack!* I’m not a *brwack* PARROT!"+q));
        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        AssignCommand(oHester, ActionSpeakString(q+"Carrot? You can’t eat a carrot, you silly bird!"+q));
        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        AssignCommand(oParrot, PlaySound("c_parrot_bat1"));
        AssignCommand(oParrot, ActionSpeakString(q+"For the hundredth time, my name is Wanix, not WOLLY!"+q));
        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        AssignCommand(oHester, ActionSpeakString(q+"My little bird can say Wolly! Yes, that’s your name! Wolly want a quacker?"+q));
        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        CutsceneEnd();
    }
}

// nothing to do here
void end()
{
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
