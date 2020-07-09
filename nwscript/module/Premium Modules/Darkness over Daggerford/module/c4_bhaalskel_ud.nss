// user defined event for bhaal's undead skeletons
// .. change appearance and levelup based on type
// .. equip random items

#include "nw_i0_generic"
#include "hf_in_spawn"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// change our appearance based on our assigned creature type
void EstablishAppearance(int nType)
{
    int nAppearance;
    if      (nType <= 1) nAppearance = APPEARANCE_TYPE_SKELETON_COMMON;
    else if (nType == 2) nAppearance = APPEARANCE_TYPE_SKELETON_WARRIOR_1;
    else if (nType == 3) nAppearance = APPEARANCE_TYPE_SKELETON_PRIEST;
    SetCreatureAppearanceType(OBJECT_SELF, nAppearance);
}

// equip a random weapon (and maybe a shield) for some variety
void EstablishInventory(int nType)
{
    // do nothing if we are already holding a weapon
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oWeapon))
    {
        return;
    }

    if(d4() == 1)
    {
        oWeapon = CreateItemOnObject("nw_wbwxl001");
        object oBolts = CreateItemOnObject("nw_wambo001", OBJECT_SELF, 99);

        ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND);
        ActionEquipItem(oBolts, INVENTORY_SLOT_BOLTS);
        SetDroppableFlag(oWeapon, FALSE);
        SetDroppableFlag(oBolts, FALSE);
        return;
    }

    // equip a one-handed weapon
    string s;
    int n = d4();
    if      (n == 1) s = "nw_wblml001"; // mace
    else if (n == 2) s = "nw_wblfl001"; // flail
    else if (n == 3) s = "nw_wswsc001"; // scimitar
    else if (n == 4) s = "nw_wspku001"; // kikuri
    oWeapon = CreateItemOnObject(s);
    ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND);
    SetDroppableFlag(oWeapon, FALSE);

    // maybe equip a shield
    s = "";
    n = d3();
    if      (n == 1) s = "nw_ashsw001"; // small shield
    else if (n == 2) s = "nw_ashlw001"; // large shield
    if (s != "")
    {
        object oShield = CreateItemOnObject(s);
        ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
        SetDroppableFlag(oShield, FALSE);
    }
}

// levelup based on type
void EstablishDifficulty(int nType)
{
    int nDC;
    if      (nType <= 0) nDC = 10;
    else if (nType == 1) nDC = 20;
    else if (nType >= 2) nDC = 30;
    int nLevels = SpawnGetPartyCR(GetFirstPC(), nDC);
    SpawnLevelupCreature(OBJECT_SELF, nLevels);
}

// initialize our appearance, inventory and levels
void Initialize()
{
    int nType = GetLocalInt(OBJECT_SELF, "TYPE");
    EstablishAppearance(nType);
    EstablishInventory(nType);
    EstablishDifficulty(nType);
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        Initialize();
    }
}

/*
VARIABLES:

OBJECT:
 - TYPE = {1|2|3}
*/
