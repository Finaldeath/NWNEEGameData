// has player found the hag's effigy yet?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDoll = GetItemPossessedBy(oPC, "ks_hagdoll");
    return (GetIsObjectValid(oDoll));
}
