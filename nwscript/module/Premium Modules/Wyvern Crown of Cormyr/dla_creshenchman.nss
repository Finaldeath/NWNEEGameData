// October 2003
// B W-Husey (adaption of standard Bioware script)
// Spawn script for henchman
// Modified Feb 2004 to update henchman behaviour
// Modified April 2004 to add henchman behaviour commands

//#include "cu_treasure"
//#include "cu_magic"
#include "x0_inc_henai"
#include "x2_inc_banter"
#include "x2_inc_globals"

// * there are only a couple potential interjections henchmen can say in c3
void StrikeOutStrings(object oNathyrra)
{
    SetLocalString(oNathyrra, "X2_L_RANDOMONELINERS", "26|27|28|29|30|");
    SetLocalString(oNathyrra, "X2_L_RANDOM_INTERJECTIONS", "6|7|");
}
void main()
{
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));
    string sModuleTag = GetTag(GetModule());
    string sMyTag = GetTag(OBJECT_SELF);

    //Sets up the special henchmen listening patterns
    SetAssociateListenPatterns();
    SetListening(OBJECT_SELF,TRUE);

    // Set additional henchman listening patterns
    bkSetListeningPatterns();

    // Custom listening patterns for spoken commands (BWH)
    SetListenPattern(OBJECT_SELF,"open",1);
    SetListenPattern(OBJECT_SELF,"disarm",2);
    SetListenPattern(OBJECT_SELF,"flee",3);
    SetListenPattern(OBJECT_SELF,"come",4);
    SetListenPattern(OBJECT_SELF,"hide",5);
    SetListenPattern(OBJECT_SELF,"search",6);
    SetListenPattern(OBJECT_SELF,"combat",7);
    SetListenPattern(OBJECT_SELF,"melee",8);
    SetListenPattern(OBJECT_SELF,"ranged",9);
    SetListenPattern(OBJECT_SELF,"stop",10);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"open",11);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"disarm",12);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"flee",13);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"come",14);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"hide",15);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"search",16);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"combat",17);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"melee",18);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"ranged",19);
    SetListenPattern(OBJECT_SELF,GetStringLeft(GetStringLowerCase(GetTag(OBJECT_SELF)),1)+"stop",20);

    // Default behavior for henchmen at start
    SetAssociateState(NW_ASC_POWER_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    //Use melee weapons by default
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);

    // Set starting location *not sure if I need these!
    SetAssociateStartLocation();
    // Set respawn location
    SetRespawnLocation();   //*!

    // For some general behavior while we don't have a master,
    // let's do some immobile animations
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
    SetIsDestroyable(FALSE, TRUE, FALSE);

    // * September 2003
    // * Scan through all equipped items and make
    // * sure they are identified
    int i = 0;
    object oItem;
    for (i = INVENTORY_SLOT_HEAD; i<=INVENTORY_SLOT_CARMOUR; i++)
    {
        oItem = GetItemInSlot(i, OBJECT_SELF);
        if (GetIsObjectValid(oItem) == TRUE)
            SetIdentified( oItem, TRUE);
    }
    // Do same for inventory (Added)
    object oStuff = GetFirstItemInInventory(OBJECT_SELF);
    while(GetIsObjectValid(oStuff))
    {
        oStuff = GetItemInSlot(i, OBJECT_SELF);
        if (GetIsObjectValid(oStuff) == TRUE)
            SetIdentified( oStuff, TRUE);
            oStuff = GetNextItemInInventory(OBJECT_SELF);
    }

/* ADD TREASURE SCRIPTS HERE
    GetTreasure("Gold10");
    GetTreasure("Misc");
    GetTreasure("Misc");
    GetMagic("Potions2");
*/
    object oChair = GetNearestObjectByTag ("CHAIR", OBJECT_SELF);
    if (GetDistanceToObject(oChair)<10.0)   ActionSit(oChair);

    SetIsDestroyable(FALSE, TRUE, FALSE); //added to allow POTSC death script functionality
}


