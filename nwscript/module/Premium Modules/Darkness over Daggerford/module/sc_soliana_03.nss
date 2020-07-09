// does the player have feldran's letter?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oLetter = GetItemPossessedBy(oPC, "ks_feldran_lette");
    return(GetIsObjectValid(oLetter));
}
