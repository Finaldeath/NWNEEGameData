// the player has stolen the key from the slaver

void main()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(OBJECT_SELF, "ks_it_lizkey");
    DestroyObject(oKey);
    CreateItemOnObject("ks_it_lizkey", oPC);
}
