//::///////////////////////////////////////////////
//:: ten_a2_tlktasina
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have the priestess and the Acolyte infrount
    of the Temple talk about Tasina.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

const string sConv1 = "So have you heard?";
const string sConv2 = "What? You mean about Tasina?";
const string sConv3 = "Yes, she has the last of the Sea Statues!";
const string sConv4 = "Sweet Umberlee! I thought it would never be found!";
const string sConv5 = "I saw her sail in aboard the Midnight Rose...";
const string sConv6 = "Did you? How did she look?";
const string sConv7 = "Tired. Only her and the sahuagin were aboard. It was as if the whole crew had disappeared...";

// this is a simple wrapper to protect the lines spoken out of dialog
void ConvWrapper(string sSpeaker, string sLine, int iAnimation);

void main()
{
    object oEnter = GetEnteringObject();
    int iDoOnce = GetLocalInt(OBJECT_SELF, "ten_a2_tlktasina");

    if ((GetIsPCNotDM(oEnter)) && (iDoOnce != TRUE))
    {
        SetLocalInt(OBJECT_SELF, "ten_a2_tlktasina", TRUE);

        DelayCommand(1.0f, ConvWrapper("a2_umbpriestdoor", sConv1, ANIMATION_FIREFORGET_GREETING));
        DelayCommand(5.3f, ConvWrapper("a2_umbacoldoor", sConv2, ANIMATION_FIREFORGET_SALUTE));
        DelayCommand(9.5f, ConvWrapper("a2_umbpriestdoor", sConv3, ANIMATION_LOOPING_TALK_NORMAL));
        DelayCommand(3.5f, ConvWrapper("a2_umbacoldoor", sConv4, ANIMATION_LOOPING_TALK_LAUGHING));
        DelayCommand(8.2f, ConvWrapper("a2_umbpriestdoor", sConv5, ANIMATION_LOOPING_TALK_PLEADING));
        DelayCommand(12.8f, ConvWrapper("a2_umbacoldoor", sConv6, ANIMATION_LOOPING_TALK_FORCEFUL));
        DelayCommand(15.0f, ConvWrapper("a2_umbpriestdoor", sConv7, ANIMATION_LOOPING_PAUSE_TIRED));
    }

}

void ConvWrapper(string sSpeaker, string sLine, int iAnimation)
{
    object oSpeaker = GetObjectByTag(sSpeaker);
    object oNPC1 = GetObjectByTag("a2_umbacoldoor");
    object oNPC2 = GetObjectByTag("a2_umbpriestdoor");
    int iStop = GetLocalInt(OBJECT_SELF, "STOP_TALKING");

    if ((IsInConversation(oNPC1) == FALSE) && (IsInConversation(oNPC1) == FALSE)
      && (iStop != TRUE))
    {
        AssignCommand(oSpeaker, SpeakString(sLine));
        AssignCommand(oSpeaker, PlayAnimation(iAnimation, 1.0f, 3.0f));
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "STOP_TALKING", TRUE);
    }
}
