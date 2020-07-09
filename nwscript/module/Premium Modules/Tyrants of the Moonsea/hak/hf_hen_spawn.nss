#include "nw_i0_generic"
#include "x0_inc_henai"
#include "hf_in_henchman"

void main()
{
    //Sets up the special henchmen listening patterns
    SetAssociateListenPatterns();
    bkSetListeningPatterns();

    // Default behavior for henchmen at start
    SetAssociateState(NW_ASC_POWER_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);

    // Set starting location
    SetAssociateStartLocation();
    //SetRespawnLocation();

    // For some general behavior while we don't have a master,
    // let's do some immobile animations
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    //SetIsDestroyable(FALSE, TRUE, TRUE);

    // Scan through all equipped items and make sure they are identified
    int i = 0;
    object oItem;
    for (i = INVENTORY_SLOT_HEAD; i<=INVENTORY_SLOT_CARMOUR; i++)
    {
        oItem = GetItemInSlot(i, OBJECT_SELF);
        if (GetIsObjectValid(oItem) == TRUE)
            SetIdentified(oItem, TRUE);
    }

    // Set this to stop player from fiddling with my inventory
    // SetLocalInt(OBJECT_SELF, "X2_JUST_A_DISABLEEQUIP", 1);

    // we don't want our druid to turn into a badger
    HenchmanRemoveFeat(OBJECT_SELF, FEAT_WILD_SHAPE);
}

