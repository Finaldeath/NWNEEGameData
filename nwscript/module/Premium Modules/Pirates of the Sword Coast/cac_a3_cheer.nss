//::///////////////////////////////////////////////
//:: cac_a3_cheer
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Everyone around the PC cheers.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    object oCursor = GetFirstObjectInArea(oArea);

    int iCycle = 0;
    float fRand;
    // Everyone around the PC acts confused.
    while(GetIsObjectValid(oCursor) == TRUE)
    {
        if ((GetObjectType(oCursor) == OBJECT_TYPE_CREATURE)
          && (GetIsPC(oCursor) == FALSE) // pc's shouldn't do this
          && (GetTag(oCursor) != "pccopy") // pc copies shouldn't do this
          && (GetTag(oCursor) != a1c_tag_Garm) // real (invisible) Garm shouldn't do this
          && (GetTag(oCursor) != a2c_tag_Nisar)) // real (invisible) Nisar shouldn't do this
        {
            fRand = Random(10) * 0.1;
            switch (iCycle)
            {
                case (0):
                    DelayCommand(1.1f + fRand,
                        PlayAnimation_SafeForCrew(oCursor, ANIMATION_FIREFORGET_VICTORY1));
                    DelayCommand(1.3f + fRand, AssignCommand(oCursor,
                        PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
                   iCycle++;
                break;
                case (1):
                    DelayCommand(1.0f + fRand,
                        PlayAnimation_SafeForCrew(oCursor, ANIMATION_FIREFORGET_VICTORY2));
                    DelayCommand(1.2f + fRand, AssignCommand(oCursor,
                        PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
                   iCycle++;
                break;
                case (2):
                    DelayCommand(1.2f + fRand,
                        PlayAnimation_SafeForCrew(oCursor, ANIMATION_FIREFORGET_VICTORY3));
                    DelayCommand(1.4f + fRand, AssignCommand(oCursor,
                        PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
                   iCycle++;
                break;
                case (3):
                    DelayCommand(1.3f + fRand,
                        PlayAnimation_SafeForCrew(oCursor, ANIMATION_FIREFORGET_VICTORY2));
                    DelayCommand(1.5f + fRand, AssignCommand(oCursor,
                        PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
                    iCycle++;
                break;
                default:
                    DelayCommand(1.4f + fRand,
                        PlayAnimation_SafeForCrew(oCursor, ANIMATION_FIREFORGET_VICTORY1));
                    DelayCommand(1.6f + fRand, AssignCommand(oCursor,
                        PlayVoiceChat(VOICE_CHAT_CHEER, oCursor)));
                    iCycle = 0;
                break;
            }
        }
        oCursor = GetNextObjectInArea(oArea);
    }
}
