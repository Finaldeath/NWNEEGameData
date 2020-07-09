//has the player found the crumpled note in ar0600?
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNote = GetItemPossessedBy(oPC,"ks_bandnote_1");
    return (GetIsObjectValid(oNote));
}
