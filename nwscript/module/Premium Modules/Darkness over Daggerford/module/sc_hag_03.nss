// has the player found the brush for the hag?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBrush = GetItemPossessedBy(oPC, "ks_lizbrooch");
    return (GetIsObjectValid(oBrush));
}
