#include "inc_id1_debug"
#include "inc_id1_treasure"
#include "inc_id1_store"

void main()
{
    DebugMessage("");
    DebugMessage("====STORE GENERATION MICROPROCESS START====");
    DebugMessage("");

    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    int bTimmy = GetLocalInt(OBJECT_SELF, "bTimmy");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    object oDungeon = GetCurrentDungeon();

    object oStore = GenerateStore(nLevel, oParent);
    DebugMessage("Generating a level " + IntToString(nLevel) + " store.");

    if (bTimmy == TRUE)
    {
        SetStoreGold(oStore, -1);
        SetStoreIdentifyCost(oStore, 75);
        SetStoreMaxBuyPrice(oStore, -1);
    } else
    {
        // set store details
        if (GetModuleFlag(ID1_FLAG_CAMP_NODE_STORE_GOLD) == ID1_CAMP_NODE_STORE_GOLD_LIMITED)
        {
            int nStoreGold = nLevel * nLevel * 1000;
            SetStoreGold(oStore, nStoreGold);
            DebugMessage("  Store has gold limit of " + IntToString(nStoreGold));
        } else
        {
            SetStoreGold(oStore, -1);
            DebugMessage("  Store has unlimited gold");
        }
        SetStoreMaxBuyPrice(oStore, -1);
        SetStoreIdentifyCost(oStore, 100);
    }
    SetLocalObject(oParent, "oStore", oStore);

    object oMicroCPU;
    int nCount;

    // create 10 level + 1 items
    nCount = 1;
    while (nCount <= 10)
    {
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU99");
        SetLocalInt(oMicroCPU, "nLevel", nLevel + 1);
        SetLocalObject(oMicroCPU, "oStore", oStore);
        DelayCommand(0.01, ExecuteScript("exe_id1_micstrit", oMicroCPU));

        nCount++;
    }

    // create 5 level + 2 items
    nCount = 1;
    while (nCount <= 5)
    {
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU100");
        SetLocalInt(oMicroCPU, "nLevel", nLevel + 2);
        SetLocalObject(oMicroCPU, "oStore", oStore);
        DelayCommand(0.01, ExecuteScript("exe_id1_micstrit", oMicroCPU));

        nCount++;
    }

/*
    object oMicroCPU;
    int nMicroNum;
    int nCount = 1;
    while (nCount <= 5)
    {
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU");

        SetLocalInt(oMicroCPU, "nLevel", nLevel);
        SetLocalString(oMicroCPU, "sContainer", "");
        SetLocalFloat(oMicroCPU, "fValueMultiplier", 5.0);
        SetLocalInt(oMicroCPU, "bGoldPresent", FALSE);
        SetLocalInt(oMicroCPU, "bGemPresent", TRUE);
        SetLocalInt(oMicroCPU, "bItemPresent", TRUE);
        SetLocalInt(oMicroCPU, "bCreateTreasure", TRUE);
        SetLocalObject(oMicroCPU, "oContainer", oStore);
        SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
        SetLocalInt(oMicroCPU, "bHold", FALSE);

        DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));

        nCount++;
    }*/

    DebugMessage("");
    DebugMessage("====STORE GENERATION MICROPROCESS END====");
    DebugMessage("");

    // destroy itself
    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}
