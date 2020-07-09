// ==========================================================================
// this include file contains functions related to Xatuum's Blood Bag
// ==========================================================================

const int    nMaxNumBottles  = 10;
const string sTagBottleEmpty = "ks_it_bloodjar0";
const string sTagBottleFull  = "ks_it_bloodjar1";
const string sTagBloodBag    = "ks_it_bloodbag";

// return the player's blood bag, or OBJECT_INVALID if he doesn't have one
object GetBloodBag(object oPC)
{
    object oBag = GetItemPossessedBy(oPC, sTagBloodBag);
    return(oBag);
}

// has the player collected enough bottles of blood to satisfy Xatumm?
int HasEnoughBlood(object oPC)
{
    int nCount = 0;
    object oBag = GetBloodBag(oPC);
    if (GetIsObjectValid(oBag))
    {
        object oBottle = GetFirstItemInInventory(oBag);
        while (GetIsObjectValid(oBottle))
        {
            if (GetTag(oBottle) == sTagBottleFull)
            {
                nCount++;
            }
            oBottle = GetNextItemInInventory(oBag);
        }
    }
    return(nCount >= nMaxNumBottles);
}

// add a bottle of blood to the player's bag
void AddBloodBottle(object oPC)
{
    object oBag = GetBloodBag(oPC);
    if (GetIsObjectValid(oBag))
    {
        object oEmptyBottle = GetFirstItemInInventory(oBag);
        while (GetIsObjectValid(oEmptyBottle))
        {
            if (GetTag(oEmptyBottle) == sTagBottleEmpty)
            {
                break;
            }
            oEmptyBottle = GetNextItemInInventory(oBag);
        }
        if (GetIsObjectValid(oEmptyBottle))
        {
            DestroyObject(oEmptyBottle);
            CreateItemOnObject(sTagBottleFull, oBag, 1);
            FloatingTextStringOnCreature("... Bhaal's Blood Bottle Filled ...", oPC);
            AssignCommand(oPC, PlaySound("it_potion"));
        }
    }
}

// destroy all the bottles in the blood bag
void EmptyBloodBag(object oPC)
{
    object oBag = GetBloodBag(oPC);
    if (GetIsObjectValid(oBag))
    {
        object oBottle = GetFirstItemInInventory(oBag);
        while (GetIsObjectValid(oBottle))
        {
            string sTag = GetTag(oBottle);
            if (sTag == sTagBottleFull || sTag == sTagBottleEmpty)
            {
                DestroyObject(oBottle);
            }
            oBottle = GetNextItemInInventory(oBag);
        }
    }
}

// create a fresh blood bag in the player's inventory
// .. needs to be full of empty bottles to collect blood
void CreateBloodBag(object oPC)
{
    object oBag = CreateItemOnObject(sTagBloodBag, oPC, 1);
    if (GetIsObjectValid(oBag))
    {
        int i;
        for (i=1; i<=nMaxNumBottles; i++)
        {
            CreateItemOnObject(sTagBottleEmpty, oBag, 1);
        }
    }
}

// call this function in creature death event
// .. this will add a bottle of blood to the player's inventory
void CheckForBlood(object oKiller, object oNPC)
{
    if (GetIsPC(oKiller))
    {
        int nRace = GetRacialType(oNPC);
        if (nRace == RACIAL_TYPE_HUMAN    ||
            nRace == RACIAL_TYPE_ELF      ||
            nRace == RACIAL_TYPE_DWARF    ||
            nRace == RACIAL_TYPE_HALFLING ||
            nRace == RACIAL_TYPE_GNOME)
        {
            AddBloodBottle(oKiller);
        }
    }
}
