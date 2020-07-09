//::///////////////////////////////////////////////
//:: dla_i0_switches
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   All module specific switchs that makes the horse system flexible should be here
   After any of them are changed, you should Build Module
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: June 10, 2005
//:://////////////////////////////////////////////


    ///////////////SWITCHES////////////////////

    //Sets the amount, in percentage to increase movement speed while mounted.
    //Range 0 through 99
    const int DLA_HORSE_SPEED_INCREASE = 99;

    //jousting base save DC for glancing blows
    const int DLA_GLANCE_SAVE      = 12;

    ///////////// END OF SWITCHES /////////////

    ////// PRICE DECLARATIONS ////////////////

    const int DLA_PRICE_LIGHT_HORSE_1 = 30; //bareback
    const int DLA_PRICE_LIGHT_HORSE_2 = 32; //saddled
    const int DLA_PRICE_LIGHT_HORSE_3 = 35; //saddled/gear

    const int DLA_PRICE_HEAVY_HORSE_1 = 50; //bareback
    const int DLA_PRICE_HEAVY_HORSE_2 = 52; //saddled
    const int DLA_PRICE_HEAVY_HORSE_3 = 55; //saddled/gear

    const int DLA_PRICE_LIGHT_WARHORSE_1 = 90; //bareback
    const int DLA_PRICE_LIGHT_WARHORSE_2 = 92; //saddled
    const int DLA_PRICE_LIGHT_WARHORSE_3 = 95; //saddled/gear
    const int DLA_PRICE_LIGHT_WARHORSE_4 = 120; //barded
    const int DLA_PRICE_LIGHT_WARHORSE_5 = 123; //barded/gear

    const int DLA_PRICE_HEAVY_WARHORSE_1 = 140; //bareback
    const int DLA_PRICE_HEAVY_WARHORSE_2 = 142; //saddled
    const int DLA_PRICE_HEAVY_WARHORSE_3 = 145; //saddled/gear
    const int DLA_PRICE_HEAVY_WARHORSE_4 = 170; //barded
    const int DLA_PRICE_HEAVY_WARHORSE_5 = 173; //barded/gear

    ///////// END OF PRICE DECLARATIONS/////////

    const float DLA_MOUNT_MAXIMUM_DISTANCE = 4.0;

    //Valid choices are: 2, 4 and 6
    const int DLA_MOUNT_FOLLOW_DISTANCE = 4;

    const int DLA_MAX_HORSEHENCH_NUMBER = 3;

    //Syrsnein, 3 April 2006:  Added this for when horses are mounted
    //  and dismounted.  This pertains to max number of NPC henchmen the
    //  player is allowed
    //Gale 11 May 2006: works again now
    const int DLA_MAX_NPC_HENCHMEN = 2;

    const int DLA_CHANGE_HORSE_NAME_WHEN_OWNED = TRUE;

    const int DLA_RESET_NAME_WHEN_ON_HITCHING = FALSE;

    //This works on function DLA_CreateDismountedHorse,
    //DLA_RemovePartyHorsesAndLeaveOnPlace and DLA_Dismount when not adding the
    //horse as henchman.
    const int DLA_RESET_NAME_WHEN_REMOVING_ALL_PARTY_HORSES = FALSE;

    //if set to FALSE, players will be able to untie horses from
    //someone else from a hitching post, including NPCs.
    const int DLA_ONLY_OWNER_CAN_UNTIE_HORSE = TRUE;

    //if set to TRUE, players can untie horses owned by NPCs on his party from
    //hitching post. The horse is still owned by the NPC.
    //NOTE: THIS OVERRIDES DLA_ONLY_OWNER_CAN_UNTIE_HORSE
    const int DLA_PLAYER_CAN_UNTIE_NPC_HORSE = TRUE;

    //if set to TRUE, the player can mount any horse owned by
    //one of his henchman. But the owner will remain as the henchman.
    const int DLA_PLAYER_CAN_MOUNT_HENCHMANS_HORSE = TRUE;

    ////////////////////////////////////////////

//void main(){}


