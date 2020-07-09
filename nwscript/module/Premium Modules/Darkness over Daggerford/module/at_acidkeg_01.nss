// the player has filled an empty bottle with acid, creating an acid flask

void main()
{
    object oPC = GetPCSpeaker();
    object oBottle = GetItemPossessedBy(oPC, "NW_IT_THNMISC001");
    DestroyObject(oBottle);
    CreateItemOnObject("x1_wmgrenade001", oPC, 1);
}
