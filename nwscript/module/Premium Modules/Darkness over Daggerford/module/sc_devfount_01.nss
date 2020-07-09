// does the player have elwinster's oil?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oOil = GetItemPossessedBy(oPC, "ks_it_devoil");
    return (GetIsObjectValid(oOil));
}
