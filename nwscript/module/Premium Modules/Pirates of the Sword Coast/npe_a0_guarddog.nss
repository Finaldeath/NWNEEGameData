//::///////////////////////////////////////////////
//:: Name npe_a0_guarddog
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modified Perception system. This script will
    cause the dog in the Twenty in a quiver to
    approach a player and notify the Orc Guard
    if the Target is a player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

const string sOrcSearch01 = "What you see, doggy?";
const string sOrcSearch02 = "Stupid pooch... What all the racket about?";
const string sOrcSearch03 = "Huh? What doggy want now?";

const string sOrcQuit01 = "Must've been a cat...";
const string sOrcQuit02 = "Boss don't pay me enough...";
const string sOrcQuit03 = "Hmph! Back to nap, then...";

const string sDogBark = "Bark!";
const string sDogSniff = "Sniff sniff...";

void GuardBark(object oDog = OBJECT_SELF);
void CombatCheck(object oOrc = OBJECT_SELF);

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oPrec = GetLastPerceived();

    int iHeard = GetLastPerceptionHeard();
    int iSeen = GetLastPerceptionSeen();
    int iVanished = GetLastPerceptionVanished();

    //HAYWARD TO DO: Remove Debug text.
    //SendMessageToPC(GetFirstPC(), "DEBUG: **Dog Perceived object: " + GetName(oPrec));

    if (GetIsPC(oPrec) == TRUE)
    {
        if (iVanished == TRUE)
        {
            ClearAllActions(TRUE);
            WalkWayPoints();
            //SendMessageToPC(GetFirstPC(), "DEBUG: **Preceived object has Vanished");
        }
        else if (iSeen == TRUE)
        {
            ClearAllActions(TRUE);
            ActionMoveToObject(oPrec, FALSE, 0.7f);
            AssignCommand(oArea, GuardBark(oSelf));
            //SendMessageToPC(GetFirstPC(), "DEBUG: **Preceived object was Seen");
        }
        else if (iHeard == TRUE)
        {
            ClearAllActions(TRUE);
            ActionMoveToObject(oPrec, FALSE, 0.7f);
            SpeakString(sDogSniff);
            //SendMessageToPC(GetFirstPC(), "DEBUG: **Preceived object was Heard");
        }
        else
        {
            ClearAllActions(TRUE);
            ActionMoveToObject(oPrec, FALSE, 0.7f);
            AssignCommand(oArea, GuardBark(oSelf));
            //SendMessageToPC(GetFirstPC(), "DEBUG: **Preceived object was of no type");
        }
    }
    //ExecuteScript("nw_c2_default2", OBJECT_SELF);
}

void GuardBark(object oDog)
{
    object oOrcGuard = GetObjectByTag("a0_orcguard");
    location lDog = GetLocation(oDog);
    int iRand = Random(3);

    AssignCommand(oDog, SpeakString(sDogBark));
    AssignCommand(oDog, PlaySound("as_an_dogbark5"));

    AssignCommand(oOrcGuard, ClearAllActions(TRUE));
    AssignCommand(oOrcGuard, ActionMoveToLocation(lDog, TRUE));

    if (iRand == 1)
    {
        DelayCommand(2.0f, AssignCommand(oOrcGuard, ActionSpeakString(sOrcSearch01)));
    }
    else if (iRand == 2)
    {
        DelayCommand(2.0f, AssignCommand(oOrcGuard, ActionSpeakString(sOrcSearch02)));
    }
    else
    {
        DelayCommand(2.0f, AssignCommand(oOrcGuard, ActionSpeakString(sOrcSearch03)));
    }

    DelayCommand(15.0f, CombatCheck(oOrcGuard));
}

void CombatCheck(object oOrc)
{
    object oPost = GetObjectByTag("wp_a0_orcguard");
    int iRand = Random(3);

    if(GetIsInCombat(oOrc) == FALSE)
    {
        if (iRand == 1)
        {
            AssignCommand(oOrc, ActionSpeakString(sOrcQuit01));
        }
        else if (iRand == 2)
        {
            AssignCommand(oOrc, ActionSpeakString(sOrcQuit02));
        }
        else
        {
            AssignCommand(oOrc, ActionSpeakString(sOrcQuit03));
        }

        AssignCommand(oOrc, ActionMoveToObject(oPost, FALSE, 0.0f));
    }
    else
    {
        DelayCommand(5.0f, CombatCheck(oOrc));
    }
}
