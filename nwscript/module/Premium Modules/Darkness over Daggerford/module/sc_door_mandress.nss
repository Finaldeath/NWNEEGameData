//returns true if PC is male and wearing a woman's dress
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDress = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetGender(oPC)==GENDER_MALE && GetTag(oDress)=="pm_custom_dress")
    return TRUE;
    return FALSE;
}
