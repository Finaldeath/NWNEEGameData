// player has found the brush but not the knife for the hag

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKnife = GetItemPossessedBy(oPC, "ks_lizknife");
    object oBrush = GetItemPossessedBy(oPC, "ks_lizbrooch");
    return (GetIsObjectValid(oBrush) && !GetIsObjectValid(oKnife));
}
