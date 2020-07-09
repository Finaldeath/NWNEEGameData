// millie takes her "cheese gold" and receipt from the player

void main()
{
    object oPC = GetPCSpeaker();
    object oGold = GetItemPossessedBy(oPC, "ac_cheesegold");
    if (GetIsObjectValid(oGold))
    {
        DestroyObject(oGold);
    }
    object oBill = GetItemPossessedBy(oPC, "ac_cheesercpt");
    if (GetIsObjectValid(oBill))
    {
        DestroyObject(oBill);
    }
}
