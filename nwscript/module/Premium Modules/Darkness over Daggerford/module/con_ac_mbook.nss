// maerovyna takes loru's journal from the player

void main()
{
    object oPC = GetPCSpeaker();
    object oBook = GetItemPossessedBy(oPC, "ac_lorujournal");
    if (GetIsObjectValid(oBook))
    {
        DestroyObject(oBook);
    }
}
