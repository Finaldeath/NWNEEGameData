// userDefined event for the snorting bull who defends his cows in AR1500

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// the flock should go hostile if a non-druid player is nearby
int GetIsPlayerNearCows()
{
    object oPC = GetFirstPC();
    location lHome = GetLocalLocation(OBJECT_SELF, "HF_HOME_LOC");
    location lPC = GetLocation(oPC);
    float fDist = GetDistanceBetweenLocations(lPC, lHome);
    if (fDist <= 15.0)
    {
        if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) <= 0 &&
            GetLevelByClass(CLASS_TYPE_DRUID, oPC)  <=0)
        {
            return(TRUE);
        }
    }
    return(FALSE);
}

// make some fun cow sounds
void PlayAmbientSounds()
{
    string sSnd;
    int n = d4();
    if      (n == 1) sSnd = "as_an_cow1";
    else if (n == 2) sSnd = "as_an_cow2";
    else if (n == 3) sSnd = "as_an_cows1";
    else if (n == 4) sSnd = "as_an_cows2";
    PlaySound(sSnd);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        ClearAllActions();

        // we moo like heck if a player approaches our herd
        if (GetIsPlayerNearCows())
        {
            object oPC = GetFirstPC();
            PlaySound("c_cow_atk1");
            ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
            ActionSpeakString("The bull snorts as you approach *his* cows");
            ActionMoveToObject(oPC, TRUE);
            DelayCommand(3.0, PlaySound("c_cow_atk1"));
            return;
        }

        // we don't stray too far from home
        location lSelf = GetLocation(OBJECT_SELF);
        location lHome = GetLocalLocation(OBJECT_SELF, "HF_HOME_LOC");
        if (GetDistanceBetweenLocations(lSelf, lHome) > 1.0)
        {
            ActionMoveToLocation(lHome);
            return;
        }

        // ambient actions
        if (d4() == 1)
        {
            PlayAmbientSounds();
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
        SetLocalLocation(OBJECT_SELF, "HF_HOME_LOC", GetLocation(OBJECT_SELF));
    }
}
