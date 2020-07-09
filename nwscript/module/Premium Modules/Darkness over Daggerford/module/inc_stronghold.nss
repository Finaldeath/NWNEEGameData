#include "hf_in_cutscene"

// ---------------------------------------------------------------------
// PRIVATE
// ---------------------------------------------------------------------

// return a unique integer timestamp for the current time in days
int QuestGetCurrentTimeStamp()
{
    return ( GetCalendarYear()  * 336)
         + ( GetCalendarMonth() * 28)
         + ( GetCalendarDay());
}

// find the player's highest class
int QuestGetHighestClass(object oPC)
{
    int nPos = 1;
    int nClassLevel1 = GetLevelByPosition(1, oPC);
    int nClassLevel2 = GetLevelByPosition(2, oPC);
    int nClassLevel3 = GetLevelByPosition(3, oPC);
    if (nClassLevel1 > nClassLevel2)
    {
        if (nClassLevel1 > nClassLevel3)
        {
            nPos = 1;
        }
        else
        {
            nPos = 3;
        }
    }
    else
    {
        if (nClassLevel2 > nClassLevel3)
        {
            nPos = 2;
        }
        else
        {
            nPos = 3;
        }
    }
    return(GetClassByPosition(nPos, oPC));
}

// return the "intro" dialog file for each NPC
string QuestGetDialogFile(object oNPC)
{
    string sDlg = "";
    string sTag = GetResRef(oNPC);
    if      (sTag == "ks_gris_page")   sDlg = "ks_ar1300_page";
    else if (sTag == "ks_druid_chick") sDlg = "ks_ar1300_chick";
    else if (sTag == "ks_deldarine")   sDlg = "ks_ar1300_delda";
    else if (sTag == "ks_jared")       sDlg = "ks_ar1300_jared";
    else if (sTag == "ks_vetrixia")    sDlg = "ks_ar1300_vetrix";
    return(sDlg);
}

// init the quest variables (should only be called once)
void QuestInit(object oPC)
{
    object oMod = GetModule();

    // each quest is targetted at a specific player class
    // ... these are the tags of the NPCs who give the quests
    string sFighterTag = "ks_gris_page";
    string sDruidTag   = "ks_druid_chick";
    string sMageTag    = "ks_deldarine";
    string sClericTag  = ""; // varies by alignment (see below)

    // figure out which cleric tag (good/evil) applies
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        sClericTag = "ks_jared";
    }
    else
    {
        sClericTag = "ks_vetrixia";
    }

    // quests are given in an order that should appeal to the player's class
    int nClass = QuestGetHighestClass(oPC);
    if (nClass == CLASS_TYPE_CLERIC)
    {
        SetLocalString(oMod, "sQuestTag1", sClericTag);
        SetLocalString(oMod, "sQuestTag2", sFighterTag);
        SetLocalString(oMod, "sQuestTag3", sDruidTag);
        SetLocalString(oMod, "sQuestTag4", sMageTag);
    }
    else if (nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_PALEMASTER)
    {
        SetLocalString(oMod, "sQuestTag1", sMageTag);
        SetLocalString(oMod, "sQuestTag2", sClericTag);
        SetLocalString(oMod, "sQuestTag3", sDruidTag);
        SetLocalString(oMod, "sQuestTag4", sFighterTag);
    }
    else if (nClass == CLASS_TYPE_DRUID || nClass == CLASS_TYPE_SHIFTER)
    {
        SetLocalString(oMod, "sQuestTag1", sDruidTag);
        SetLocalString(oMod, "sQuestTag2", sClericTag);
        SetLocalString(oMod, "sQuestTag3", sFighterTag);
        SetLocalString(oMod, "sQuestTag4", sMageTag);
    }
    else
    {
        SetLocalString(oMod, "sQuestTag1", sFighterTag);
        SetLocalString(oMod, "sQuestTag2", sClericTag);
        SetLocalString(oMod, "sQuestTag3", sDruidTag);
        SetLocalString(oMod, "sQuestTag4", sMageTag);
    }

    // quest locations are random but never repeat sequentially
    SetLocalInt(oMod, "nQuestType1", 1);
    SetLocalInt(oMod, "nQuestType2", 2);
    SetLocalInt(oMod, "nQuestType3", 1);
    SetLocalInt(oMod, "nQuestType4", 2);

    // quest index represents the next quest in the arrays
    SetLocalInt(oMod, "nQuestIndex", 1);
}

// is it time to spawn the next quest?
int QuestIsReady(object oPC)
{
    // make sure the quest system is init'd
    object oMod = GetModule();
    if (GetLocalInt(oMod, "nQuestInit") == 0)
    {
        SetLocalInt(oMod, "nQuestInit", 1);
        QuestInit(oPC);
    }

    // do nothing if we've given out all the quests
    if (GetLocalInt(oMod, "nQuestIndex") >= 5)
    {
        return(FALSE);
    }

    // do nothing if a quest is already waiting
    if (GetLocalInt(oMod, "nQuestMsgerWaiting") != 0 ||
        GetLocalInt(oMod, "nQuestWaiting")      != 0 ||
        GetLocalInt(oMod, "nQuestMsgerSpawn")   != 0)
    {
        return(FALSE);
    }

    // do nothing if not enough "game time" has passed
    /*
    int nQuestLastTime = GetLocalInt(oMod, "nQuestLastTime");
    if (QuestGetCurrentTimeStamp() - nQuestLastTime < 1)
    {
        return(FALSE);
    }
    */

    // increment the counter
    int nQuestCounter = GetLocalInt(GetModule(), "nQuestCounter");
    SetLocalInt(GetModule(), "nQuestCounter", ++nQuestCounter);

    // quest is ready after a certain amount of time has passed
    int nQuestLastCounter = GetLocalInt(GetModule(), "nQuestLastCounter");
    if (nQuestCounter - nQuestLastCounter >= 2)
    {
        return(TRUE);
    }
    return(FALSE);
}

// rings the stronghold doorbell (if player is in right area)
void QuestRingDoorbell(object oPC)
{
    // the bell won't ring unless a quest is ready
    if (GetLocalInt(GetModule(), "nQuestMsgerWaiting") == 0)
    {
        return;
    }

    // doorbell will ring when player is inside the Stronghold (or on roof)
    if (GetLocalInt(GetModule(), "nQuestInsideStronghold") != 0)
    {
        AssignCommand(oPC, PlaySound("as_cv_belltower2"));
        AssignCommand(oPC, SpeakString("The front entrance bell has rung. Someone is at the door."));
    }
}

// ---------------------------------------------------------------------
// PUBLIC
// ---------------------------------------------------------------------

// called when player enters stronghold
// ... this will create a messenger outside the stronghold
void QuestStrongholdEnter(object oPC)
{
    // did the player enter through the front door?
    if (GetLocalInt(GetModule(), "nQuestEnteringStronghold") == 0)
    {
        return;
    }

    // the player is now inside the stronghold
    SetLocalInt(GetModule(), "nQuestEnteringStronghold", 0);
    SetLocalInt(GetModule(), "nQuestInsideStronghold", 1);

    // see if any quests are ready to give
    if (QuestIsReady(oPC))
    {
        object oMod = GetModule();
        int nQuestIndex = GetLocalInt(GetModule(), "nQuestIndex");
        int nQuestType = GetLocalInt(GetModule(), "nQuestType"+IntToString(nQuestIndex));
        if (nQuestType == 1)
        {
            // door quest - someone is waiting outside
            SetLocalInt(oMod, "nQuestMsgerSpawn", 1);
        }
        if (nQuestType == 2)
        {
            // doorbell quest - someone is waiting outside; ring bell
            SetLocalInt(oMod, "nQuestMsgerSpawn", 1);
            DelayCommand(15.0+Random(10), QuestRingDoorbell(oPC));
        }
        if (nQuestType == 3)
        {
            // wait quest - spawn when the player exits liam's hold
            SetLocalInt(oMod, "nQuestWaiting", 1);
        }
    }
}

// spawn the next quest messenger outside the stronghold
void QuestMessengerSpawn(object oPC)
{
    object oMod = GetModule();
    if (GetLocalInt(oMod, "nQuestMsgerSpawn") == 1)
    {
        SetLocalInt(oMod, "nQuestMsgerSpawn", 0);
        SetLocalInt(GetModule(), "nQuestMsgerWaiting", 1);
        int nQuestIndex = GetLocalInt(oMod, "nQuestIndex");
        int nQuestCounter = GetLocalInt(oMod, "nQuestCounter");
        object oWP = GetWaypointByTag("WP_AR1300_MESSENGER");
        string sTag = GetLocalString(oMod, "sQuestTag"+IntToString(nQuestIndex));
        object oMsger = CreateObject(OBJECT_TYPE_CREATURE, sTag, GetLocation(oWP));
        SetLocalObject(oMod, "oQuestGiver", oMsger);
        SetLocalInt(oMsger, "HF_DISABLE_AM", 1);
        SetLocalInt(oMod, "nQuestLastCounter", nQuestCounter);
        SetLocalInt(oMod, "nQuestLastTime", QuestGetCurrentTimeStamp());
        SetLocalInt(oMod, "nQuestIndex", ++nQuestIndex);
    }
}

// the stronghold messenger waiting outside the stronghold will talk
void QuestMessengerTalk(object oPC)
{
    object oMsger = GetLocalObject(GetModule(), "oQuestGiver");
    if (GetIsObjectValid(oMsger))
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oMsger, ClearAllActions());
        CutscenePlay(oPC, "mv_ar1300_3");
    }
}

// the stronghold messenger waiting outside the stronghold will run away
void QuestMessengerFlee(object oPC)
{
    object oMsger = GetLocalObject(GetModule(), "oQuestGiver");
    if (GetIsObjectValid(oMsger))
    {
        int n = d4();
        string sExitName = "WP_AR1300_MESSENGER_" + IntToString(n) + "_EXIT";
        SetLocalString(oMsger, "HF_EXIT_NAME", sExitName);
        SetLocalInt(oMsger, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oMsger);
        DeleteLocalObject(GetModule(), "oQuestGiver");
        SetLocalInt(GetModule(), "nQuestMsgerWaiting", 0);
    }
}

// called when player exits liam's hold area using one of the "world map" exits
// ... this might create a messenger waiting around for player to return
void QuestAreaExit(object oPC)
{
    if (GetLocalInt(GetModule(), "nQuestWaiting") != 0)
    {
        SetLocalInt(GetModule(), "nQuestWaiting", 0);
        QuestMessengerSpawn(oPC);
    }
}

// called when player enters a trigger just outside the stronghold's only door
void QuestGiveQuestStart(object oPC)
{
    // note that the player is "probably" entering the stronghold
    SetLocalInt(GetModule(), "nQuestEnteringStronghold", 1);
    SetLocalInt(GetModule(), "nQuestInsideStronghold", 0);
}

// called when player exits a trigger outside the stronghold
void QuestGiveQuestEnd(object oPC)
{
    // the player is no longer inside the stronghold
    SetLocalInt(GetModule(), "nQuestInsideStronghold", 0);
}

/*
Variables:
- nQuestInsideStronghold - true if player is inside the stronghold
- nQuestInit - true if quest system has init'd
- nQuestCounter - increments represent delay between quests
- nQuestLastCounter - last count a quest was given
- nQuestLastTime - last time a quest was given
- nQuestWaiting - true if spawn quest on area exit
- nQuestMsgerWaiting - true if a messenger is waiting for the player
- nQuestMsgerSpawn - true if a messenger should be spawned outside stronghold
- nQuestIndex - index into quest arrays (1 thru 4)
- nQuestType# - array (type 1 = door knock; type 2 = doorbell; type 3 = waiting outside)
- sQuestTag# - array of messenger resrefs

Waypoints:
- WP_AR1300_MESSENGER - spawn point for messenger
- WP_AR1300_MESSENGER_X_EXIT - exit destination for messenger; X=1-4
*/

