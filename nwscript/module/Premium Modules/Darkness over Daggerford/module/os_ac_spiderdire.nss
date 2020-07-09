const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"
void main()
{
object oB = GetItemPossessedBy(OBJECT_SELF, "ac_direbite");
object oA = GetItemPossessedBy(OBJECT_SELF,"ac_creatureamulet");
ActionEquipItem(oA, INVENTORY_SLOT_NECK);
ActionEquipItem(oB, INVENTORY_SLOT_CWEAPON_L);
ActionEquipItem(oB, INVENTORY_SLOT_CWEAPON_R);

// Execute default OnSpawn script.
    ExecuteScript("nw_c2_dropin9", OBJECT_SELF);
}
