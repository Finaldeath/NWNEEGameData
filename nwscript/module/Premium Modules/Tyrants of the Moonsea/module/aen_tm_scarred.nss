//Area OnEnter for Scarred Lands
//Spawn Elf if appropriate

#include "hf_in_friend"
#include "hf_in_plot"

// Plot variable for setting henchmen dialog responses
const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

// These will be destroyed
const string DROW_ITEM_TAGS = "X2_IT_DROWCL001|X2_MDROWAR026|X2_MDROWAR025|X2_MDROWAR011|X2_MDROWAR004|X2_ARDROWHE001|X2_MDROWAR019|X2_MDROWAR018|(X2_MDROWAR032|X2_MDROWAR033|X2_ADROWSHL003|DrowLongsword4|DrowLongsword5|DrowMace5";
const string DROW_ITEM_MESSAGE = "The sunlight has destroyed your drow gear! It has crumbled to dust!";

void DestroyDrowItems(object oTarget)
{
    object oItem = OBJECT_INVALID;
    string sItemTag = "";
    int nNumDestroyedItems = 0;

    // Check main inventory
    oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem))
    {
        if (FindSubString(DROW_ITEM_TAGS, GetTag(oItem)) >= 0)
        {
            DestroyObject(oItem);
            nNumDestroyedItems++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

    // Check equipped items
    int nSlot = 0;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; ++nSlot)
    {
        oItem = GetItemInSlot(nSlot, oTarget);

        if (FindSubString(DROW_ITEM_TAGS, GetTag(oItem)) >= 0)
        {
            DestroyObject(oItem);
            nNumDestroyedItems++;
        }
    }

    // Send Message
    if (nNumDestroyedItems > 0)
        SendMessageToPC(oTarget, DROW_ITEM_MESSAGE);
}


void main()
{
    object oDirector = GetObjectByTag("KTDirector");
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        if (!GetLocalInt(OBJECT_SELF, "nDone"))
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);

            DestroyDrowItems(oPC);
        }

        // Set Henchman dialog status (to entered Scarred Lands)
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 11)
            PlotLevelSet(PLOT_HENCH_DIALOG, 11);

        //Spawn Elf if appropriate
        if(PlotLevelGet("Elf") == 13 &&
           GetLocalInt(OBJECT_SELF, "nElfSpawned") == 0)
        {
            object oElf =
                CreateObject(OBJECT_TYPE_CREATURE, "elf",
                             GetLocation(GetWaypointByTag("WP_TH_SCL_ELF")));

            SetLocalObject(oDirector, "oElf", oElf);
            SetLocalString(oElf, "sHome", "WP_TH_SCL_ELF");
            SetLocalInt(OBJECT_SELF, "nElfSpawned", 1);
            FriendSetMaster(oPC, oElf);
        }
    }

    ExecuteScript("aen_tm_transform", OBJECT_SELF);

    ExecuteScript("aen_tm_spawn", OBJECT_SELF);
}
