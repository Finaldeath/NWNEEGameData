const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"
void main()
{
object oG1 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb1");
object oG2 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb2");
object oG3 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb3");
object oG4 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb4");
object oG5 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb5");
object oG6 = GetItemPossessedBy(OBJECT_SELF, "ac_zombiegarb6");
object oA = GetItemPossessedBy(OBJECT_SELF,"ac_zombieamulet");
DelayCommand(0.5, ActionEquipItem(oA, INVENTORY_SLOT_NECK));
switch (d6())
{
case 1:
ActionEquipItem(oG1, INVENTORY_SLOT_CHEST);
break;
case 2:
ActionEquipItem(oG2, INVENTORY_SLOT_CHEST);
break;
case 3:
ActionEquipItem(oG3, INVENTORY_SLOT_CHEST);
break;
case 4:
ActionEquipItem(oG4, INVENTORY_SLOT_CHEST);
break;
case 5:
ActionEquipItem(oG5, INVENTORY_SLOT_CHEST);
break;
case 6:
ActionEquipItem(oG6, INVENTORY_SLOT_CHEST);
break;
}

// Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
