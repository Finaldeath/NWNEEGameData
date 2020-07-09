// causes henchman to banter with the player entering this trigger
// ... use this as the onEnter script for the trigger

/*
 HF_HENCHMAN_TAG:
    set to the tag of the henchman to speak; if you don't specify this
    then a random henchman will be chosen (make sure that the comment
    number is valid for all henchmen!)
 HF_COMMENT_NUM:
    set to the number in the henchman's dialog file to speak.
 HF_ACTION:
    set to the name of a script for henchman to execute; does nothing
    if no script is specified.
 HF_REPEATING:
    normally the player gets one chance to hear the henchman speak;
    however, there are times when the henchman cannot speak (the player is
    in combat, or the henchman is dead, or stunned). set this to true
    if you want to keep giving the player chances when the trigger is
    entered (but the trigger will only "fire" once of course).
*/

#include "x0_i0_henchman"

// can this henchman move?
int IsHenchmanMoveable(object oHench)
{
    if (GetIsDead(oHench) == TRUE
        || GetHasEffect(EFFECT_TYPE_PARALYZE, oHench)
        || GetHasEffect(EFFECT_TYPE_STUNNED, oHench)
        || GetHasEffect(EFFECT_TYPE_PETRIFY, oHench)
        || GetHasEffect(EFFECT_TYPE_SLEEP, oHench)
        || GetHasEffect(EFFECT_TYPE_CONFUSED, oHench)
        || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oHench))
    {
        return FALSE;
    }
    return TRUE;
}

// jump the henchman beside the player and start talking
void DoInterjection(object oHench, object oPC)
{
    AssignCommand(oHench, ClearAllActions());
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oHench, JumpToObject(oPC));
    AssignCommand(oHench, DelayCommand(0.1, ActionStartConversation(oPC)));
}

// pick a random henchman
object GetRandomHenchman(object oPC)
{
    int i=1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        oHench = GetHenchman(oPC, ++i);
    }
    int nChoice = Random(i-1)+1;
    return(GetHenchman(oPC, nChoice));
}

// return the index string for this trigger TAG + _ + #
string GetIndexString(object oTrigger)
{
    string sHenchTag = GetLocalString(oTrigger, "HF_HENCHMAN_TAG");
    int nComment = GetLocalInt(oTrigger, "HF_COMMENT_NUM");
    string sIndex = "HF_BAN_" + sHenchTag + "_" + IntToString(nComment);
    return(sIndex);
}

// is this interjection done?
int GetIsDone(object oTrigger)
{
    string sIndex = GetIndexString(oTrigger);
    return(GetLocalInt(GetModule(), sIndex) != 0);
}

// set this interjection to done (never occur again)
// .. we use the module rather than the local object to allow more than
// .. one trigger to use the same comment number (multiple enterances to an area)
void SetIsDone(object oTrigger)
{
    string sIndex = GetIndexString(oTrigger);
    SetLocalInt(GetModule(), sIndex, 1);
}

// the henchman performs the interjection
void Interject(object oPC, object oHench)
{
    // this can only happen once
    SetIsDone(OBJECT_SELF);

    // say something
    string sText = GetName(OBJECT_SELF);
    if (sText != "")
    {
        AssignCommand(oHench, SpeakString(sText));
    }

    // start a comment dialog
    int nComment = GetLocalInt(OBJECT_SELF, "HF_COMMENT_NUM");
    if (nComment != 0)
    {
        SetLocalInt(oHench, "HF_HENCHMAN_BANTER", nComment);
        DoInterjection(oHench, oPC);
    }

    // execute any custom actions
    string sScript = GetLocalString(OBJECT_SELF, "HF_ACTION");
    if (sScript != "")
    {
        DelayCommand(0.5, ExecuteScript(sScript, oHench));
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (!GetIsDone(OBJECT_SELF))
        {
            // which henchman? choose a random one if no tag was specified
            object oHench;
            string sHenchTag = GetLocalString(OBJECT_SELF, "HF_HENCHMAN_TAG");
            if (sHenchTag == "")
            {
                oHench = GetRandomHenchman(oPC);
            }
            else
            {
                oHench = GetNearestObjectByTag(sHenchTag, oPC);
            }

            // process the trigger actions only if the henchman is valid
            if (GetIsObjectValid(oHench))
            {
                if (GetMaster(oHench) == oPC)
                {
                    if (IsHenchmanMoveable(oHench) &&
                        !GetIsInCombat(oPC) && !GetIsInCombat(oHench))
                    {
                        Interject(oPC, oHench);
                    }
                    else
                    {
                        // the henchman was in the party but couldn't talk
                        // .. should we try again later?
                        if (GetLocalInt(OBJECT_SELF, "HF_REPEATING") == 0)
                        {
                            SetIsDone(OBJECT_SELF);
                        }
                    }
                }
            }
        }
    }
}

