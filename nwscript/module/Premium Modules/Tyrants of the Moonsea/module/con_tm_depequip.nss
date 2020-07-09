//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_depequip
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Appears if player has deputy chainmail AND
//       helm equipped.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC))!="DeputyChainmail") return FALSE;

if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC))!="DeputyHelm") return FALSE;

return TRUE;
}

