#include "x0_i0_position"
#include "nw_i0_generic"
#include "X0_i0_partywide"

const string CAN_SLEEP = "DDF_CAN_SLEEP";
const string CURRENT_DAY = "DDF_CURRENT_DAY";
const string FS_ITEM_RESREF = "furiaesentinel";
const string FS_PLACEABLE_RESREF = "pl_dlg_fs";
const string FS_DLG = "dlg_fs";
const string FS_ITEM_TAG = "fs_nspr_i";
const string RR_RESREF = "yyy";

const int BG_COP = 1;
const int BG_REVOLUTIONARY = 2;
const int BG_INDIE = 3;

const int TKN_BASE = 6000;
const int TKN_JOURNAL = 100;

const int ALIGNMENT_SLIP = 10;
const int ALIGNMENT_SLIGHT = 10;
const int ALIGNMENT_MODERATE = 20;

const int AREA_ALADARAS_APARTMENT = 10;
const int AREA_ALADARAS_BASEMENT = 20;
const int AREA_CORANO_VILLA = 30;
const int AREA_FIRST_NIGHTMARE = 40;
const int AREA_FORVORS_SHOP = 50;
const int AREA_GUARD_POST = 60;
const int AREA_GUVNER_RECORD_BUILDING = 70;
const int AREA_HARASIS_SMALL_APARTMENT = 80;
const int AREA_HARASIS_SOUL_TRADE_APARTMENT = 85;
const int AREA_KARKUALIIS_LAIR = 90;
const int AREA_MIDTOWN_MUNICIPAL_DISTRICT = 100;
const int AREA_NORTH_MARKET = 110;
const int AREA_RATHOLE_STREETS = 120;
const int AREA_ROOSTERS_ROOST = 130;
const int AREA_ROOSTERS_ROOST_BASEMENT = 140;
const int AREA_RUN_DOWN_INN = 150;
const int AREA_SEA_MARKET = 160;
const int AREA_SECOND_NIGHTMARE = 170;
const int AREA_SMUGGLERS_TUNNELS = 180;
const int AREA_SOUL_TRADE_INN = 190;
const int AREA_TEETH_OF_ORISAW = 200;
const int AREA_ULANS_WAREHOUSE = 210;
const int AREA_UNDERCITY = 220;
const int AREA_UNUSED_GUARD_POST = 230;
const int AREA_VOID_SPACE = 0;
const int AREA_YOUR_APARTMENT = 240;
const int AREA_YOUR_NEIGHBORHOOD = 250;

const string IN_AREA = "ddf_in_area";
const string PREVIOUS_AREA = "ddf_previous_area";

const int GATHER_PARTY_DISTANCE = 10;

const int INVESTIGATION_COMPLETE = 1;   // TRUE
const int INVESTIGATION_INCOMPLETE = -3; // it is now "closed" and totally unavailable for the rest of the module
const int INVESTIGATION_INPROGRESS = -1;
const int INVESTIGATION_AVAILABLE = -2;
const int INVESTIGATION_UNAVAILABLE = 0; // FALSE

const string IS_INVESTIGATING = "ddf_is_investigating";
const string INVESTIGATION_VAR = "ddf_area_investigation_";

const string JOURNAL_WORLDWINE = "ddf_j_001";
const string JOURNAL_WAREHOUSE = "ddf_j_002";
const string JOURNAL_STREET = "ddf_j_003"; // NOT FOR BETA
const string JOURNAL_CORANO = "ddf_j_004";
const string JOURNAL_ALADARA = "ddf_j_005"; //  <CUSTOM6500>
const string JOURNAL_ULAN = "ddf_j_006"; //     <CUSTOM6600>
const string JOURNAL_RINGS = "ddf_j_007"; //    <CUSTOM6700>
const string JOURNAL_NIGHTMARE = "ddf_j_008"; // <CUSTOM6800>
const string JOURNAL_CHOICE = "ddf_j_009";
const string JOURNAL_DISTRIBUTION = "ddf_j_010"; // <CUSTOM61000> -- 61000 --
const string JOURNAL_HARASI = "ddf_j_011"; //   <CUSTOM61100> -- 61100 --
const string JOURNAL_FORVOR = "ddf_j_012"; //   <CUSTOM61200>
const string JOURNAL_LUICIL = "ddf_j_013"; //   <CUSTOM61300>
const string JOURNAL_KRESH = "ddf_j_014"; //    <CUSTOM61400>
const string JOURNAL_TAG = "ddf_j_015"; //      <CUSTOM61500>
const string JOURNAL_COCHRANE = "ddf_j_016"; // <CUSTOM61600>

const int JOURNAL_FORVOR_IDX = 61200;
const int JOURNAL_LUICIL_IDX = 61300;
const int JOURNAL_KRESH_IDX = 61400;
const int JOURNAL_TAG_IDX = 61500;
const int JOURNAL_COCHRANE_IDX = 61600;

const int PARTY_TO_DAY = 1;
const int PARTY_TO_NIGHT = 2;

const string PARA = "\n\n";

// 2919-09-03 JY
// We are awarding all XP in the investigation complete events.
// If we still get the dialog for "you got 0 xp", i'll have to
// comment out all those file... Which maybe i'll do now anyway...
const int XP_SMALL = 0;
const int XP_MEDIUM = 0;
const int XP_LARGE = 0;
const string DDF_AWARD_XP = "ddf_award_xp";

const string HADLIEUTENANTDIALOG = "had_lieutenant_dialog";


/* Declarations */
// See https://nwn.fandom.com/wiki/Map_pin
// Return iPinID of the first deleted map pin within the personal map pin array
int GetFirstDeletedMapPin(object oPC);

// Set a personal map pin on oPC. Returns iPinID.
// Defaults: GetArea(oPC) and fX/fY from GetPosition(oPC)
int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID);

// Mark a map pin as deleted. Not a real delete to maintain the array
void DeleteMapPin(object oPC, int iPinID);

// Returns oArea from iPinID
object GetAreaOfMapPin(object oPC, int iPinID);

int GetCurrentArea(object oPC);

void SetHarasisSmallApartmentLocked(int bLocked);

void debug(string msg)
{
    // 2019-08-28 JY
    // Turning off all debug output for "real" builds.

    if(GetLocalInt(GetModule(), "ddf_debug_mode") == TRUE)
    {
        string sLog = "DEBUG: " + msg;
        SendMessageToPC(GetFirstPC(), sLog);
        //SendMessageToAllDMs(msg);
        PrintString(sLog);
        WriteTimestampedLogEntry(sLog);
        //MyPrintString(sLog);
    }

}

int HasKilledInPublic()
{
    // If you have killed anyone outside of Aladara's basement, Ulan's warehouse, Rathole, and the Soul Trade Inn
    // Lucas: "My thought was for this one that if we have a 'response to public murder' we could loop in a variable to that script or whatever..."
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_midtown_murder") == TRUE) return TRUE;

    return FALSE; // for now.
}

int HelpfulToLucenna(object oPC)
{
    // (If you turned Quillian in or gave Lucenna information)
    // (AND If PC is Good aligned)

    int iQuillInJail = GetLocalInt(GetModule(), "ddf_quill_in_jail");
    int iTellLucennaTruth = GetLocalInt(GetModule(), "ddf_luce_truth");
    int iAlignmentGoodEvil = GetFactionAverageGoodEvilAlignment(oPC);

    // If Quillian is turned in or you told the truth and you are good aligned
    if ( (iQuillInJail == TRUE || iTellLucennaTruth == TRUE) && iAlignmentGoodEvil == ALIGNMENT_GOOD)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}

void EnableMapPin(string sPinTag)
{
    object oMapPin = GetObjectByTag(sPinTag);
    if(oMapPin == OBJECT_INVALID) debug("-- unable to find map pin '" + sPinTag + "'.");
    else debug("-- found map pin '" + sPinTag +"'.");
    SetMapPinEnabled(oMapPin, TRUE);
}

void PartyDayToNight(object oPC, int iDayOrNight)
{
    object oFactionMember = GetFirstFactionMember(oPC);

    object oModule = GetModule();
    SetLocalInt(oModule, "ddf_day_night", iDayOrNight);

    while(GetIsObjectValid(oFactionMember))
    {
        //debug("setting day to night.. " + IntToString(iDayOrNight));

        if(iDayOrNight == PARTY_TO_NIGHT)
        {
            DayToNight(oFactionMember);
            debug("Setting NIGHT for " + GetName(oFactionMember));

        }
        if(iDayOrNight == PARTY_TO_DAY)
        {
            NightToDay(oFactionMember);
            debug("Setting DAY for " + GetName(oFactionMember));
        }
        oFactionMember = GetNextFactionMember(oFactionMember);
    }
}


void DoJournalUpdate(object oPC, string sJournalID, string sJournalText, int iUpdated, int iCustomToken, int bFinished)
{
    object oModule = GetModule();
    if(iUpdated <= GetLocalInt(oModule, sJournalID + "updates")) return;

    // if it is less then X in size, it isn't a "real" update.
    if(GetStringLength(sJournalText) < 2) return;

    debug("Update Journal: " + sJournalID + " - #" + IntToString(iUpdated) + ", Token: " + IntToString(iCustomToken) + ", Finished: " + IntToString(bFinished));

    SetCustomToken(iCustomToken, sJournalText);
    RemoveJournalQuestEntry(sJournalID, oPC, TRUE, TRUE);
    if(bFinished == TRUE)
    {
        AddJournalQuestEntry(sJournalID, 2, oPC, TRUE, TRUE, FALSE);
        // 2019-08-21
        // Lucas would like it to be NIGHT after an investigation is finished, DAY after sleeping.
        //PartyDayToNight(oPC, PARTY_TO_NIGHT);

        // 2019-08-22 JY
        // Rather then force a visual switch right here, we are going to set the
        // day/night var to night, so on next area transition, we then change to night-time.
        // I _guess_ this _could_ cause an issue for a player who is moving to a "sub-area" away from
        // their party, they could end up with NIGHT view, where-as the rest of the party is still in
        // DAY view...
        // 2019-09-03 JY
        // I think, like the below call to GiveXPToAll(), this SetLocalInt is happening in the wrong place.
        // I've moved it into the SetQuestState() methodt oo.
        //SetLocalInt(oModule, "ddf_day_night", PARTY_TO_NIGHT);

        // 2019-08-27 JY
        // Adding XP to get a player to level 8 by the end of the 5th day.
        // Takes 18,000 XP to get from 10,000 xp (level 5) to 28,000 (level 8)
        // so you get 3600 xp per day/investigation. 3600 * 5 = 18,000
        // 2019-09-03 JY
        // I put this in the wrong place -- it has been moved to SetQuestState()
        //GiveXPToAll(oPC, 3600);
    }
    else
    {
        AddJournalQuestEntry(sJournalID, 1, oPC, TRUE, TRUE, TRUE);
    }
    SetPanelButtonFlash(oPC, PANEL_BUTTON_JOURNAL, TRUE);
    SetLocalInt(oModule, sJournalID + "updates", iUpdated);
}

int CanPartySleep()
{
    object oModule = GetModule();
    if(GetLocalInt(oModule, CAN_SLEEP) == 0)
        return FALSE;

    return TRUE;
}

void SetPartyCanSleep(int nCanSleep)
{
    object oModule = GetModule();
    SetLocalInt(oModule, CAN_SLEEP, nCanSleep);
}

int GetCurrentDay()
{
    return GetLocalInt(GetModule(), CURRENT_DAY);
}

location GetStepOppositeLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    float fAngleOpposite = GetOppositeDirection(fDir);
    return GenerateNewLocation(oTarget, DISTANCE_TINY, fDir, fAngleOpposite);
}

void GiveItemToAllPartyMembers(object oMember, string sBlueprint, string sTag)
{
    debug("GiveItemToAllPartyMembers() " + sBlueprint + "/" + sTag + " - " + GetName(oMember));

    object oPartyMember = GetFirstFactionMember(oMember, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
    {
        if(GetItemPossessedBy(oPartyMember, sTag) == OBJECT_INVALID)
        {
            // give this player this item.
            CreateItemOnObject(sBlueprint, oPartyMember, 1);
            debug("Giving '" + sBlueprint + "' to " + GetName(oPartyMember));
        }
        oPartyMember = GetNextFactionMember(oMember, TRUE);
    }
}



int InHubArea(object oPC)
{
    int currentArea = GetCurrentArea(oPC);
    if(currentArea == AREA_SEA_MARKET || currentArea == AREA_YOUR_NEIGHBORHOOD) return TRUE;

    return FALSE;
}

string GetQuestDoneDateVariableName(int iArea)
{
    return "ddf_quest_" + IntToString(iArea) + "_done_date";
}
void SetQuestState(int iArea, int iState)
{
    object oModule = GetModule();

    debug("SetQuestState: " + IntToString(iArea) + ", " + IntToString(iState));
    SetLocalInt(oModule, INVESTIGATION_VAR + IntToString(iArea), iState);

    if(iState == INVESTIGATION_COMPLETE)
    {
        // have we already stored the "done" day?
        int iDay = GetLocalInt(oModule, GetQuestDoneDateVariableName(iArea));
        if(iDay == 0)
        {
            // hasent been set yet.
            SetLocalInt(oModule, GetQuestDoneDateVariableName(iArea), GetCurrentDay());

            // 2019-09-3 JY
            // Rather then force a visual switch right here, we are going to set the
            // day/night var to night, so on next area transition, we then change to night-time.
            // I _guess_ this _could_ cause an issue for a player who is moving to a "sub-area" away from
            // their party, they could end up with NIGHT view, where-as the rest of the party is still in
            // DAY view...
            SetLocalInt(oModule, "ddf_day_night", PARTY_TO_NIGHT);


            // 2019-09-03 JY
            // Adding XP to get a player to level 8 by the end of the 5th day.
            // Takes 18,000 XP to get from 10,000 xp (level 5) to 28,000 (level 8)
            // so you get 3600 xp per day/investigation. 3600 * 5 = 18,000
            // https://app.asana.com/0/842177838074622/805644791968340
            // 2019-09-5 JY
            // there are only 4 quests you can get, so we have to increase the amout
            // to 18,000/4 = 4500
            //GiveXPToAll(GetFirstPC(), 4500);
            // Now setting a flag, so when they return to a HUB zone, that is when we
            // reward them.
            SetLocalInt(oModule, DDF_AWARD_XP, TRUE);
        }
    }
}

int GetQuestDoneDate(int iArea)
{
    return GetLocalInt(GetModule(), GetQuestDoneDateVariableName(iArea));
}

int GetQuestState(int iArea)
{
    return GetLocalInt(GetModule(), INVESTIGATION_VAR + IntToString(iArea));
}


void UnlockUlanWarehouseQuest()
{

    debug("unlocking ulan's warehouse quest...");
    //if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE)
    //SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_AVAILABLE);
    // Unblock the area.
    object oWarehouseBlocker = GetObjectByTag("UlanWarehouseCageBlocker");
    if(GetIsObjectValid(oWarehouseBlocker) == FALSE)
    {
        debug("Unable to find the Ulan Warehouse Blocker object...");
    }
    else
    {
        SetPlotFlag(oWarehouseBlocker, FALSE);
        DestroyObject(oWarehouseBlocker);
        // 2019-08-28 JY
        // Remove the 2 npcs around the wagon which is blocking the entrance.
        // NOTE the "UlanWarehouseCageBlocker" is now a wagon, not the metal gate from before.
        object oNPC;
        oNPC = GetObjectByTag("UlanWarehouseBlockerNPC1");
        if(GetIsObjectValid(oNPC) == FALSE) debug("Can not find npc 1...");

        DestroyObject(oNPC);

        oNPC = GetObjectByTag("UlanWarehouseBlockerNPC2");
        if(GetIsObjectValid(oNPC) == FALSE) debug("Can not find npc 2...");

        DestroyObject(oNPC);
    }

}

void UpdateAvailableQuests(int iDay)
{
    debug("Update Available Quests for day " + IntToString(iDay));

    object oModule = GetModule();

    SetLocalInt(oModule, IS_INVESTIGATING, FALSE);

    if(iDay == 1)
    {
    }
    else if(iDay == 2)
    {
        // Not for beta
        //SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_AVAILABLE);
        //SetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT, INVESTIGATION_AVAILABLE);
    }
    else if(iDay == 3)
    {
        if(GetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT, INVESTIGATION_INCOMPLETE);
        }

        if(GetQuestState(AREA_RATHOLE_STREETS) == INVESTIGATION_COMPLETE)
        {
            //SetQuestState(AREA_ROOSTERS_ROOST, INVESTIGATION_AVAILABLE);
        }

        //SetQuestState(AREA_TEETH_OF_ORISAW, INVESTIGATION_AVAILABLE);
    }
    else if(iDay == 4)
    {
        if(GetQuestState(AREA_RATHOLE_STREETS) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_INCOMPLETE);
        }

        if(GetQuestState(AREA_ROOSTERS_ROOST) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_ROOSTERS_ROOST, INVESTIGATION_INCOMPLETE);
        }

        if(GetQuestState(AREA_TEETH_OF_ORISAW) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_TEETH_OF_ORISAW, INVESTIGATION_INCOMPLETE);
        }

        //if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE)
        if(GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_AVAILABLE)
        {
            UnlockUlanWarehouseQuest();
        }

        // Aladara
        //SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_AVAILABLE);

    }
    else if(iDay == 5)
    {


        // only if "eveidence found" for ULAN warehouse && not done yet.
        if(GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE)
        {
            object oBlockerWaypoint = GetObjectByTag("UlanWarehouseCageBlockerWaypoint");
            location lBlockerWaypoint = GetLocation(oBlockerWaypoint);
            object oBlocker = CreateObject(OBJECT_TYPE_PLACEABLE, "cagewall", lBlockerWaypoint, FALSE);
            SetPlotFlag(oBlocker, TRUE);
        }
        else if(GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_AVAILABLE)
        {
            UnlockUlanWarehouseQuest();
        }

        // NOT FOR BETA
        // Only if "evidence found"
        //SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_AVAILABLE);

    }
    else if(iDay == 6)
    {
        object oBlocker = GetObjectByTag("UlanWarehouseCageBlocker");
        if(GetIsObjectValid(oBlocker) == FALSE)
        {
            object oBlockerWaypoint = GetObjectByTag("UlanWarehouseCageBlockerWaypoint");
            location lBlockerWaypoint = GetLocation(oBlockerWaypoint);
            oBlocker = CreateObject(OBJECT_TYPE_PLACEABLE, "cagewall", lBlockerWaypoint, FALSE);
            SetPlotFlag(oBlocker, TRUE);
        }

        // ALADARA
        if(GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_INCOMPLETE);
        }
        if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_INCOMPLETE);
        }
        // HARASI
        if(GetQuestState(AREA_SOUL_TRADE_INN) != INVESTIGATION_COMPLETE)
        {
            SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_INCOMPLETE);
        }

        //SetQuestState(AREA_SMUGGLERS_TUNNELS, INVESTIGATION_AVAILABLE);

    }
}
void TryToKillQuillian()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE)
    {
        debug("-- already killed quillian.");
        return;
    }

    if(GetLocalInt(GetModule(), "ddf_quill_on_street") == FALSE)
    {
        debug("-- can't kill quillian as he is not on the street.");
        return;
    }

    SetLocalInt(oModule, "ddf_killed_quillian", TRUE);

    // Get Quill
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");

    if(oQuill == OBJECT_INVALID)
    {
        debug("-- unable to kill Quillian as i can't find him.");
        return;
    }

    if(GetCurrentHitPoints(oQuill) < 1)
    {
        debug("-- quill appears to already be dead, as his HP are less then 1...");
        return;
    }

    debug("Make Quill a corpse " + ObjectToString(oQuill));

    // Clear his plot flag so we can corpse him and set his destroyable to corpose
    SetPlotFlag(oQuill, FALSE);
    AssignCommand(oQuill, SetIsDestroyable(FALSE, FALSE, TRUE));

    // Teleport Quill
    object oWaypoint = GetWaypointByTag("smugglerstunnels_quill_dead");
    location locWP = GetLocation( oWaypoint );
    AssignCommand(oQuill, ActionJumpToLocation(locWP));

    // Apply a death effect to kill
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oQuill));

}

// 2019-08-22 JY
// https://app.asana.com/0/842177838074622/1124015019348105
void TryToRemoveSlaveAuctionSeaMarket()
{

    debug("Remove Slave Auctioneer");
    object oD4NPC = GetObjectByTag("SlaveAuctioneer");

    object oD4Waypoint = GetWaypointByTag("NW_LIMBO_OTHER");
    object oArea = GetArea(oD4NPC);

    object od4Object = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(od4Object))
    {
        if(GetTag(od4Object) == "SlaveUlan")
        {
            debug("-- moving slave...");
            AssignCommand(od4Object, ActionJumpToLocation(GetLocation(oD4Waypoint)));
            DestroyObject(od4Object, 10.0);
        }
        od4Object = GetNextObjectInArea(oArea);
    }

    AssignCommand(oD4NPC, ActionJumpToLocation(GetLocation(oD4Waypoint)));
    DestroyObject(oD4NPC, 10.0);
}


void IncrementDay()
{
    PartyDayToNight(GetFirstPC(), PARTY_TO_DAY);
    int nDay = GetCurrentDay();

    nDay = nDay + 1;

    debug("Setting module's DDF_CURRENT_DAY to " + IntToString(nDay));

    // Set the variables
    SetLocalInt(GetModule(), "DDF_CURRENT_DAY", nDay);
    SetLocalInt(GetModule(), CAN_SLEEP, FALSE);
    SetLocalInt(GetModule(), "ddf_quill_paid", FALSE);
    SetLocalInt(GetModule(), "ddf_forv_spoke", FALSE);
    //SetLocalInt(GetModule(), "ddf_forv_asked", FALSE);
    SetLocalInt(GetModule(), "ddf_luic_spoke", FALSE);
    SetLocalInt(GetModule(), "ddf_luic_asked", FALSE);

    UpdateAvailableQuests(nDay);

    // Day 2
    if (nDay == 2)
    {
        // Block Quillian's warehouse
        CreateObject(OBJECT_TYPE_PLACEABLE, "blockwarehousevi", GetLocation(GetWaypointByTag("BlockWarehouseVisual")));
        CreateObject(OBJECT_TYPE_PLACEABLE, "blockwarehousebl", GetLocation(GetWaypointByTag("BlockWarehouseBlocker")));

        // Remove all the flames at Quillian's warehouse
        object oArea = GetArea(GetObjectByTag("QuillianWarehouseFlame"));
        object oObject = GetFirstObjectInArea();
        while (GetIsObjectValid(oObject))
        {
            if (GetTag(oObject) == "QuillianWarehouseFlame")
            {
                DestroyObject(oObject);
            }
            oObject = GetNextObjectInArea(oArea);
        }

        // Remove the crowd at Quillian's warehouse
        DestroyObject(GetObjectByTag("SeaMarketCommoner1"));
        DestroyObject(GetObjectByTag("SeaMarketCommoner2"));
        DestroyObject(GetObjectByTag("SeaMarketCommoner3"));
        DestroyObject(GetObjectByTag("Commoner1WhisperingShylia"));
        DestroyObject(GetObjectByTag("Commoner2WhisperingShylia"));
        DestroyObject(GetObjectByTag("NamedWitnesstoExplosion"));
        DestroyObject(GetObjectByTag("NamedWitnesstoExplosion2"));
        DestroyObject(GetObjectByTag("Shylia"));

        // Move Lucenna to the City Guard HQ
        AssignCommand(GetObjectByTag("DDF_NPC_Lucenna"), ActionJumpToObject(GetWaypointByTag("GuardHQ_Lucenna"), FALSE));
        //SetLocalInt(GetModule(), "luce_001_done", TRUE);  // Make sure she only has the second dialog available.

        debug("Move Teddy to teeth of orisaw...");
        // Move Teddy to Teeth of Orisaw
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
        AssignCommand(oTeddy, ClearAllActions(TRUE));
        AssignCommand(oTeddy, ActionJumpToObject(GetWaypointByTag("ORISAW_TEDDY_SPAWN"), FALSE));

        // Move Harasi to Soul Trade Apartment
        AssignCommand(GetObjectByTag("DDF_NPC_HarasiF"), ActionJumpToObject(GetWaypointByTag("WP_HarasiSoulApt"), FALSE));
        SetPlotFlag(GetObjectByTag("DDF_NPC_HarasiF"), FALSE);
    }
    // Day 3
    if (nDay == 3)
    {
        debug("Move Teddy to Teeth of Orisaw...");
        // Move Teddy to Teeth of Orisaw
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
        AssignCommand(oTeddy, ClearAllActions(TRUE));
        AssignCommand(oTeddy, ActionJumpToObject(GetWaypointByTag("ORISAW_TEDDY_SPAWN"), FALSE));
    }
    // Day 4
    if (nDay == 4)
    {
        // Lock Harasi's Small Apartment.
        SetHarasisSmallApartmentLocked(TRUE);

        // If Quillian is on the street on day 4 we need to corpse him
        TryToKillQuillian();

        // If Teddy isn't dead then teleport him into the apartment
        if (GetLocalInt(GetModule(), "ddf_teddy_dead") == FALSE)
        {
            // Move Teddy here
            object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
            debug("Move Teddy " + GetName(oTeddy));

            object oTeddyStartWaypoint = GetWaypointByTag("AladaraAptTeddy");
            location locTDWP = GetLocation( oTeddyStartWaypoint );
            AssignCommand(oTeddy, ActionJumpToLocation(locTDWP));
        }

        // Teleport Ulan into his warehouse
        object oUlan = GetObjectByTag("DDF_NPC_UlanA");
        object oUlanWP = GetWaypointByTag("UlanWaypoint");
        AssignCommand(oUlan, ActionJumpToLocation(GetLocation(oUlanWP)));
        SetPlotFlag(oUlan, FALSE);

        TryToRemoveSlaveAuctionSeaMarket();

    }
    if (nDay == 5)
    {
        TryToKillQuillian();
    }

    // Day 6
    if (nDay == 6)
    {
        TryToKillQuillian();

        // Remove the placed 'cage' object so that the Party can now access the Smuggler's Tunnels
        object oCage = GetObjectByTag("StrongSteelCage");
        DestroyObject(oCage);

        // If Ulan is still alive, teleport him into the tunnel
        // see https://app.asana.com/0/801776688207245/916760837537396/f
        if (GetLocalInt(GetModule(), "ddf_ulan_dead") == TRUE || GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE )
        {
            // Remove placed Undercity Ulan if he is dead, or you
            object oUlan = GetObjectByTag("DDF_NPC_Ulan_Undercity");
            DestroyObject(oUlan, 0.0);
        }

        // If Aladara is still alive we need to hook her up with Karkualli
        if(GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE)
        {
            debug("-- moving Aladara to Kark Lair.");

            object oAladara = GetObjectByTag("DDF_NPC_Aladara");
            if(oAladara == OBJECT_INVALID) debug("-- unable to find aladara.");

            // move to to kark's lair.
            object oWaypoint = GetObjectByTag("KARK_ALADARA");
            if(oWaypoint == OBJECT_INVALID) debug("-- unable to find aladara waypoint in kark lair.");

            AssignCommand(oAladara, ClearAllActions(TRUE));
            AssignCommand(oAladara, ActionJumpToObject(oWaypoint, FALSE));
        }
    }
}

int GetPartyBackground()
{
    return GetLocalInt(GetModule(), "ddf_background_flag");
}

void SetPartyAsIndependent()
{
    debug("--  SetPartyAsIndependent()");

    SetLocalInt(GetModule(), "ddf_background_flag", BG_INDIE);
    object oPC = GetFirstPC();
    GiveItemToAllPartyMembers(oPC, "primeworldgem", "PrimeWorldGem");
}

void SetPartyAsRevolutionary()
{
    debug("--  SetPartyAsRevolutionary()");

    SetLocalInt(GetModule(), "ddf_background_flag", BG_REVOLUTIONARY);

    // if they don't already have it, give it to them.
    object oPC = GetFirstPC();
    GiveItemToAllPartyMembers(oPC, "revolutionaryrin", "RevolutionaryRing");

}

void SetPartyAsGuard()
{
    debug("-- SetPartyAsGuard()");

    SetLocalInt(GetModule(), "ddf_background_flag", BG_COP);

    // if they don't already have it, give it to them.
    object oPC = GetFirstPC();
    GiveItemToAllPartyMembers(oPC, "furiaebadge", "FuriaeBadge");
}

int MovePlayerToObject(object oPC, object oTarget, int bFade = TRUE)
{
   if(GetIsObjectValid(oPC) == FALSE ||  GetIsPC(oPC) == FALSE ||  GetIsObjectValid(oTarget) == FALSE)
    {
        //debug("MovePlayerToObject() - Invalid object for pc or target");
        return FALSE;
    }

    object oHenchman;
    object oFamiliar;
    object oAnimal;
    object oSummoned;
    object oDominated;

    float fHenchman;
    float fFamiliar;
    float fSummoned;
    float fAnimal;
    float fDominated;

    // move all their "associates" too.
    int iCounter = 1;
    float fAllowedDistance = 10.0;

    for(iCounter = 1; iCounter < 5; iCounter++)
    {
            oHenchman   = GetHenchman(oPC, iCounter);
            oFamiliar   = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, iCounter);
            oSummoned   = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, iCounter);
            oAnimal     = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, iCounter);
            oDominated  = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC, iCounter);

            fHenchman   = GetDistanceBetween(oPC, oHenchman);
            fFamiliar   = GetDistanceBetween(oPC, oFamiliar);
            fSummoned   = GetDistanceBetween(oPC, oSummoned);
            fAnimal     = GetDistanceBetween(oPC, oAnimal);
            fDominated  = GetDistanceBetween(oPC, oDominated);

            if (fHenchman < fAllowedDistance && !GetIsDead(oHenchman))
            {
                //TeleportIndividual(oHenchman, lDestination, fHeightFallen, nVis, nVisID, fVisDelay);
                AssignCommand(oHenchman, ClearAllActions());
                DelayCommand(2.0, AssignCommand(oHenchman, ActionJumpToObject(oTarget, FALSE)));
            }
            if (fFamiliar < fAllowedDistance && !GetIsDead(oFamiliar))
            {
                //TeleportIndividual(oFamiliar, lDestination, fHeightFallen, nVis, nVisID, fVisDelay);
                AssignCommand(oFamiliar, ClearAllActions());
                DelayCommand(2.0, AssignCommand(oFamiliar, ActionJumpToObject(oTarget, FALSE)));
            }
            if (fSummoned < fAllowedDistance && !GetIsDead(oSummoned))
            {
                //TeleportIndividual(oSummoned, lDestination, fHeightFallen, nVis, nVisID, fVisDelay);
                AssignCommand(oSummoned, ClearAllActions());
                DelayCommand(2.0, AssignCommand(oSummoned, ActionJumpToObject(oTarget, FALSE)));

            }
            if (fAnimal < fAllowedDistance && !GetIsDead(oAnimal))
            {
                //TeleportIndividual(oAnimal, lDestination, fHeightFallen, nVis, nVisID, fVisDelay);
                AssignCommand(oAnimal, ClearAllActions());
                DelayCommand(2.0, AssignCommand(oAnimal, ActionJumpToObject(oTarget, FALSE)));

            }
            if (fDominated < fAllowedDistance && !GetIsDead(oDominated))
            {
               // TeleportIndividual(oDominated, lDestination, fHeightFallen, nVis, nVisID, fVisDelay);
                AssignCommand(oDominated, ClearAllActions());
                DelayCommand(2.0, AssignCommand(oDominated, ActionJumpToObject(oTarget, FALSE)));

            }
    }



    AssignCommand(oPC, ClearAllActions());
    SetCutsceneMode(oPC);
    FadeToBlack(oPC);
    DelayCommand(2.0, AssignCommand(oPC, ActionJumpToObject(oTarget, FALSE)));
    DelayCommand(3.0, FadeFromBlack(oPC));
    DelayCommand(3.0, SetCutsceneMode(oPC, FALSE));

    return TRUE;
}

int MovePartyToObject(object oPC, object oTarget, int bFade = FALSE, int bForceAll = FALSE, string sGather = "You must gather your party before ventruing forth")
{
    if(GetIsObjectValid(oPC) == FALSE) return FALSE;
    if(GetIsPC(oPC) == FALSE) return FALSE;
    if(GetIsObjectValid(oTarget) == FALSE)
    {
        debug("MovePartyToObject() - Invalid object for target");
        return FALSE;
    }

    object oFirstMember = oPC; //Gets the first member of the party
    object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE); //Gets the second member of the party if there is one.
    //location lDestination= GetLocation(GetObjectByTag("TEST_DESTINATION")); // Set the tag to your destination's tag.
    if(bForceAll == FALSE)
    {
        while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
            if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
                int iDistanceCheck = FloatToInt (GetDistanceToObject (oPartyMember));
                if (iDistanceCheck > 10) // Check to see if oPartyMember is within 10 meters. If not, send the message and exit the script without transition.
                {
                    ActionSpeakString (sGather, TALKVOLUME_TALK);
                    return FALSE;
                }
            }
            oPartyMember = GetNextFactionMember (oFirstMember, TRUE); //Set oPartyMember to the next person in the party.
        }
    }
    // If you've made it to here, everyone is within 10 meters, now time to jump to location.
    // We're going to have to scroll through the list again to do it.


    int bPCOnly = TRUE;
    int iCounter = 0;
    for(iCounter = 0; iCounter < 2; iCounter = iCounter + 1)
    {
        if(iCounter == 1) bPCOnly = FALSE;
        oPartyMember = GetFirstFactionMember (oFirstMember, bPCOnly); //Start the list over again
        while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
            if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
                // Send the party member to the destination
                AssignCommand(oPartyMember, ClearAllActions());
                if(bFade)
                {
                    if(GetIsPC(oPartyMember) == TRUE)
                    {
                        debug("fade to black for " + GetPCPlayerName(oPartyMember));
                        SetCutsceneMode(oPartyMember);
                        FadeToBlack(oPartyMember);
                    }

                    DelayCommand(2.0, AssignCommand(oPartyMember, ActionJumpToObject(oTarget, FALSE)));// JumpToLocation (lDestination));

                    if(GetIsPC(oPartyMember) == TRUE)
                    {
                        DelayCommand(3.0, FadeFromBlack(oPartyMember));
                        DelayCommand(3.0, SetCutsceneMode(oPartyMember, FALSE));
                    }
                }
                else
                {
                    AssignCommand(oPartyMember, ActionJumpToObject(oTarget, FALSE));
                }
            }
            oPartyMember = GetNextFactionMember (oFirstMember, bPCOnly); //Set oPartyMember to the next person in the party.
        }
    }
    // Last but not least, send the PC who clicked in the first place.
    // The script will go here right away if the party only has one person in it.
    //AssignCommand(oFirstMember, ClearAllActions());
    //AssignCommand(oFirstMember, ActionJumpToObject(oTarget, FALSE));//JumpToLocation (lDestination));
    return TRUE;
}
void PartyFadeFromBlack(int cutSceneMode = FALSE)
{
    object oFirstMember = GetFirstPC(); //Gets the first member of the party
    object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE); //Gets the second member of the party if there is one.

    int bPCOnly = TRUE;
    int iCounter = 0;
    for(iCounter = 0; iCounter < 2; iCounter = iCounter + 1)
    {
        //if(iCounter == 1) bPCOnly = FALSE;
        oPartyMember = GetFirstFactionMember (oFirstMember, bPCOnly); //Start the list over again
        while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
            if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
                if(GetIsPC(oPartyMember))
                {
                    SetCutsceneMode(oPartyMember, cutSceneMode);

                    FadeFromBlack(oPartyMember);
                }
            }
            oPartyMember = GetNextFactionMember (oFirstMember, bPCOnly); //Set oPartyMember to the next person in the party.
        }
    }
}

void PartyFadeToBlack(int cutSceneMode = FALSE)
{
    object oFirstMember = GetFirstPC(); //Gets the first member of the party
    object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE); //Gets the second member of the party if there is one.

    int bPCOnly = TRUE;
    int iCounter = 0;
    for(iCounter = 0; iCounter < 2; iCounter = iCounter + 1)
    {
        //if(iCounter == 1) bPCOnly = FALSE;
        oPartyMember = GetFirstFactionMember (oFirstMember, bPCOnly); //Start the list over again
        while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
            if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
                if(GetIsPC(oPartyMember))
                {
                    SetCutsceneMode(oPartyMember, cutSceneMode);

                    FadeToBlack(oPartyMember);
                }
            }
            oPartyMember = GetNextFactionMember (oFirstMember, bPCOnly); //Set oPartyMember to the next person in the party.
        }
    }
}

void ActionMovePartyToObject(object oPC, object oTarget, int bFade = FALSE, int bForceAll = FALSE)
{
    MovePartyToObject(oPC, oTarget, bFade, bForceAll);
}

void SetQuestWasActive(int iQuest)
{
    string sVar = "ddf_quest_was_active_" + IntToString(iQuest);
    SetLocalInt(GetModule(), sVar, TRUE);
    //debug("SetQuestWasActive() " + sVar);
}
int GetQuestWasActive(int iQuest)
{
    string sVar = "ddf_quest_was_active_" + IntToString(iQuest);
    //debug("GetQuestWasActive() " + sVar);
    return GetLocalInt(GetModule(), sVar);
}

void TryToMakeAvailable(int iQuest)
{
    int iQuestState = GetQuestState(iQuest);

    if(iQuestState == INVESTIGATION_UNAVAILABLE ||
        iQuestState == INVESTIGATION_AVAILABLE ||
        iQuestState == INVESTIGATION_INPROGRESS)
    {
        //debug("Making Investigation " + IntToString(iQuest) + " available.");
        if(iQuestState == INVESTIGATION_UNAVAILABLE) SetQuestState(iQuest, INVESTIGATION_AVAILABLE);
        SetQuestWasActive(iQuest);
    }
}

int QuestActive(int iQuest)
{
    if(GetQuestState(iQuest) == INVESTIGATION_AVAILABLE) return TRUE;
    if(GetQuestState(iQuest) == INVESTIGATION_INPROGRESS) return TRUE;
    if(GetQuestState(iQuest) == INVESTIGATION_COMPLETE) return TRUE;

    return FALSE;
}

void SetHarasisSmallApartmentLocked(int bFlag)
{
    debug("Setting Harasis' Small Apartment lock: " + IntToString(bFlag));

    object oRatholeDoor = GetObjectByTag("FromRatholeToHarasisApt");
    object oRoosterDoor = GetObjectByTag("FromRoostersToHarasisSmallApt");

    if(GetIsObjectValid(oRatholeDoor) == FALSE)
    {
        debug("Unable to find rathole door...");
    }
    else
    {
        SetLocked(oRatholeDoor, bFlag);
    }


    if(GetIsObjectValid(oRoosterDoor) == FALSE)
    {
        debug("Unable to find rooster door...");
    }
    else
    {
        SetLocked(oRoosterDoor, bFlag);
    }
}

void TryUnlockHarasisSmallApartment()
{
    if(GetLocalInt(GetModule(), "ddf_visited_harasis_small_apartment") == TRUE)
    {
        // Can't get in a second time!
        debug("Can't unlock Harasis' Small Apartment, has already been visited.");
        return;
    }

    SetHarasisSmallApartmentLocked(FALSE);
}

int GetCurrentArea(object oPC)
{
    return GetLocalInt(oPC, IN_AREA);
}

void SetCurrentArea(object oPC, int iArea)
{
    int iPrevious = GetCurrentArea(oPC);// GetLocalInt(oPC, IN_AREA);
    SetLocalInt(oPC, PREVIOUS_AREA, iPrevious);
    SetLocalInt(oPC, IN_AREA, iArea);

    debug("Moving " + GetName(oPC) + " from " + IntToString(iPrevious) + " -> " + IntToString(iArea));

    // Also do the day/night swap here.
    object oModule = GetModule();
    int iDayNight = GetLocalInt(oModule, "ddf_day_night");
    if(iDayNight == PARTY_TO_DAY) NightToDay(oPC);
    if(iDayNight == PARTY_TO_NIGHT) DayToNight(oPC);

    // 2019-09-05 JY
    // We want to award the XP after finishing the investigation once
    // the PCs return to a HUB zone.
    // See SetQuestState() for where we set the bool.
    // https://app.asana.com/0/801956336525729/805644791968340
    if(GetLocalInt(oModule, DDF_AWARD_XP) == TRUE && InHubArea(oPC) == TRUE)
    {
        SetLocalInt(oModule, DDF_AWARD_XP, FALSE);
        GiveXPToAll(oPC, 4500);
    }
}

int GetPreviousArea(object oPC)
{
    return GetLocalInt(oPC, PREVIOUS_AREA);
}
/* Implementation */
// see https://nwn.fandom.com/wiki/Map_pin
int GetFirstDeletedMapPin(object oPC)
{
   int i;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) {
       for(i=1; i<=iTotal; i++) {
           if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(i)) == "DELETED") {
               iPinID = i;
               break;
           }
       }
   }
   return iPinID;
}

int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID)
{
   // If oArea is not valid, we use the current area.
   if(oArea == OBJECT_INVALID) { oArea = GetArea(oPC); }
   // if fX and fY are both -1.0, we use the position of oPC
   if(fX == -1.0 && fY == -1.0) {
       vector vPos=GetPosition(oPC);
       fX = vPos.x;
       fY = vPos.y;
   }
   // Find out if we can reuse a deleted map pin
   int iUpdateDeleted = TRUE;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) { iPinID = GetFirstDeletedMapPin(oPC); }
   // Otherwise use a new one
   if(iPinID == 0) { iPinID = iTotal + 1; iUpdateDeleted = FALSE; }
   // Set the pin
   string sPinID = IntToString(iPinID);
   SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, sPinText);
   SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, fX);
   SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, fY);
   SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, oArea);
   if(!iUpdateDeleted) { SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", iPinID); }
   return iPinID;
}

void DeleteMapPin(object oPC, int iPinID)
{
   string sPinID = IntToString(iPinID);
   // Only mark as deleted if set
   if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID) != "") {
       SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, "DELETED");
       SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, 0.0);
       SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, 0.0);
       SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, OBJECT_INVALID);
   }
}

object GetAreaOfMapPin(object oPC, int iPinID)
{
   return GetLocalObject(oPC, "NW_MAP_PIN_AREA_"+IntToString(iPinID));
}

void MakeUlanWarehouseSlavesFlee()
{
    // make slaves flee.

    SetLocalInt(GetModule(), "ddf_ulan_slaves_fleeing", TRUE);

    string sSlaveTag = "SlaveUlanWH";
    int iCounter = 0;
    object oNPC = GetObjectByTag(sSlaveTag, iCounter);
    while(oNPC != OBJECT_INVALID)
    {
        debug("-- slave fleeing. " + GetName(oNPC));

        AssignCommand(oNPC, ActivateFleeToExit());

        iCounter = iCounter + 1;

        oNPC = GetObjectByTag(sSlaveTag, iCounter);
    }
}

void AddHenchperson(object oPC, object oNPC, int setPlotFlag = FALSE)
{
    debug("Adding " + GetName(oNPC) + " as hench person to " + GetName(oPC));

    AddHenchman(oPC, oNPC);
    SetPlotFlag(oNPC, setPlotFlag);
}

void RemoveHenchperson(object oNPC, int setPlotFlag = TRUE)
{
    object oMaster = GetMaster(oNPC);
    if(GetIsObjectValid(oMaster))
    {
        debug("Removing " + GetName(oNPC) + " as henchman to " + GetName(oMaster));
        RemoveHenchman(oMaster, oNPC);
    }
    SetPlotFlag(oNPC, setPlotFlag);
}
