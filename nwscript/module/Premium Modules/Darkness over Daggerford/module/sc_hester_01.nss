// does the player have the pen and paper for hester?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPaper = GetItemPossessedBy(oPC, "ks_it_paper");
    return(GetIsObjectValid(oPaper));
}
