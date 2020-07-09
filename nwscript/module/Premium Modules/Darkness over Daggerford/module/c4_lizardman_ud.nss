// user defined event for lizardman
// this is a slim version of the standard cs_ambient_ud script in the HF
// .. equip random items
// .. go hostile if player is not polymorphed as a lizard
// .. general ambient AI in village (waypoints with actions)

#include "nw_i0_generic"
#include "inc_polymorph"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// --------------------------------------------------------------------
// ---------------------------- ACTIONS -------------------------------
// --------------------------------------------------------------------

// action performed when a destination is reached
void ActionDestinationAction(object oNPC=OBJECT_SELF)
{
    // play a cached sound
    string sSound = GetLocalString(oNPC, "HF_DESTINATION_SOUND");
    if (sSound != "")
    {
        DeleteLocalString(oNPC, "HF_DESTINATION_SOUND");
        PlaySound(sSound);
    }

    // perform an animation action
    string sType = GetLocalString(oNPC, "HF_DESTINATION_ACTION");
    if ( sType != "")
    {
        DeleteLocalString(oNPC, "HF_DESTINATION_ACTION");
        if (sType == "LOW")
        {
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0);
        }
        else if (sType == "LOOK")
        {
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 5.0);
        }
        else if (sType == "DRINK")
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 4.0);
        }
        else if (sType == "PRAY")
        {
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 5.0);
        }
        else if (sType == "TALK")
        {
            SpeakOneLinerConversation();
        }
    }

    return;
}

// --------------------------------------------------------------------
// ---------------------------- WALKING -------------------------------
// --------------------------------------------------------------------

// walk to a destination location
void SetIsWalking(location lLoc, int nRun, object oNPC=OBJECT_SELF)
{
    SetLocalInt(oNPC, "HF_IS_WALKING", 30);
    SetLocalLocation(oNPC, "HF_WALK_DEST", lLoc);
    ActionMoveToLocation(lLoc, nRun);
}

// stop walking
void ClearIsWalking(object oNPC=OBJECT_SELF)
{
    DeleteLocalInt(oNPC, "HF_IS_WALKING");
    DeleteLocalLocation(oNPC, "HF_WALK_DEST");
}

// check if we are still walking to our destination
int GetIsWalking(object oNPC=OBJECT_SELF)
{
    location lLoc = GetLocalLocation(oNPC, "HF_WALK_DEST");
    int nWalking = GetLocalInt(oNPC, "HF_IS_WALKING");
    if (nWalking > 0)
    {
        if (GetDistanceBetweenLocations(GetLocation(oNPC), lLoc) <= 1.0)
        {
            // we have arrived at our destination, so stop walking
            ClearIsWalking(oNPC);
            SetFacing(GetFacingFromLocation(lLoc));
            ActionDestinationAction(oNPC);
            nWalking = FALSE;
        } else {
            // still going, nudge us in case someone blocked us along the way
            if (nWalking == 1) nWalking = 0;
            SetLocalInt(oNPC, "HF_IS_WALKING", --nWalking);
            ClearAllActions();
            ActionMoveToLocation(lLoc);
        }
    } else if (nWalking < 0) {
        // timer expired, might be stuck somewhere, try teleport
        JumpToLocation(lLoc);
        ClearIsWalking(oNPC);
    }
    return(nWalking);
}

// --------------------------------------------------------------------
// ---------------------------- ROUTES --------------------------------
// --------------------------------------------------------------------

// construct a route tag from a name and a current number
string MakeRouteTag(string sName, int nCur)
{
    if (nCur <= 9)
        return("WP_PATH_" + sName + "_0" + IntToString(nCur));
    else
        return("WP_PATH_" + sName + "_" +  IntToString(nCur));
}

// cache waypoints on object
void RouteCacheWaypoints()
{
    string sRoute = GetTag(OBJECT_SELF);
    int i = 1;
    if (sRoute != "")
    {
        while (1)
        {
            string sTag = MakeRouteTag(sRoute, i);
            object oWP = GetWaypointByTag(sTag);
            if (GetIsObjectValid(oWP))
            {
                SetLocalLocation(OBJECT_SELF, "HF_" + sTag, GetLocation(oWP));
                string sAction = GetLocalString(oWP, "HF_PATH_ACTION");
                if (sAction != "")
                    SetLocalString(OBJECT_SELF, "HF_" + sTag + "_ACTION", sAction);
                string sSound = GetLocalString(oWP, "HF_PATH_SOUND");
                if (sSound != "")
                    SetLocalString(OBJECT_SELF, "HF_" + sTag + "_SOUND", sSound);
                i++;
            } else {
                break;
            }
        }
    }
    SetLocalInt(OBJECT_SELF, "HF_WP_COUNT", i-1);
}

// do we have a route?
int RouteIsValid(object oNPC=OBJECT_SELF)
{
    return(GetLocalInt(oNPC, "HF_WP_COUNT") != 0);
}

// remove the NPC's route
void RemoveRoute(object oNPC=OBJECT_SELF)
{
    DeleteLocalInt(oNPC, "HF_WP_COUNT");
    DeleteLocalInt(oNPC, "HF_WP_CUR");
    DeleteLocalInt(oNPC, "HF_WP_DIR");
}

// walk to the next waypoint in the chain
// nWrap =  0 -- follow waypoints like this: 1, 2, 3, 2, 1.
// nWrap =  1 -- follow waypoints like this: 1, 2, 3, 1, 2, 3.
// nWrap = -1 -- follow waypoints like this: 1, 2, 3.
void RouteWalkToNextWaypoint(int nWrap=0, int nRun=FALSE)
{
    int nCount = GetLocalInt(OBJECT_SELF, "HF_WP_COUNT");
    if (nCount == 0)
        return;

    int nCur = GetLocalInt(OBJECT_SELF, "HF_WP_CUR");
    int nDir = GetLocalInt(OBJECT_SELF, "HF_WP_DIR");
    if (nDir >= 0)
    {
        // walking forwards, check if we've reached the end
        nCur++;
        if (nCur > nCount)
        {
            if (nWrap == 0)
            {
                // walked forwards to the end, so turn around and go backwards
                nCur = nCount - 1;
                nDir = -1;
            } else if (nWrap == -1) {
                // walked forwards to the end, and stop
                RemoveRoute();
                return;
            } else {
                // walked forwards to the end, wrap to beginning
                nCur = 2;
                nDir = 0;
            }
        }
    } else {
        // walking backwards, check if we've reached the end
        nCur--;
        if (nCur <= 0)
        {
            if (nWrap == 0)
            {
                // walked backwards to the start, so turn around and go forwards
                nCur = 2;
                nDir = 0;
            } else if (nWrap == -1) {
                // walked backwards to the end, and stop
                RemoveRoute();
                return;
            } else {
                // walked backwards to the start, wrap to end
                nCur = nCount - 1;
                nDir = -1;
            }
        }
    }
    SetLocalInt(OBJECT_SELF, "HF_WP_DIR", nDir);
    SetLocalInt(OBJECT_SELF, "HF_WP_CUR", nCur);

    // walk to the next waypoint
    string sTag = "HF_" + MakeRouteTag(GetTag(OBJECT_SELF), nCur);
    string sAction = GetLocalString(OBJECT_SELF, sTag + "_ACTION");
    if (sAction != "")
        SetLocalString(OBJECT_SELF, "HF_DESTINATION_ACTION", sAction);
    string sSound = GetLocalString(OBJECT_SELF, sTag + "_SOUND");
    if (sSound != "")
        SetLocalString(OBJECT_SELF, "HF_DESTINATION_SOUND", sSound);
    SetIsWalking(GetLocalLocation(OBJECT_SELF, sTag), nRun);
}

// --------------------------------------------------------------------
// ---------------------------- CUSTOM --------------------------------
// --------------------------------------------------------------------

// lizardmen go hostile if they see an unpolymorphed player
// .. of course they only go hostile once
void Percieve()
{
    object oPC = GetLastPerceived();
    if (!GetIsInCombat(OBJECT_SELF))
    {
        if (GetIsPC(oPC))
        {
            if (GetLocalInt(GetModule(), "nLizardPolymorphCheck") == 0)
            {
                if (!IsPolymorphed(oPC))
                {
                    SetLocalInt(GetModule(), "nLizardPolymorphCheck", 1);
                    AdjustReputation(oPC, OBJECT_SELF, -100);
                    DetermineCombatRound(oPC);
                }
            }
        }
    }
}

// lizardmen go hostile if they see an unpolymorphed player
// .. of course they only go hostile once
void Heartbeat()
{
    // do nothing if we're busy
    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF))
    {
        return;
    }

    // walk our waypoints
    if (RouteIsValid())
    {
        if (!GetIsWalking())
        {
            RouteWalkToNextWaypoint();
        }
    }

    // check if there's an unpolymorphed player nearby
    if (GetLocalInt(GetModule(), "nLizardPolymorphCheck") == 0)
    {
        object oPC = GetFirstPC();
        if (GetObjectSeen(oPC))
        {
            if (!IsPolymorphed(oPC))
            {
                ClearAllActions();
                SetLocalInt(GetModule(), "nLizardPolymorphCheck", 1);
                AdjustReputation(oPC, OBJECT_SELF, -100);
                DetermineCombatRound(oPC);
            }
        }
    }
}

// equip a random weapon (and maybe a shield) for some variety
void EquipRandomItems()
{
    // do nothing if we are already holding a weapon
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oWeapon))
    {
        return;
    }

    // equip a weapon
    string s;
    int n = d4();
    if      (n == 1) s = "nw_wblcl001"; // club
    else if (n == 2) s = "nw_wswsc001"; // scimitar
    else if (n == 3) s = "nw_waxhn001"; // hand ax
    else if (n == 4) s = "nw_wplss001"; // spear
    oWeapon = CreateItemOnObject(s);
    ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND);
    SetDroppableFlag(oWeapon, FALSE);
    // maybe equip a shield
    if (n < 3)
    {
        string s = "";
        int n = d3();
        if      (n == 1) s = "nw_ashsw001"; // small shield
        else if (n == 2) s = "nw_ashlw001"; // large shield
        if (s != "")
        {
            object oShield = CreateItemOnObject(s);
            ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
            SetDroppableFlag(oShield, FALSE);
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
    if (nUser == EVENT_PERCEIVE)
    {
        Percieve();
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        EquipRandomItems();
        RouteCacheWaypoints();
    }
}

/*
VARIABLES:

OBJECT:
 nothing to set here

WAYPOINT: each chain is named WP_PATH_<TAG>_01, WP_PATH_<TAG>_02, ...
 - string HF_PATH_SOUND  = name of sound file to play
 - string HF_PATH_ACTION = name of action to perform
    LOOK
    LOW
    PRAY
    DRINK
    TALK
*/
