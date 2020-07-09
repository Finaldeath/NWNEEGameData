// has player found the knife for the hag

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKnife = GetItemPossessedBy(oPC, "ks_lizknife");
    return (GetIsObjectValid(oKnife));
}
