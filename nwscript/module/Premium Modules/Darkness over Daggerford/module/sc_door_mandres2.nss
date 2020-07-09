//returns true if PC is male and wearing a woman's dress
//and the pc has already talked with the doorman while crossdressed.
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDress = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetGender(oPC)==GENDER_MALE && GetTag(oDress)=="pm_custom_dress"
    && GetLocalInt(GetModule(), "doorman")==2)
    return TRUE;
    return FALSE;
}
