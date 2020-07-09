//::///////////////////////////////////////////////
//:: Name npe_a0_bloodperc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modified Perception system. This script will
    cause a Blood Sailor to curse at Blackriver
    bandits in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "nw_i0_generic"

const string sRand01 = "Aye, I sees you, you little Blackriver Bandit punk!";
const string sRand02 = "Who do you young Blackriver Bandits think you are anyway?";
const string sRand03 = "Run back to your mommy, Blackriver...";
const string sRand04 = "Bloody upstarts! Back in my day, the rivers were blue, dammit.";

// Check the object against the known tags of Blackriver Bandits
int IsBlackRiver(object oPreceived);

void main()
{
    object oSelf = OBJECT_SELF;
    object oPerc = GetLastPerceived();
    object oFaction = GetObjectByTag("a0_spwnbnd");

    int iFlag = FALSE;
    int iCutScene = GetLocalInt(oSelf, "A0_CUTSCENE");
    int iRand;

    if ((GetObjectType(oPerc) == OBJECT_TYPE_CREATURE)
       && (IsBlackRiver(oPerc) == TRUE)
       && (GetLastPerceptionSeen() == TRUE))
    {
            iFlag = TRUE;
            //SendMessageToPC(GetFirstPC(), "**Found Valid Match");
    }

    // If the percived object is valid, do some sort of action
    if ((iFlag == TRUE) && (iCutScene == FALSE))
    {
        // If not in combat, Sling Insults
        if (GetIsEnemy(oPerc, oSelf) == FALSE)
        {
            iRand = Random(6);
            switch(iRand)
            {
                case 0 :
                    SetFacingPoint(GetPosition(oPerc));
                    SpeakString(sRand01);
                    PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0f, 3.0f);
                break;

                case 1 :
                    SetFacingPoint(GetPosition(oPerc));
                    SpeakString(sRand02);
                    PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 3.0f);
                break;

                case 2 :
                    SetFacingPoint(GetPosition(oPerc));
                    SpeakString(sRand03);
                    PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0f, 3.0f);
                break;

                case 3 :
                    SetFacingPoint(GetPosition(oPerc));
                    SpeakString(sRand04);
                    PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 3.0f);
                break;

                default:
                    SetFacingPoint(GetPosition(oPerc));
                break;
            }
        }
        // Else, if the NPC is hostile to the Blackriver Bandit but not
        // currently in combat do a battle cry and attack
        else if (GetIsInCombat() == FALSE)
        {
            iRand = Random(5);
            switch(iRand)
            {
                case 0 :
                    PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
                break;

                case 1 :
                    PlayVoiceChat(VOICE_CHAT_BATTLECRY2);
                break;

                case 2 :
                    PlayVoiceChat(VOICE_CHAT_BATTLECRY3);
                break;

                case 3 :
                    PlayVoiceChat(VOICE_CHAT_ATTACK);
                break;

                default:
                break;
            }

            DetermineCombatRound(oPerc);
        }
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}

// Check the object against the known tags of Blackriver Bandits
int IsBlackRiver(object oPreceived)
{
    int iReturn = FALSE;
    if ((GetTag(oPreceived) == "a0_br_bandit")
      || (GetTag(oPreceived) == "a0_blkpawn1")
      || (GetTag(oPreceived) == "a0_blkpawn2")
      || (GetTag(oPreceived) == "a0_blkpawn3")
      || (GetTag(oPreceived) == "a0_blkpawn4")
      || (GetTag(oPreceived) == "a0_honeypea")
      || (GetTag(oPreceived) == "a0_bradleyblkr"))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
