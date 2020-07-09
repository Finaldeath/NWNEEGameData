#include "inc_id1_utility"
#include "inc_id1_store"

void main()
{
    // find the average level of players in the dungeon
    int nCR = GetPartyLevel(GetFirstPC(), TRUE);

    // get timmy's current store
    object oStore = GetLocalObject(OBJECT_SELF, "oStore");
    if (oStore != OBJECT_INVALID)
    {
        DestroyObject(oStore);
    }
    oStore = GenerateStore(nCR, OBJECT_SELF);
    DebugMessage("Generating a level " + IntToString(nCR) + " store for Timmy.");

    // set the store
    SetLocalObject(OBJECT_SELF, "oStore", oStore);

    // set the store details
    SetStoreGold(oStore, -1);
    SetStoreIdentifyCost(oStore, 75);
    SetStoreMaxBuyPrice(oStore, -1);
}
