#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// find an unclaimed fire and remember it
object FindMyFire()
{
    object oMyFire;
    int i = 1;

    // find the nearest unclaimed fire
    object oFire = GetNearestObjectByTag("_ar2001_fire", OBJECT_SELF, i);
    while (GetIsObjectValid(oFire))
    {
        if (GetLocalObject(oFire, "oFire") == OBJECT_INVALID)
        {
            oMyFire = oFire;
            break;
        }
        oFire = GetNearestObjectByTag("_ar2001_fire", OBJECT_SELF, ++i);
    }

    // if we didn't find a fire, claim a random one
    if (!GetIsObjectValid(oMyFire))
    {
        oMyFire = GetNearestObjectByTag("_ar2001_fire", OBJECT_SELF, Random(i)+1);
    }

    // claim this fire and remember it
    SetLocalObject(oFire, "oOwner", OBJECT_SELF);
    SetLocalObject(OBJECT_SELF, "oFire", oMyFire);
    return(oMyFire);
}

// return my fire (finds one if we don't have one assigned)
object GetMyFire()
{
    object oFire = GetLocalObject(OBJECT_SELF, "oFire");
    if (!GetIsObjectValid(oFire))
    {
        oFire = FindMyFire();
    }
    if (GetLocalObject(oFire, "oOwner") != OBJECT_SELF)
    {
        oFire = FindMyFire();
    }
    return(oFire);
}

// ambient actions to vaguely look like I'm fighting a fire
void FightFire(object oFire)
{
    // speak a random string
    string sText;
    int n = d10();
    if      (n == 1)  sText = "Ow! Hot!";
    else if (n == 2)  sText = "Dump some more water on it!";
    else if (n == 3)  sText = "Fire! Help! Fire!";
    else if (n == 4)  sText = "Put it out!";
    else if (n == 5)  sText = "Fire!";
    else if (n == 6)  sText = "Where's that water?";
    else if (n == 7)  sText = "Help me over here!";
    else if (n == 8)  sText = "Get out of my way!";
    else if (n == 9)  sText = "Help!";
    else if (n == 10) sText = "I need some help!";
    ActionSpeakString(sText, TALKVOLUME_SHOUT);

    // make sure we're not holding any weapons
    object oItem1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    ActionUnequipItem(oItem1);
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    ActionUnequipItem(oItem2);

    // play a random animation
    int nAnim;
    n = d4();
    if      (n == 1) nAnim = ANIMATION_LOOPING_GET_LOW;
    else if (n == 2) nAnim = ANIMATION_LOOPING_GET_MID;
    else if (n == 3) nAnim = ANIMATION_LOOPING_PAUSE_TIRED;
    else if (n == 4) nAnim = ANIMATION_LOOPING_TALK_FORCEFUL;
    SetFacingPoint(GetPosition(oFire));
    ActionPlayAnimation(nAnim, 1.0, 6.0);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        if (GetLocalInt(OBJECT_SELF, "nFire") != 0)
        {
            // fight fires in the basement
            object oFire = GetMyFire();
            if (GetDistanceBetween(OBJECT_SELF, oFire) > 1.5)
            {
                ActionMoveToObject(oFire, TRUE, 0.5);
            }
            else
            {
                FightFire(oFire);
            }
        }
    }
}

void Perceive()
{
    object oEnemy = GetLastPerceived();
    if (GetIsEnemy(oEnemy))
    {
        if (GetLocalInt(OBJECT_SELF, "nPerceivedEnemey") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPerceivedEnemey", 1);
            string sText;
            int n = d8();
            if      (n == 1) sText = "Intruders!";
            else if (n == 2) sText = "Get 'em!";
            else if (n == 3) sText = "Attack!";
            else if (n == 4) sText = "Spies in the castle!";
            else if (n == 5) sText = "For Lord Feldran!";
            else if (n == 6) sText = "Assassins!";
            else if (n == 7) sText = "Invaders!";
            else if (n == 8) sText = "Have at them!";
            SpeakString(sText, TALKVOLUME_SHOUT);
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
    else if (nUser == EVENT_PERCEIVE)
    {
        Perceive();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
        Heartbeat();
    }
}
