// October 2005
// B W-Husey
// Modified March 30th to include set-up of jousting
// This OnEnter script is used on the Jousting Ground. It retrieves the weather over Thunderstone Town
// and applies it here too (OFF DUE TO TILEMAGIC). Also plays the tournament music once before switching to background
// and sets up the lists using tilemagic
// 1 April 2006, Syrsnein, Modified to use the new blank tilt tile (dirt runs but no rail)
//      and tilt rail placeables.  **Note** You can add your weather back in now.
// 5th April, B W-Husey - Weather and disarming functions put back.

#include "cu_functions"

const int TILT_RAIL_NORMAL = ANIMATION_PLACEABLE_DEACTIVATE;
const int TILT_RAIL_SMALL  = ANIMATION_PLACEABLE_CLOSE;

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;
    //disarm entering party and store what weapons they used
    DisarmParty(oPC);
    object oArmor = GetItemPossessedBy(oPC, "DLA_JOUST_ARMOR");
    if (GetIsObjectValid(oArmor) && GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)!=oArmor)
    {
        AssignCommand(oPC, ActionEquipItem(oArmor, INVENTORY_SLOT_CHEST));
    }

    // Get the area object
    object oArea = GetArea(oPC);

    // Set up tilt rails if they have not been setup already
    // Height of tilt rails is determined by PC size/race
    if (GetLocalInt(GetArea(OBJECT_SELF), "bTiltRailSet")) return;

    int bSmall   = (GetCreatureSize(oPC)<CREATURE_SIZE_MEDIUM || GetRacialType(oPC)==RACIAL_TYPE_DWARF);
    int nRail    = bSmall ? TILT_RAIL_SMALL : TILT_RAIL_NORMAL;
    int i=0;
    object oWPTiltRail = GetObjectByTag("JoustList4", i);
    while (GetIsObjectValid(oWPTiltRail))
    {
        AssignCommand(oWPTiltRail, ActionPlayAnimation(nRail));
        oWPTiltRail = GetObjectByTag("JoustList4", ++i);
    }
    SetLocalInt(oArea, "bTiltRailSet", TRUE);
    // End tilt rail check/setup

    // Now check and set weather


    if (GetIsDefPC(oPC))
    {
    if (GetCalendarDay()!= GetLocalInt(oPC,"nWeatherDay"))//Check the weather for today (once a day)
    {
        DelayCommand(0.1,CheckWeather(GetArea(oPC),oPC));
        //debug line ************
    //    SendMessageToPC(oPC,"Checking Weather");
    }
    else  DelayCommand(0.1,GetMyWeather(oPC,oArea));

    DelayCommand(122.0,MusicBackgroundChangeDay(oArea,20));
    DelayCommand(122.0,MusicBackgroundChangeDay(oArea,20));
    SetLocalInt(oPC,"nWeatherDay",GetCalendarDay());
    }
}
