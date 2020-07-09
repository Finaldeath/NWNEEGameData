// userDefined event for ivrin the shepherd who has lost his cow

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

string GetRandomSaying()
{
    string s;
    int n = d8();
    if      (n == 1) s = "Poor Betty! She was my favorite cow!";
    else if (n == 2) s = "I sure am gonna miss that sweet ol' cow.";
    else if (n == 3) s = "That cow was too young to die.";
    else if (n == 4) s = "I sure hope ol' Betty's gone to better place.";
    else if (n == 5) s = "What am I gonna do without my sweet Betty?";
    else if (n == 6) s = "Oh, why did this have to happen to me?";
    else if (n == 7) s = "Shucks! I always treated that ol' cow right fine!";
    else if (n == 8) s = "Ah, she sure was a great cow.";
    else if (n == 9) s = "Betty was all the cow that a man could ever want!";
    else             s = "Poor Betty. We're gonna miss that ol' cow.";
    return(s);
}

// returns a torch that I have equiped (or OBJECT_INVALID if none)
object GetMyTorch()
{
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    if (GetIsObjectValid(oTorch))
    {
        if (GetBaseItemType(oTorch) == BASE_ITEM_TORCH)
        {
            return(oTorch);
        }
    }
    return(OBJECT_INVALID);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        if (GetIsDay())
        {
            // put my torch away
            object oTorch = GetMyTorch();
            if (GetIsObjectValid(oTorch))
            {
                ActionUnequipItem(oTorch);
            }
        }
        else if (GetIsNight())
        {
            // pull out my torch
            object oTorch = GetMyTorch();
            if (!GetIsObjectValid(oTorch))
            {
                oTorch = GetItemPossessedBy(OBJECT_SELF, "torch");
                if (!GetIsObjectValid(oTorch))
                {
                    oTorch = CreateItemOnObject("NW_IT_TORCH001", OBJECT_SELF, 1, "torch");
                }
                ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND);
            }
        }

        // ambient actions
        if (d4() == 1)
        {
            string q = GetLocalString(GetModule(), "QUOTE");
            string s = GetRandomSaying();
            ActionSpeakString(q+s+q);
            int nAnim = d4();
            if (nAnim == 1)
                ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
            else if (nAnim == 2)
                ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0);
            else if (nAnim == 3)
                ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 5.0);
            else if (nAnim == 4)
                ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 6.0);

            object oDog = GetNearestObjectByTag("ks_laddie");
            if (GetIsObjectValid(oDog))
            {
                AssignCommand(oDog, PlaySound("as_an_dogbark6"));
                AssignCommand(oDog, ActionSpeakString("*woof*"));
                AssignCommand(oDog, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            }
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
