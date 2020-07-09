#include "nw_i0_generic"
#include "hf_in_shouts"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// ====================================================================
// ================== STATES: BUSY, WALK, USE =========================
// ====================================================================

int HasRoute(object oNPC=OBJECT_SELF);
int ActionDestinationAction(object oNPC=OBJECT_SELF);

// return creature's current job
string GetJob(object oNPC=OBJECT_SELF)
{
    return(GetLocalString(oNPC, "HF_JOB"));
}

// mark yourself as busy for a while
void SetIsBusy(float fDur, object oNPC=OBJECT_SELF)
{
    SetLocalInt(oNPC, "HF_IS_BUSY", 1);
    DelayCommand(fDur, SetLocalInt(oNPC, "HF_IS_BUSY", 0));
}

// is this creature busy doing something?
int GetIsBusy(object oNPC=OBJECT_SELF)
{
    return(GetLocalInt(oNPC, "HF_IS_BUSY"));
}

// pause along a route
void SetIsPaused(object oNPC=OBJECT_SELF)
{
    int nDur = GetLocalInt(oNPC, "HF_ROUTE_PAUSE");
    if (nDur > 0)
    {
        SetLocalInt(oNPC, "HF_IS_PAUSED", 1);
        DelayCommand(IntToFloat(nDur), SetLocalInt(oNPC, "HF_IS_PAUSED", 0));
    }
}

// are we paused along our route somewhere?
int GetIsPaused(object oNPC=OBJECT_SELF)
{
    return(GetLocalInt(oNPC, "HF_IS_PAUSED"));
}

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
        if (GetDistanceBetweenLocations(GetLocation(oNPC), lLoc) <= 5.0)
        {
            // we have arrived at our destination, so stop walking
            ClearIsWalking(oNPC);
            SetIsPaused(oNPC);
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

// mark this object as used so that we don't keep trying to use it
void SetIsUsed(object oThing, float fDur=-1.0, object oNPC=OBJECT_SELF)
{
    if (fDur < 0.0)
    {
        fDur = 100.0 + Random(25);
    }
    string sVar = "HF_USED_" + ObjectToString(oNPC);
    SetLocalInt(oThing, sVar, 1);
    DelayCommand(fDur, DeleteLocalInt(oThing, sVar));
    SetLocalInt(oThing, "HF_BUSY", 1);
    DelayCommand(20.0, DeleteLocalInt(oThing, "HF_BUSY"));
}

// is this object safe to use?
int GetIsUsed(object oThing, object oNPC=OBJECT_SELF)
{
    string sVar = "HF_USED_" + ObjectToString(oNPC);
    if (GetLocalInt(oThing, sVar) || GetLocalInt(oThing, "HF_BUSY"))
        return(TRUE);
    return(FALSE);
}

// go to sleep
void SetIsAsleep(object oPlace, object oNPC=OBJECT_SELF)
{
    float fDur = 30.0;
    if (GetIsNight())
    {
        fDur = 360.0;
    }
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSleep(), oNPC, fDur));
}

// is this creature asleep?
int GetIsAsleep(object oNPC=OBJECT_SELF)
{
    if (GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
        if(d10() > 6)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }
        return(TRUE);
    }
    return(FALSE);
}

// try to attend a meeting (or not)
int SetIsAttending(object oMeeting, int nAttend, object oNPC=OBJECT_SELF)
{
    if (GetIsObjectValid(oMeeting))
    {
        int nCrowd = GetLocalInt(oMeeting, "HF_MEETING_CROWD");
        string sVar = "HF_ATTEND_" + ObjectToString(oNPC);
        if (nAttend)
        {
            if (nCrowd <= 4)
            {
                SetLocalInt(oMeeting, "HF_MEETING_CROWD", ++nCrowd);
                SetLocalInt(oMeeting, sVar, 1);
                return(TRUE);
            }
        } else {
            SetIsUsed(oMeeting, 50.0, oNPC);
            SetLocalInt(oMeeting, "HF_MEETING_CROWD", --nCrowd);
            DeleteLocalInt(oMeeting, sVar);
        }
    }
    return(FALSE);
}

// are we attending a meeting? if not, try to attend
int GetIsAttending(object oMeeting, object oNPC=OBJECT_SELF)
{
    if (GetIsObjectValid(oMeeting))
    {
        // are we already attending this meeting?
        string sVar = "HF_ATTEND_" + ObjectToString(oNPC);
        if (GetLocalInt(oMeeting, sVar))
            return(TRUE);

        // only guards are allowed to attend crisis
        if (GetLocalString(oMeeting, "HF_MEETING_TYPE") == "CRISIS" &&
            GetJob(oNPC) != "GUARD")
                return(FALSE);

        // people with routes ignore meetings
        if (HasRoute(oNPC))
            return(FALSE);

        // merchants won't leave their stores to attend meetings
        if (GetJob() == "MERCHANT")
            return(FALSE);

        // try to attend this meeting
        return(SetIsAttending(oMeeting, TRUE, oNPC));
    }
    return(FALSE);
}

// if we are mute we shouldn't talk
int GetIsMute(object oNPC)
{
    return(GetHasEffect(EFFECT_TYPE_SILENCE, oNPC) ||
           GetLocalInt(oNPC, "HF_ATTR_MUTE") != 0);
}

// ====================================================================
// =============================== SPAWN ==============================
// ====================================================================

// set a random appearance to make a crowd look sort of realistic
void SetRandomAppearance(object oNPC)
{
    int nType;
    int nRnd = Random(13);
    if (GetGender(oNPC) == GENDER_FEMALE)
    {
        if      (nRnd == 0)  nType = APPEARANCE_TYPE_FEMALE_01;
        else if (nRnd == 1)  nType = APPEARANCE_TYPE_FEMALE_02;
        else if (nRnd == 2)  nType = APPEARANCE_TYPE_FEMALE_03;
        else if (nRnd == 3)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_02;
        else if (nRnd == 4)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_04;
        else if (nRnd == 5)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_06;
        else if (nRnd == 6)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_09;
        else if (nRnd == 7)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_11;
        else if (nRnd == 8)  nType = APPEARANCE_TYPE_HUMAN_NPC_FEMALE_12;
        else if (nRnd == 9)  nType = APPEARANCE_TYPE_WAITRESS;
        else if (nRnd == 10) nType = APPEARANCE_TYPE_OLD_WOMAN;
        else if (nRnd == 11) nType = APPEARANCE_TYPE_PROSTITUTE_01;
        else if (nRnd == 12) nType = APPEARANCE_TYPE_PROSTITUTE_02;
    }
    else
    {
        if      (nRnd == 0)  nType = APPEARANCE_TYPE_BARTENDER;
        else if (nRnd == 1)  nType = APPEARANCE_TYPE_BLOOD_SAILER;
        else if (nRnd == 2)  nType = APPEARANCE_TYPE_HUMAN_NPC_MALE_02;
        else if (nRnd == 3)  nType = APPEARANCE_TYPE_HUMAN_NPC_MALE_06;
        else if (nRnd == 4)  nType = APPEARANCE_TYPE_HUMAN_NPC_MALE_15;
        else if (nRnd == 5)  nType = APPEARANCE_TYPE_HUMAN_NPC_MALE_17;
        else if (nRnd == 6)  nType = APPEARANCE_TYPE_HUMAN_NPC_MALE_18;
        else if (nRnd == 7)  nType = APPEARANCE_TYPE_INN_KEEPER;
        else if (nRnd == 8)  nType = APPEARANCE_TYPE_MALE_01;
        else if (nRnd == 9)  nType = APPEARANCE_TYPE_MALE_02;
        else if (nRnd == 10) nType = APPEARANCE_TYPE_MALE_03;
        else if (nRnd == 11) nType = APPEARANCE_TYPE_SHOP_KEEPER;
        else if (nRnd == 12) nType = APPEARANCE_TYPE_OLD_MAN;
    }
    SetCreatureAppearanceType(oNPC, nType);
}

// give him a random possessions to keep rogues happy
void SetRandomPossessions(object oNPC, int nLootable=FALSE)
{
    CreateItemOnObject("nw_it_gold001", oNPC, d4(1)); // coins

    string sTag;
    int nRnd = Random(6);
    if      (nRnd == 0) sTag = "nw_it_mring021";   // copper ring
    else if (nRnd == 1) sTag = "nw_it_mneck020";   // copper necklace
    else if (nRnd == 2) sTag = "nw_it_thnmisc003"; // empty spirits bottle
    else if (nRnd == 3) sTag = "nw_it_torch001";   // torch
    else if (nRnd == 4) sTag = "nw_it_msmlmisc21"; // rags
    else if (nRnd == 5) sTag = "nw_it_msmlmisc11"; // quartz crystal
    object oItem = CreateItemOnObject(sTag, oNPC, 1);
    SetPickpocketableFlag(oItem, TRUE);
    SetDroppableFlag(oItem, nLootable);
    SetLootable(oNPC, nLootable);
}

// ====================================================================
// =============================== ROUTES =============================
// ====================================================================

// construct a route tag from a name and a current number
string MakeRouteTag(string sName, int nCur)
{
    if (nCur <= 9)
        return("WP_" + sName + "_0" + IntToString(nCur));
    else
        return("WP_" + sName + "_" +  IntToString(nCur));
}

// cache waypoints on object
void InitRoute()
{
    string sRoute = GetLocalString(OBJECT_SELF, "HF_ROUTE_NAME");
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
                string sAction = GetLocalString(oWP, "HF_SCRIPT");
                if (sAction != "")
                    SetLocalString(OBJECT_SELF, "HF_" + sTag + "_ACTION", sAction);
                i++;
            } else {
                break;
            }
        }
    }
    SetLocalInt(OBJECT_SELF, "HF_WP_COUNT", i-1);
}

// do we have a route?
int HasRoute(object oNPC=OBJECT_SELF)
{
    return(GetLocalString(oNPC, "HF_ROUTE_NAME") != "");
}

// remove the NPC's route
void RemoveRoute(object oNPC=OBJECT_SELF)
{
    DeleteLocalString(oNPC, "HF_ROUTE_NAME");
    DeleteLocalInt(oNPC, "HF_WP_COUNT");
    DeleteLocalInt(oNPC, "HF_WP_CUR");
    DeleteLocalInt(oNPC, "HF_WP_DIR");
}

// walk to the next waypoint in the chain
// nWrap =  0 -- follow waypoints like this: 1, 2, 3, 2, 1.
// nWrap =  1 -- follow waypoints like this: 1, 2, 3, 1, 2, 3.
// nWrap = -1 -- follow waypoints like this: 1, 2, 3.
void WalkRoute(int nWrap=0, int nRun=FALSE)
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

    string sTag = "HF_" + MakeRouteTag(GetLocalString(OBJECT_SELF, "HF_ROUTE_NAME"), nCur);
    SetIsWalking(GetLocalLocation(OBJECT_SELF, sTag), nRun);

    string sAction = GetLocalString(OBJECT_SELF, sTag + "_ACTION");
    if (sAction != "")
        SetLocalString(OBJECT_SELF, "HF_DESTINATION_ACTION", sAction);
}

// ====================================================================
// ============================= ACTIONS ==============================
// ====================================================================

// action performed when a destination is reached
int ActionDestinationAction(object oNPC=OBJECT_SELF)
{
    string sName = GetLocalString(oNPC, "HF_DESTINATION_ACTION");
    if ( sName != "")
    {
        DeleteLocalString(oNPC, "HF_DESTINATION_ACTION");
        ExecuteScript(sName, oNPC);
        return(TRUE);
    }
    return(FALSE);
}

// interact with a placeable
void UsePlaceable(object oPlace)
{
    string sType = GetLocalString(oPlace, "HF_ACTION_TYPE");
    ActionDoCommand(SetFacingPoint(GetPosition(oPlace)));

    if (sType == "FACE")
    {
        if(d2() == 1)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        }
    }
    else if (sType == "OPEN")
    {
        float fDur = 2.0;
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fDur);
        if(GetIsOpen(oPlace))
        {
            DelayCommand(fDur,
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE, 1.0, fDur)));
        }
        else
        {
            DelayCommand(fDur,
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, fDur)));
        }
    }
    else if (sType == "ACTIVATE")
    {
        float fDur = 2.0;
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fDur);
        if(GetLocalInt(oPlace, "HF_ACTIVATED") == 0)
        {
            SetLocalInt(oPlace, "HF_ACTIVATED", 1);
            DelayCommand(fDur,
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0, fDur)));
        }
        else
        {
            SetLocalInt(oPlace, "HF_ACTIVATED", 0);
            DelayCommand(fDur,
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE, 1.0, fDur)));
        }
    }
    else if (sType == "READ")
    {
        ActionWait(1.0);
        if (GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 9)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
        } else {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        }
    }
    else if (sType == "BASH")
    {
        if (GetIsPlaceableObjectActionPossible(oPlace, PLACEABLE_ACTION_BASH))
        {
            DoPlaceableObjectAction(oPlace, PLACEABLE_ACTION_BASH);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 2.0);
            DoPlaceableObjectAction(oPlace, PLACEABLE_ACTION_BASH);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 2.0);
        } else {
            //If we already have a weapon equipped, use it
            if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND) != OBJECT_INVALID)
            {
                ActionAttack(oPlace);
                DelayCommand(6.0, ClearAllActions());
                DelayCommand(6.1, SurrenderToEnemies());
            }
            //Otherwise equip and then unequip
            else
            {
                ActionEquipMostDamagingMelee();
                ActionAttack(oPlace);
                DelayCommand(6.0, ClearAllActions());
                DelayCommand(6.1, SurrenderToEnemies());
                DelayCommand(6.2, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)));
            }
        }
    }
    else if (sType == "PRAY")
    {
        if (d2() == 1)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 10.0);
        } else {
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 10.0);
        }
    }
    else if (sType == "SLEEP")
    {
        SetIsAsleep(oPlace);
    }
    else if (sType == "TALK")
    {
        SetLocalObject(OBJECT_SELF, "HF_DIALOG_TARGET", oPlace);
        SpeakOneLinerConversation();
    }
    else if (sType == "DRINK")
    {
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 3.0);
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 3.0);
    }
    else if (sType == "SIT")
    {
        if (!GetIsObjectValid (GetSittingCreature(oPlace)))
        {
            ActionSit(oPlace);
        } else {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        }
    }
    else if (sType == "USE")
    {
        ActionInteractObject(oPlace);
        if (GetHasInventory(oPlace))
        {
            if (GetIsOpen(oPlace))
            {
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
            } else {
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
            }
        }
    }
    else if (sType == "MID")
    {
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 5.0);
    }
    else if (sType == "LOW")
    {
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0);
    }
    else if (sType == "LOOK")
    {
        ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 5.0);
    }
    else
    {
        if (GetHasInventory(oPlace))
        {
            if (GetIsOpen(oPlace))
            {
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
            } else {
                AssignCommand(oPlace, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
            }
        } else {
            vector vPos = GetPosition(oPlace);
            vector vMyPos = GetPosition(OBJECT_SELF);
            if (vMyPos.z - vPos.z >= 0.0)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 10.0);
            } else {
                ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 10.0);
            }
        }
    }
    string sName = GetLocalString(oPlace, "HF_SCRIPT");
    if (sName != "")
        ExecuteScript(sName, OBJECT_SELF);
}

// any interesting meetings going on?
int ActionAttendMeeting()
{
    if (GetJob() == "ANIMAL")
        return(FALSE);
    if (GetLocalInt(GetModule(), "HF_DISABLE_AM_MEETINGS"))
        return(FALSE);

    object oMeeting = GetNearestObjectByTag("hf_meeting_place");
    if (GetIsObjectValid(oMeeting))
    {
        if (GetIsAttending(oMeeting))
        {
            if (GetDistanceToObject(oMeeting) > 3.0)
            {
                int nRun = FALSE;
                if (GetLocalString(oMeeting, "HF_MEETING_TYPE") == "CRISIS")
                    nRun = TRUE;
                SetIsWalking(GetRandomLocation(GetArea(oMeeting), oMeeting, 3.0), nRun);
            } else {
                ActionDoCommand(SetFacingPoint(GetPosition(oMeeting)));
                float fDur = 5.0 + Random(5);
                SetIsBusy(fDur);
                string sType = GetLocalString(oMeeting, "HF_MEETING_TYPE");
                if (sType == "CRISIS")
                {
                    if (d2() == 1)
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, fDur);
                    else
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, fDur);
                }
                else if (sType == "FUN")
                {
                    if (d2() == 1)
                    {
                        if (d2() == 1)
                            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
                        else
                            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2);
                    }
                    else
                    {
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, fDur);
                    }
                }
                else
                {
                    if (d4() == 1)
                        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur);
                    else
                        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, fDur);
                }
                if (d8() == 1)
                {
                    // decide the meeting is boring, so wander off
                    SetIsAttending(oMeeting, FALSE);
                }
            }
            return(TRUE);
        }
    }
    return(FALSE);
}

// make a temporary meeting (only one allowed per area)
int ActionCallMeeting()
{
    if (GetJob() == "ANIMAL")
        return(FALSE);
    if (GetLocalInt(GetModule(), "HF_DISABLE_AM_MEETINGS"))
        return(FALSE);

    if (GetIsObjectValid(GetNearestObjectByTag("hf_meeting_place")))
        return(FALSE);
    object oMeeting = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_meeting", GetLocation(OBJECT_SELF), FALSE, "hf_meeting_place");
    string sType = "COMMON";
    if (d2() == 1)
        sType = "CRISIS";
    SetLocalString(oMeeting, "HF_MEETING_TYPE", sType);
    SetLocalInt(oMeeting, "HF_MEETING_CROWD", 0);
    DelayCommand(200.0, DestroyObject(oMeeting));
    return(TRUE);
}

// wave hello to nearby friends
int ActionWaveHello()
{
    if (GetIsMute(OBJECT_SELF))
        return(FALSE);

    object oFriend = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, 1);
    if (GetIsObjectValid(oFriend))
    {
        if (GetIsPlayableRacialType(oFriend) && !GetIsUsed(oFriend) &&
            !GetIsReactionTypeFriendly(oFriend) && GetDistanceToObject(oFriend) < 10.0)
        {
            float fDur = 3.0 + Random(3);
            SetIsUsed(oFriend);
            SetIsBusy(fDur);
            SetFacingPoint(GetPosition(oFriend));

            if (GetJob() != "GUARD")
            {
                if (GetJob() == "SLAVE")
                {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
                } else {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
                }
                if (d4() == 1)
                    PlayVoiceChat(VOICE_CHAT_HELLO);
            }
            SetLocalObject(OBJECT_SELF, "HF_DIALOG_TARGET", oFriend);
            SpeakOneLinerConversation("", oFriend);
            return(TRUE);
        }
    }
    return(FALSE);
}

// fiddle with nearby objects; random chance of not using the nearest placeable
// to avoid making them follow the same route among placeables all of the time
// workers don't use a random chance since that would make them look lazy
int ActionUseObject()
{
    int i = 1;
    string sTag = GetLocalString(OBJECT_SELF, "HF_USE_OBJECT");
    object oPlace = GetNearestObjectByTag(sTag, OBJECT_SELF, i);
    while (GetIsObjectValid(oPlace))
    {
        if (d2() == 1 || GetJob() == "WORKER")
        {
            if (!GetIsUsed(oPlace) && GetDistanceToObject(oPlace) < 30.0)
            {
                float fDur = 7.0;
                SetIsBusy(fDur);
                SetIsUsed(oPlace);
                ActionMoveToObject(oPlace, FALSE, 0.25);
                ActionDoCommand(UsePlaceable(oPlace));
                return(TRUE);
            }
        }
        oPlace = GetNearestObjectByTag(sTag, OBJECT_SELF, ++i);
    }
    return(FALSE);
}

// wander around aimlessly for a while
int ActionWander()
{
    if (GetJob() == "MERCHANT")
        return(FALSE);
    float fDur = 5.0 + Random(5);
    SetIsBusy(fDur);
    ActionRandomWalk();
    return(TRUE);
}

// return to our original spawn point and face original facing
int ActionGoHome()
{
    location lHome = GetLocalLocation(OBJECT_SELF, "HF_SPAWN_LOC");

    if (GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lHome) > 0.01)
    {
        float fDur = 7.0;
        SetIsBusy(fDur);
        ActionMoveToLocation(lHome);
        ActionDoCommand(SetFacing(GetFacingFromLocation(lHome)));
        return(TRUE);
    }
    else
    {
        float fHome = GetFacingFromLocation(lHome);
        float fFace = GetFacing(OBJECT_SELF);
        if (fabs(fHome - fFace) > 0.01)
        {
            SetFacing(fHome);
        }
    }
    return(FALSE);
}

// play random ambient animations
int ActionAmbient()
{
    float fDur = 5.0 + Random(5);
    SetIsBusy(fDur);
    PlayImmobileAmbientAnimations();
    return(TRUE);
}

// walk to night post if one is defined
int ActionBedTime()
{
    string sPost = GetLocalString(OBJECT_SELF, "HF_NIGHT");
    if (sPost != "")
    {
        if (GetIsNight())
        {
            object oWP = GetWaypointByTag(sPost);
            if (GetIsObjectValid(oWP))
            {
                SetIsWalking(GetLocation(oWP), FALSE);
                return(TRUE);
            }
        }
    }
    return(FALSE);
}

// close an open door
int ActionCloseDoors()
{
    if (GetJob() == "ANIMAL")
        return(FALSE);

    if (!GetIsAreaInterior(GetArea(OBJECT_SELF)))
        return FALSE;

    int n = 1;
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    location lLoc = GetLocation(OBJECT_SELF);
    while (GetIsObjectValid(oDoor))
    {
        if (GetIsOpen(oDoor) && !GetIsUsed(oDoor) &&
            GetDistanceToObject(oDoor) < 30.0)
        {
            float fDur = 5.0 + Random(5);
            SetIsUsed(oDoor);
            SetIsBusy(fDur);
            ActionCloseDoor(oDoor);
            ActionMoveToLocation(lLoc);
            return TRUE;
        }
        oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, ++n);
    }
    return(FALSE);
}

// follow a creature
int ActionFollow()
{
    object oFollow = GetLocalObject(OBJECT_SELF, "HF_FOLLOW_AM");
    if (!GetIsObjectValid(oFollow))
    {
        return(FALSE);
    }
    if (GetIsEnemy(oFollow))
    {
        DeleteLocalObject(OBJECT_SELF, "HF_FOLLOW_AM");
        return(FALSE);
    }
    if (GetDistanceToObject(oFollow) > 25.0 || GetArea(OBJECT_SELF) != GetArea(oFollow))
    {
        DeleteLocalObject(OBJECT_SELF, "HF_FOLLOW_AM");
        return(FALSE);
    }
    if (GetStealthMode(oFollow) == STEALTH_MODE_ACTIVATED)
    {
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
        string sSex = "he";
        if (GetGender(oFollow) == GENDER_FEMALE)
            sSex = "she";
        ActionSpeakString("Huh? Where did " + sSex + " go?");
    } else {
        ActionForceFollowObject(oFollow, 3.0);
    }
    return(TRUE);
}

// perform a "source -> destination" carry task
int ActionWork()
{
    string sTag = GetLocalString(OBJECT_SELF, "HF_TASK");
    int nState = GetLocalInt(OBJECT_SELF, "HF_TASK_STATE");
    if (nState == 0)
    {
        sTag += "_src";
    } else {
        sTag += "_dst";
    }

    object  oDest = GetNearestObjectByTag(sTag);
    if (GetIsObjectValid(oDest))
    {
        if (GetDistanceToObject(oDest) <= 5.0)
        {
            ActionMoveToObject(oDest, FALSE, 0.25);
            ActionDoCommand(UsePlaceable(oDest));
            if (nState == 0)
            {
                SetLocalInt(OBJECT_SELF, "HF_TASK_STATE", 1);
            } else {
                SetLocalInt(OBJECT_SELF, "HF_TASK_STATE", 0);
            }
        } else {
            int bRun = GetLocalInt(OBJECT_SELF, "HF_ROUTE_RUN");
            SetIsWalking(GetLocation(oDest), bRun, OBJECT_SELF);
        }
        return(TRUE);
    }
    return(FALSE);
}

// rogues might steal something from someone and flee
int ActionSteal()
{
    if (GetJob() == "ROGUE")
    {
        // are we currently stalking a victim?
        int nState = GetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE");
        if (nState <= 0)
        {
            // not stalking anyone, so search for a mark
            object oMark = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, 1);
            if (GetIsObjectValid(oMark))
            {
                SetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE", 1);
                SetLocalObject(OBJECT_SELF, "HF_FOLLOW_AM", oMark);
                return(TRUE);
            }
        }
        else if (nState <= 4)
        {
            // stalking someone, but keep at it for a while
            SetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE", ++nState);
            return(FALSE);
        }
        else
        {
            // try to steal something from our mark
            object oMark = GetLocalObject(OBJECT_SELF, "HF_FOLLOW_AM");
            if (GetIsObjectValid(oMark))
            {
                ActionMoveToObject(oMark, TRUE);
                ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL);
                ActionDoCommand(FloatingTextStringOnCreature("... Pickpocket Attempt ...", oMark, FALSE));
                int nRoll = d20() + GetSkillRank(SKILL_PICK_POCKET);
                if (nRoll >= 10)
                {
                    object oItem = GetFirstItemInInventory(oMark);
                    while (GetIsObjectValid(oItem))
                    {
                        if (!GetPlotFlag(oItem) && GetDroppableFlag(oItem) && !GetPlotFlag(oMark))
                        {
                            ActionTakeItem(oItem, oMark);
                            break;
                        }
                        oItem = GetNextItemInInventory(oMark);
                    }
                }
                ActionMoveAwayFromObject(oMark, TRUE, 35.0);
                ActionSpeakString("Heh Heh Heh!", TALKVOLUME_WHISPER);
                SetIsBusy(15.0);
            }
            DeleteLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE");
            DeleteLocalObject(OBJECT_SELF, "HF_FOLLOW_AM");
            return(TRUE);
        }
    }
    return(FALSE);
}

//Perform the Knockdown of oMark from ActionIntimidate
void DoKnockdown(object oMark)
{
    AssignCommand(oMark, ClearAllActions());
    AssignCommand(oMark, SpeakString("Hey!"));
}

// rough up the townsfolk a bit
int ActionIntimidate()
{
    if (GetJob() == "THUG")
    {
        // find a nearby victim
        object oMark = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, 1);
        if (GetIsObjectValid(oMark))
        {
            if (!GetIsUsed(oMark))
            {
                SetIsUsed(oMark);
                if (GetIsPC(oMark))
                {
                    // hit the player up for money
                    ActionStartConversation(oMark, "", FALSE, FALSE);
                }
                else
                {
                    // push the townsfolk around
                    if (GetLocalInt(oMark, "HF_VICTIM") == 0)
                    {
                        return(FALSE);
                    }
                    ActionMoveToObject(oMark, TRUE, 0.5);
                    ActionSpeakString("Ha!");
                    ActionDoCommand(DoKnockdown(oMark));
                    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oMark, 6.0));
                    ActionMoveAwayFromObject(oMark, FALSE, 20.0);
                }
                return(TRUE);
            }
        }
        return(FALSE);
    }
    return(FALSE);
}

// sing a song for a while (don't put too many bards in one area!)
int ActionPerform()
{
    if (GetJob() == "BARD")
    {
        int nState = GetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE");
        if (nState <= 0)
        {
            // strike up a song!
            SetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE", 1);
            ActionSpeakString("Greetings, Ladies and Gentlemen!");
            ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
            object oMeeting = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_meeting", GetLocation(OBJECT_SELF), FALSE, "hf_meeting_place");
            SetLocalString(oMeeting, "HF_MEETING_TYPE", "FUN");
            SetLocalInt(oMeeting, "HF_MEETING_CROWD", 0);
            SetLocalObject(OBJECT_SELF, "HF_MEETING", oMeeting);
            return(TRUE);
        }
        else if (nState <= 3)
        {
            // keep playing for a while
            string sItem = GetLocalString(OBJECT_SELF, "HF_ITEM");
            if (sItem == "FLUTE")
            {
                ActionDoCommand(PlaySound("as_cv_flute1"));
                ActionWait(2.0);
                ActionDoCommand(PlaySound("as_cv_flute2"));
            }
            if (sItem == "LUTE")
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), OBJECT_SELF, 6.0);
                ActionWait(2.0);
                if (d2() == 1)
                    ActionDoCommand(PlaySound("as_cv_lute1"));
                else
                    ActionDoCommand(PlaySound("as_cv_lute1b"));
            }
            if (sItem == "SONG")
            {
                // speak a single random verse from our song
                SetLocalInt(OBJECT_SELF, "HF_SINGING", 1);
                SpeakOneLinerConversation();
                SetLocalInt(OBJECT_SELF, "HF_SINGING", 0);
                ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3);
                nState = 3;
            }
            SetLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE", ++nState);
            return(TRUE);
        }
        else
        {
            // performance is over
            ActionSpeakString("Thank-you!");
            ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
            object oMeeting = GetLocalObject(OBJECT_SELF, "HF_MEETING");
            DestroyObject(oMeeting);
            DeleteLocalObject(OBJECT_SELF, "HF_MEETING");
            DeleteLocalInt(OBJECT_SELF, "HF_AMBIENT_STATE");
            SetIsBusy(15.0);
            return(TRUE);
        }
    }
    return(FALSE);
}

// panic!
int ActionPanic()
{
    if (!GetLocalInt(OBJECT_SELF, "HF_PANIC"))
    {
        return(FALSE);
    }
    ClearAllActions(TRUE);

    int nAction = d3();
    if (nAction == 1)
    {
        // run around aimlessly
        ActionSpeakString("Ahh! Run!");
        location lRandom = GetRandomLocation(GetArea(OBJECT_SELF), OBJECT_SELF, 20.0);
        ActionMoveToLocation(lRandom, TRUE);
    }
    else if (nAction == 2)
    {
        // wail with despair
        int n = d3();
        if      (n == 1) ActionSpeakString("Oh no!");
        else if (n == 2) ActionSpeakString("Help!");
        else if (n == 3) ActionSpeakString("Ahhh!");
        else             ActionSpeakString("Save us!");
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0);
    }
    else if (nAction == 3)
    {
        // scream
        if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
        {
            PlaySound("as_pl_screamf" + IntToString(d6()));
        } else {
            PlaySound("as_pl_screamm" + IntToString(d6()));
        }
        ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
    }
    return(TRUE);
}

// ====================================================================
// ============================= SHOUTS ===============================
// ====================================================================

// one of my chests was opened
int ActionShoutOpened()
{
    object oShouter = GetLastSpeaker();
    if (GetFactionEqual(oShouter))
    {
        object oThief = GetLocalObject(oShouter, "HF_THIEF");
        ClearAllActions();
        ActionMoveToObject(oShouter, TRUE, 2.0);
        if (GetObjectSeen(oThief))
            SpeakString("Get away from there!");
        else
            SpeakString("Huh? What was that noise?");
        return(TRUE);
    }
    return(FALSE);
}

// one of my chests was looted
int ActionShoutLooted()
{
    object oShouter = GetLastSpeaker();
    if (GetFactionEqual(oShouter) || GetIsFriend(oShouter))
    {
        object oThief = GetLocalObject(oShouter, "HF_THIEF");
        if (GetObjectSeen(oThief) || GetObjectHeard(oThief))
        {
            SpeakString("Thief!");
            SpeakString("HF_SHOUT_LOOT", TALKVOLUME_SILENT_SHOUT);
            SetIsTemporaryEnemy(oThief, OBJECT_SELF, TRUE, 60.0);
            DetermineCombatRound(oThief);
            ClearAllActions(TRUE);
            return(TRUE);
        }
    }
    return(FALSE);
}

// uh oh! commoners panic
int ActionShoutPanic(int nPanic)
{
    if (GetLevelByClass(CLASS_TYPE_COMMONER) > 0)
    {
        SetLocalInt(OBJECT_SELF, "HF_PANIC", nPanic);
        ActionPanic();
        return(TRUE);
    }
    return(FALSE);
}

// ====================================================================
// ============================ SCRIPTS ===============================
// ====================================================================

void DoWork()
{
    if (ActionUseObject())         return;
    if (ActionBedTime())           return;
    if (ActionWork())              return;
    ActionAmbient();
}

// amblers wander around looking for interesting things to do
// they will poke at various common objects, read books, etc.
// this is the default behaviour for NPCs using this system
void DoAmble()
{
    if (ActionPerform())           return;
    if (ActionSteal())             return;
    if (ActionIntimidate())        return;
    if (ActionFollow())            return;
    if (ActionAttendMeeting())     return;
    if (ActionWaveHello())         return;
    if (d3() == 1)
        if (ActionUseObject())     return;
    if (d3() == 1)
        if (ActionWander())        return;
    if (ActionBedTime())           return;
    if (d2() == 1)
        if (ActionGoHome())        return;
    if (d3() == 1)
        if (ActionCloseDoors())    return;
    if (d4() == 1)
        if (ActionCallMeeting())   return;
    ActionAmbient();
}

// this simple version of "amble" is designed to ease CPU burden
// it is useful in large areas with lots of NPCs.
void DoCommoner()
{
    if (ActionWaveHello())         return;
    if (d3() == 1)
        if (ActionUseObject())     return;
    if (d3() == 1)
        if (ActionWander())        return;
    if (ActionBedTime())           return;
    if (d2() == 1)
        if (ActionGoHome())        return;
    if (d3() == 1)
        if (ActionCloseDoors())    return;
    ActionAmbient();
}

// NPCs with a route will walk the route, and pause at each point
// along the way to do some actions based on the objects in the area
void DoRoute()
{
    if (!GetIsPaused(OBJECT_SELF))
    {
        // all done here, move along
        if (ActionBedTime())       return;
        if (ActionAttendMeeting()) return;
        WalkRoute(GetLocalInt(OBJECT_SELF, "HF_ROUTE_WRAP"), GetLocalInt(OBJECT_SELF, "HF_ROUTE_RUN"));
    } else {
        // paused along the route, so spend a little time here
        if (ActionSteal())         return;
        if (ActionWaveHello())     return;
        if (ActionUseObject())     return;
        if (ActionCloseDoors())    return;
        ActionAmbient();
    }
}

// random rowdy tavern immobile animations
void DoTavern()
{
    // return to spawn location in case someone bumped us around
    if (ActionGoHome()) return;

    int nRoll = Random(15);
    switch (nRoll)
    {
        case 0:
        case 1:
            ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK); break;
        case 2:
        case 3:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 4.0); break;
        case 4:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1); break;
        case 5:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2); break;
        case 6:
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3); break;
        case 7:
        case 8:
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0); break;
        case 9:
        case 10:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED); break;
        case 11:
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
        case 12:
        case 13:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 4.0); break;
        default:
            AnimActionLookAround(); break;
    }
}

// stand around forever and chat (hopefully to someone else)
void DoChat()
{
    // return to spawn location in case someone bumped us around
    if (ActionGoHome()) return;

    // return to original facing in case someone interrupted us
    location lStart = GetLocalLocation(OBJECT_SELF, "HF_SPAWN_LOC");
    SetFacing(GetFacingFromLocation(lStart));

    int nRoll = Random(16);
    switch (nRoll)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 4.0); break;
        case 4:
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0); break;
        case 5:
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0); break;
        case 6:
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0); break;
        case 7:
        case 8:
        case 9:
            ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0); break;
        default:
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 4.0); break;
    }
}

// mostly to receive shouts
void DoNothing()
{
    ActionAmbient();
}

// ====================================================================
// ============================== CONTROL =============================
// ====================================================================

void Heartbeat()
{
    // is it time to panic? this over-rides combat and convo!
    if (ActionPanic())
    {
        return;
    }

    // don't use so much CPU if our AI level is low
    if (GetLocalInt(OBJECT_SELF, "HF_AI_LEVEL") < 0)
    {
        if (d2() == 1) return;
    }

    // is ambient system disabled?
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") ||
        GetLocalInt(GetArea(OBJECT_SELF), "HF_DISABLE_AM"))
    {
        return;
    }

    if (!GetIsObjectValid(GetAttemptedAttackTarget()) &&
        !GetIsObjectValid(GetAttemptedSpellTarget()) &&
        !GetIsObjectValid(GetNearestSeenEnemy()) &&
        !IsInConversation(OBJECT_SELF))
    {
        // if we are busy doing something, don't interrupt us
        if (GetIsAsleep() || GetIsBusy() || GetIsWalking())
        {
            return;
        }

        // we are not busy, so look for something to do
        ClearAllActions();
        if (HasRoute())
        {
            DoRoute();
        }
        else if (GetJob() == "COMMONER")
        {
            DoCommoner();
        }
        else if (GetJob() == "WORKER")
        {
            DoWork();
        }
        else if (GetJob() == "TAVERN")
        {
            DoTavern();
        }
        else if (GetJob() == "CHAT")
        {
            DoChat();
        }
        else if (GetJob() == "NONE")
        {
            DoNothing();
        }
        else
        {
            DoAmble();
        }
    }
}

void Dialogue()
{
    if (GetHasEffect(EFFECT_TYPE_SLEEP) || GetIsDead(OBJECT_SELF))
    {
        return;
    }
    if (GetJob() == "ANIMAL")
    {
        return;
    }
    int nMatch = GetListenPatternNumber();
    if (nMatch == HF_SHOUT_OPEN)
    {
        ActionShoutOpened();
    }
    else if (nMatch == HF_SHOUT_LOOT)
    {
        ActionShoutLooted();
    }
    else if (nMatch == HF_SHOUT_PANIC_START)
    {
        ActionShoutPanic(TRUE);
    }
    else if (nMatch == HF_SHOUT_PANIC_STOP)
    {
        ActionShoutPanic(FALSE);
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_HEARTBEAT)
    {
        // remember if AI level is low, default heartbeat doesn't call us
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {
        if (GetLocalInt(OBJECT_SELF, "HF_RANDOM_APPEARANCE"))
        {
            // change appearance
            SetRandomAppearance(OBJECT_SELF);
         }
        if (GetLocalInt(GetModule(), "HF_RANDOM_AM_LOOT"))
        {
            // random minor loot for pickpocketing
            SetRandomPossessions(OBJECT_SELF);
        }
        if (GetIsObjectValid(GetNearestObjectByTag("hf_disable_am")))
        {
            // disable the ambient system in certain areas
            SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
        }
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
        SetLocalLocation(OBJECT_SELF, "HF_SPAWN_LOC", GetLocation(OBJECT_SELF));
        if (HasRoute())
        {
            // cache the waypoints for less lag when the game runs
            InitRoute();
            if (GetLocalInt(OBJECT_SELF, "HF_ROUTE_PAUSE") == 0)
            {
                // by default pause for a while; use a negative value for no pause
                SetLocalInt(OBJECT_SELF, "HF_ROUTE_PAUSE", 5);
            }
        }
        if (GetLocalString(OBJECT_SELF, "HF_USE_OBJECT") == "")
        {
            // by default look for any interactive object
            SetLocalString(OBJECT_SELF, "HF_USE_OBJECT", "hf_interactive_object");
        }
        if (GetHitDice(OBJECT_SELF) <= 1 && GetLevelByClass(CLASS_TYPE_COMMONER) == 1)
        {
            // run away if you are a weakling
            SetCombatCondition(X0_COMBAT_FLAG_COWARDLY);
        }
        SetListenPattern(OBJECT_SELF, "HF_SHOUT_OPEN", HF_SHOUT_OPEN);
        SetListenPattern(OBJECT_SELF, "HF_SHOUT_LOOT", HF_SHOUT_LOOT);
        SetListenPattern(OBJECT_SELF, "HF_SHOUT_PANIC_START", HF_SHOUT_PANIC_START);
        SetListenPattern(OBJECT_SELF, "HF_SHOUT_PANIC_STOP", HF_SHOUT_PANIC_STOP);
    }
    else if (nUser == EVENT_DIALOGUE)
    {
        Dialogue();
    }
}

// ====================================================================
// ========================== DOCUMENTATION ===========================
// ====================================================================
/*

You can specify NPC behaviours using this script. Just set this script
as the user-defined event for your NPC. Next set a few variables on the
NPC to define the behaviour. Create objects in the area with appropriate
tags for the NPC to interact with. Set a variable on the object to define
how the NPCs should interact with the object.

MODULE:
  int HF_DISABLE_AM_MEETINGS
        When set to TRUE, the ambient AI will never call meetings.

NPCS:
  int X2_USERDEFINED_ONSPAWN_EVENTS
        You must set this variable to 3 on every NPC who uses this script.
  int HF_AI_LEVEL
        Set this to -1 if you want to ease the CPU load a bit
  str HF_ROUTE_NAME
        Routes are waypoints with tags WP_ROUTE_01, WP_ROUTE_02, etc.
        where ROUTE = the value of this HF_ROUTE variable. If you do not
        specify a route, the NPC will wander freely in the area but will
        often return to the original spawn location.
  int HF_ROUTE_WRAP
        When an NPC reaches the end of the waypoints, normally he/she will
        walk the waypoints in reverse order. Set this variable to -1 to
        stop walking once the route is done. Set this variable to 1 to
        return to the first waypoint (like a circle).
  int HF_ROUTE_RUN
        Set this variable to 1 if you want the NPC to run instead of walk
        the route.
  int HF_ROUTE_PAUSE
        NPC will pause for this many seconds at each waypoint along the route
        there is a default value if you don't set this variable. When the
        NPC doesn't have a route, this variable doesn't do anything.
  str HF_USE_OBJECT
        NPCs interact with any nearby objects tagged "hf_interactive_object"
        Set this variable to a different tag and they will only use objects
        with this tag. If you don't want an NPC to use any objects, set this
        variable to a tag that is not used in your module.
  str HF_DESTINATION_ACTION
        Name of a script to execute when a walk destination is reached.
  str HF_TASK
        NPC will move between work sources and work destinations. The source
        object has this tag plus suffix _src; the destination object has
        this tag plus suffix _dst.
  str HF_NIGHT
        NPC will walk to a waypoint with this tag each night (or if it is
        raining. If you do not define this variable, the NPC will do the same
        thing at night as during the day.
  obj HF_FOLLOW_AM
        The NPC will follow this creature until the creature uses stealth to
        escape, gets too far away, or leaves the area.
  int HF_DISABLE_AM
        The entire ambient system will be disabled if you set this variable.
  int HF_RANDOM_APPEARANCE
        Set to 1 if you want this character to a pseudo-random appearance.
  str HF_JOB
        Some NPCs have job-specific behaviours.
           COMMONER   (default)
           TAVERN     drink, cheer, talk
           CHAT       play animations appropriate to dialog
           GUARD      runs to crisis meetings, ignores other meetings
           ANIMAL     don't attend meetings or close doors
           MERCHANT   will not attend meetings or wander aimlessly
           ROGUE      steals stuff from the PC / townsfolk
           SLAVE      bows
           WORKER     shuffles between source and destination objects
           BARD       plays the lute for money
           THUG       roughs up the PC / townsfolk
           NONE       only plays ambient immobile animations
  str HF_ITEM
        Some NPCs possess "items" that affect how they do their jobs.
           FLUTE      plays the flute instead of the lute
  int HF_PANIC
        Set to true if you want this commoner to panic
  int HF_ATTR_MUTE
        Set to true if you want this NPC to not greet
  int HF_VICTIM
        Mark NPC as being a target for NPCs with THUG job

OBJECTS:
  hf_meeting_place - NPCs will gather around this object for a while
    str HF_MEETING_TYPE
          COMMON (default) amblers will walk to this meeting and leave after a while
          CRISIS guards come running

  hf_interactive_object - NPCs will manipulate this object when near it
    str HF_ACTION_TYPE - defines how NPCs interact with the object
          TOUCH  (default) NPC will perform the GET_MID/GET_LOW animation
          OPEN     NPC will open/close the object
          ACTIVATE NPC will trigger the activate/deactive animations of the object
          USE      NPC will try to use the object; give it a OnUse script
          READ     NPC will read a book if smart enough to do so
          BASH     NPC will attack the object for a few seconds
          PRAY     NPC will worship/meditate for a few seconds
          SLEEP    NPC will fall asleep (nap in the day, longer at night)
          TALK     NPC will speak a one liner conversation
          DRINK    NPC will take a few sips from a drink (use at bar/keg/fountain/etc)
          SIT      NPC will sit down on the object (if no one else is sitting on it)
          LOOK     NPC will look (far) at the object for a few seconds
          FACE     NPC will face the object
          MID      NPC will play the looping mid animation
          LOW      NPC will play the looping low animation
    str HF_SCRIPT - name of the script to execute when an NPC interacts with this object
    int HF_ACTIVATED - set initial state of an interactive object to be visually activated

  hf_disable_am - Place an object with this tag to disable the ambient system in that area

WAYPOINTS:
  WP_ROUTE_01 - waypoints used in routes
    str HF_SCRIPT - name of the script to execute when the NPC reaches this point

DIALOGS:
  obj HF_DIALOG_TARGET
        This temporary variable is set on the NPC to indicate who/what they
        are talking to (for speaking one liners).

CONTAINERS:
  set faction to same as NPC and use scripts hf_am_con_open or hf_am_con_dist
  to trigger hostile behaviours when the container is looted.

IDEAS:
- wild animals avoid humans
- avoid people displaying weapons
- challenge intruders in a home (do through convo instead?)
- guards could challenge people with weapons (do through convo instead?)
- have commoners enter public places (dangerous!)
- remote command protocol: cheer, say hi, flee, etc.
*/
