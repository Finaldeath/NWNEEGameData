// user-defined event for the Chest of the Wise
// .. basically just a few ambient animations

#include "nw_i0_generic"
#include "x0_i0_position"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// search for a living mephit with a given number
object GetMephitByNum(int n)
{
    string sTag = GetTag(OBJECT_SELF);
    int i = 1;
    object oMephit = GetNearestObjectByTag(sTag, OBJECT_SELF, i);
    while (GetIsObjectValid(oMephit))
    {
        if (!GetIsDead(oMephit))
        {
            if (GetLocalInt(oMephit, "HF_NUM") == n)
                return(oMephit);
        }
        oMephit = GetNearestObjectByTag(sTag, OBJECT_SELF, ++i);
    }
    return(OBJECT_INVALID);
}

// pick the next available mephit number (range is 1 to 4)
int ChooseMyNumber()
{
    int n = GetLocalInt(OBJECT_SELF, "HF_NUM");
    if (n != 0) return(n);

    int i;
    for (i = 1; i <= 4; i++)
    {
        object oMephit = GetMephitByNum(i);
        if (!GetIsObjectValid(oMephit))
        {
            SetLocalInt(OBJECT_SELF, "HF_NUM", i);
            break;
        }
    }
    return(i);
}

// returns a random location very close to the current location
location GetRandomCloseLocation(object oSource)
{
    location lStart = GetLocation(oSource);
    float fAngle = 30.0 + Random(120);
    float fOrient = GetFacing(oSource);
    float fDist = 0.03 + 0.01 * Random(100);
    return GenerateNewLocationFromLocation(lStart, fDist, fAngle, fOrient);
}

// move to a random nearby location
void AmbientAnimation()
{
    switch(d3())
    {
        case 1:
        {
            // move to a random location
            location lLoc = GetRandomCloseLocation(OBJECT_SELF);
            ActionMoveToLocation(lLoc);
            break;
        }
        case 2:
        {
            // set a random facing
            float fDir = 0.0 + Random(350);
            SetFacing(fDir);
            break;
        }
        case 3:
        {
            // play sound (sometimes)
            int n = d6();
            if      (n == 1) PlaySound("c_mephit_yes");
            else if (n == 2) PlaySound("c_mephit_slct");
            else if (n == 3) PlaySound("c_mephit_bat1");
            else if (n == 4) PlaySound("c_mephit_bat2");
            break;
        }
    }
}

// return to our home location
int GoHome()
{
    location lHome = GetLocalLocation(OBJECT_SELF, "HF_START_LOCATION");
    location lSelf = GetLocation(OBJECT_SELF);
    if (GetDistanceBetweenLocations(lSelf, lHome) > 1.0)
    {
        ActionMoveToLocation(lHome, TRUE);
        return(TRUE);
    }
    return(FALSE);
}

// find the nearest pillar that is ON and turn it OFF
// .. fire mephits don't do this because that would be silly
int ThrowSwitches()
{
    if (GetTag(OBJECT_SELF) != "ks_mephit_fire")
    {
        object oDest = OBJECT_INVALID;
        int i = 1;
        object oPillar = GetNearestObjectByTag("ks_pl_devpillar", OBJECT_SELF, i);
        while (GetIsObjectValid(oPillar))
        {
            if (GetLocalInt(oPillar, "nOnOff") == 1)
            {
                oDest = oPillar;
                break;
            }
            oPillar = GetNearestObjectByTag("ks_pl_devpillar", OBJECT_SELF, ++i);
        }
        if (GetIsObjectValid(oDest))
        {
            // found a switch, rush over and turn it off
            PlaySound("c_mephit_no");
            ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
            ActionMoveToObject(oDest, TRUE);
            ActionDoCommand(DoPlaceableObjectAction(oDest, PLACEABLE_ACTION_USE));
            return(TRUE);
        }
    }
    return(FALSE);
}

void Heartbeat()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
        return;

    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF) || GetIsDead(OBJECT_SELF))
        return;

    int nAction;
    ClearAllActions(TRUE);

    // 1 - look for switches to throw
    nAction = ThrowSwitches();
    if (nAction) return;

    // 2 - return to home location
    nAction = GoHome();
    if (nAction) return;

    // 3 - ambient animations
    AmbientAnimation();
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nEvent == 1)
    {
        if (!GetIsDead(OBJECT_SELF))
        {
            ClearAllActions(TRUE);
            ThrowSwitches();
        }
    }
    else if (nEvent == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        int n = ChooseMyNumber();
        object oWP = GetNearestObjectByTag("WP_AR1106_MEPHIT_HOME_" + IntToString(n));
        if (GetIsObjectValid(oWP))
        {
            SetLocalLocation(OBJECT_SELF, "HF_START_LOCATION", GetLocation(oWP));
        }
        else
        {
            SetLocalLocation(OBJECT_SELF, "HF_START_LOCATION", GetLocation(OBJECT_SELF));
        }
    }
}
