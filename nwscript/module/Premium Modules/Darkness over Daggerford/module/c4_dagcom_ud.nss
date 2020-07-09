// user-defined event for daggerford NPCs who wander home at night
// specific actions are determined by the NPC's job type:
// .. GUARD: practice in the weapons yard
// .. MERCHANT: hawk their wares to passers-by
// .. CRIER: call out random news

#include "nw_i0_generic"
#include "nw_i0_plot"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// --------------------------------- QUERY  ---------------------------------

// returns this creature's job
string GetJob()
{
    return(GetLocalString(OBJECT_SELF, "HF_JOB"));
}

// set or clear our busy flag
void SetIsBusy(int nState)
{
    if (nState == 0)
        SetLocalInt(OBJECT_SELF, "HF_IS_BUSY", 0);
    else
        SetLocalInt(OBJECT_SELF, "HF_IS_BUSY", 1);
}

// are we busy?
int GetIsBusy()
{
    return(GetLocalInt(OBJECT_SELF, "HF_IS_BUSY") != 0);
}

// -------------------------------- WALKING ----------------------------------

// walk to a destination object
void SetIsWalking(object oDest, int nRun=FALSE)
{
    SetIsBusy(TRUE);
    ActionMoveToLocation(GetLocation(oDest), nRun);
}

// stop walking and face the right way
void DoneWalking(object oDest)
{
    SetFacing(GetFacing(oDest));
    DeleteLocalInt(OBJECT_SELF, "HF_WALK_TIME");
    SetIsBusy(FALSE);
}

// check if we have arrived at our destination
int GetIsWalking(object oDest)
{
    location lLoc = GetLocation(oDest);
    int nWalkTime = GetLocalInt(OBJECT_SELF, "HF_WALK_TIME");
    if (nWalkTime >= 10)
    {
        // timer expired, might be stuck somewhere, try teleport
        JumpToLocation(lLoc);
        DoneWalking(oDest);
        return(FALSE);
    }
    else
    {
        if (GetDistanceToObject(oDest) <= 0.1)
        {
            // we have arrived at our destination, so stop walking
            DoneWalking(oDest);
            return(FALSE);
        }
        else
        {
            // still going, nudge us in case someone blocked us along the way
            SetLocalInt(OBJECT_SELF, "HF_WALK_TIME", ++nWalkTime);
            ClearAllActions();
            SetIsWalking(oDest);
            return(TRUE);
        }
    }
}

// --------------------------- Training Guards  -----------------------------

// militia practice with their weapons in the training grounds
void DoGuardJob()
{
    // is the player obstructing us?
    int nObstructed = FALSE;
    object oObstructor = GetFirstPC();
    object oTrigger = GetLocalObject(OBJECT_SELF, "oTrigger");
    if (GetIsInSubArea(oObstructor, oTrigger) == TRUE)
    {
        nObstructed = TRUE;
    }

    // if obstructed by a PC, yell, otherwise fire at the target (rest once and a while too)
    if (nObstructed == FALSE)
    {
        if (d10() != 10)
        {
            object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
            ClearAllActions(TRUE);
            ActionAttack(oTarget);
        }
        else
        {
            ClearAllActions(TRUE);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 4.0);
        }
    }
    else
    {
        int nYell;
        int nAnimation;
        switch (d4())
        {
            case 1:     nYell = 85757; //"Get out of the way!"
                        nAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;
                        break;
            case 2:     nYell = 85758;//"What are you doing!"
                        nAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;
                        break;
            case 3:     nYell = 85761;//"Ignorant fool!"
                        nAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;
                        break;
            default:    nYell = 85757; //"Get out of the way!"
                        nAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;
                        break;
        }
        ClearAllActions(TRUE);
        int nAction = Random(5);
        if(nAction == 0)
        {
            PlaySpeakSoundByStrRef(nYell);
        }
        else if (nAction == 1)
        {
            PlayVoiceChat(VOICE_CHAT_BADIDEA);
        }
        else if (nAction == 2)
        {
            PlayVoiceChat(VOICE_CHAT_CUSS);
        }
        else if (nAction == 3)
        {
            PlayVoiceChat(VOICE_CHAT_MOVEOVER);
        }
        else if (nAction == 4)
        {
            PlaySpeakSoundByStrRef(nYell);
        }
        DelayCommand(0.5, ActionPlayAnimation(nAnimation, 1.0, IntToFloat(Random(4) + 1)));
    }
}

// --------------------------------- TOWN CRIER ------------------------------

void DoCrierJob(object oPC)
{
    // read the newspaper and call out
    ClearAllActions();
    ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
    PlaySound("as_pl_towncrym2");

    // say something useful; different things are said at end game
    string s = "";
    if (GetLocalInt(GetModule(), "pm_endgame_start") == 1)
    {
        int n = Random(5)+1;
        if      (n == 1)  s = "Orcs and other devil-spawn rampage through Daggerford castle!";
        else if (n == 2)  s = "Matagar Bugo, former Baron of Daggerford, declared a traitor by Captain Frederick!";
        else if (n == 3)  s = "The Griffons Mercenary Company revealed to be Zhentarim soldiers in disguise!";
        else if (n == 4)  s = "Giant orc army led by fearsome devil approaching Daggerford! All citizens – SEEK SHELTER!";
        else if (n == 5)  s = "Town crier ordered to keep yelling out announcements even though he SHOULD be seeking safety under a table at the Happy Cow! *Gulp!*";
    }
    else
    {
        int n = Random(15)+1;
        if      (n == 1)  s = "The Griffon mercenaries defend another merchant caravan from villainous bandits along the Trade Way!";
        else if (n == 2)  s = "The Baron of Daggerford has decreed that all townsfolk shall receive more ale at the next festival!";
        else if (n == 3)  s = "Another contingent of Griffon mercenaries have been engaged to keep Daggerford safe for all!";
        else if (n == 4)  s = "'Daggerford shall become a thriving mercantile city within a decade!' so says the Baron of Daggerford in his Golden Booklet!";
        else if (n == 5)  s = "Pick up a copy of the Baron of Daggerford’s Golden Booklet at the castle today! Only one gold piece!";
        else if (n == 6)  s = "A new tenday summer festival is to be created for the enjoyment of all, paid for by the Baron of Daggerford!";
        else if (n == 7)  s = "Captain Dratharion receives medal of bravery for single-handedly chasing off bandits!";
        else if (n == 8)  s = "Villainous Trade Way bandits still elude Daggerford militia!";
        else if (n == 9)  s = "Lizardfolk raiders spotted near Gillian's Hill!";
        else if (n == 10) s = "Lizardfolk raiders make off with innocent travelers as slaves into the dangerous Lizard Marsh!";
        else if (n == 11) s = "Store prices rising due to increased caravan attacks! Baron of Daggerford accuses merchants of profiteering!";
        else if (n == 12 && GetLocalInt(GetModule(),"pm_Daggerford_open") != 1)
                          s = "The town of Daggerford has been sealed until further notice!";
        else if (n == 13 && GetLocalInt(GetModule(),"pm_fernigolddead") != 1 && GetLocalInt(GetModule(),"pm_fernigoldreturn") != 1)
                          s = "Fernigold the Younger still missing! Daggerford militia fears the worst!";
        else if (n == 14 && GetLocalInt(GetModule(),"pm_fernigoldreturn") == 1)
                          s = "Fernigold the Younger found dead! Adventurer returns body to Daggerford!";
        else if (n == 15 && GetLocalInt(GetModule(),"hevesar_plot") == 6)
                          s = "Adventurer solves farmland mysteries, hailed as hero!";
        else if (n == 16 && GetLocalInt(GetModule(), "iChurlgoDead") == 1)
                          s = "Churlgo Cheese Empire Crumbles! Family found washed up on banks of Delimbiyr!";
        if (s == "")
        {
            s = "“The outlook is golden!” so says the Baron of Daggerford in his Golden Booklet!";
        }
    }
    if (s != "")
    {
        string q = GetLocalString(GetModule(), "QUOTE");
        ActionSpeakString(q+s+q);
    }
}

// we are at our destination, so do some work here
void DoJob()
{
    string sJob = GetJob();
    if (sJob == "GUARD")
    {
        DoGuardJob();
    }
}

// --------------------------------- CONTROL --------------------------------

// heartbeat causes the NPC to walk home (or to work) and do their action
void Heartbeat()
{
    // do nothing if we are busy
    if (GetIsInCombat() || IsInConversation(OBJECT_SELF))
        return;

    // the town crier has to stand around all day/night at end game
    // .. none of the other DN folks are around during the end game
    if (GetLocalInt(GetModule(), "pm_endgame_start") == 1)
    {
        return;
    }

    if (GetIsDay())
    {
        // day time, so walk to our job
        object oDest = GetLocalObject(OBJECT_SELF, "HF_DAY_DOOR_OBJ");
        if (!GetIsWalking(oDest))
        {
            DoJob();
        }
    }
    else
    {
        // night time, so walk towards our night door
        object oDest = GetLocalObject(OBJECT_SELF, "HF_NIGHT_DOOR_OBJ");
        if (!GetIsWalking(oDest))
        {
            // we have arrived at our night door, so go inside
            // .. we will respawn when the player re-enters the city
            DestroyObject(OBJECT_SELF);
        }
    }
}

void Perceive()
{
    // do nothing if we are busy
    if (GetIsBusy() || GetIsInCombat() || IsInConversation(OBJECT_SELF))
        return;

    // call out to the player
    object oPC = GetLastPerceived();
    if (GetIsPC(oPC))
        DoCrierJob(oPC);
}

void main()
{
    // do nothing if my AI is disabled
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
        return;

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
        // everyone must register for heartbeat notifications
        // town crier must register for perceive notifications
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        if (GetJob() == "CRIER")
        {
            SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
        }

        // cache target and trigger for future use by guards
        if (GetJob() == "GUARD")
        {
            object oTrigger = GetNearestObjectByTag("tr_train_area_"+GetTag(OBJECT_SELF));
            SetLocalObject(OBJECT_SELF, "oTrigger", oTrigger);
            object oTarget = GetNearestObjectByTag("pl_target_" + GetTag(OBJECT_SELF));
            SetLocalObject(OBJECT_SELF, "oTarget", oTarget);
        }

        // cache night door for future use
        string sNightDoorTag = GetLocalString(OBJECT_SELF, "HF_NIGHT_DOOR");
        if (sNightDoorTag == "")
        {
            sNightDoorTag = "WP_" + GetTag(OBJECT_SELF) + "_DOOR";
        }
        object oDoor = GetObjectByTag(sNightDoorTag);
        SetLocalObject(OBJECT_SELF, "HF_NIGHT_DOOR_OBJ", oDoor);

        // cache day job for future use
        string sDayDoorTag = GetLocalString(OBJECT_SELF, "HF_DAY_DOOR");
        if (sDayDoorTag == "")
        {
            sDayDoorTag = "WP_" + GetTag(OBJECT_SELF) + "_POST";
        }
        object oJob = GetObjectByTag(sDayDoorTag);
        SetLocalObject(OBJECT_SELF, "HF_DAY_DOOR_OBJ", oJob);

        // walk to our job or to our home depending on time of day
        // .. this doesn't apply during the end game
        if (GetLocalInt(GetModule(), "pm_endgame_start") == 0)
        {
            if (GetIsDay() || GetIsDawn())
                SetIsWalking(oJob);
            else
                SetIsWalking(oDoor);
        }
    }
}

/*
  Area:
   - HF_DNSPAWN_COUNT  : count of number of creatures registered
   - HF_DNSPAWN_#_TAG  : tag of creature to spawn at door
   - HF_DNSPAWN_#_DOOR : waypoint where to spawn creature (door)

  Waypoints:
   - WP_tag_DOOR : the NPC will walk to this waypoint at night and vanish
   - WP_tag_POST : the NPC will walk to this waypoint during the day

  Object:
   - HF_JOB : the NPC's job (GUARD | MERCHANT | CRIER | NONE)
   - HF_NIGHT_DOOR : the NPC will walk to this object at night and vanish
   - HF_DAY_DOOR   : the NPC will walk to this object at day to "work"
   - X2_USERDEFINED_ONSPAWN_EVENTS : set this to 3
*/
