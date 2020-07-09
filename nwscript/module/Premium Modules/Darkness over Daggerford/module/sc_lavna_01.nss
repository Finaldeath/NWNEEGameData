// has the player found the one-eyed worg's head?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHead = GetItemPossessedBy(oPC, "ks_it_worg_head");
    return(GetIsObjectValid(oHead));
}
