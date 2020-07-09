// does the player have the fake painting?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFake = GetItemPossessedBy(oPC, "ac_fakeportrait");
    return(GetIsObjectValid(oFake));
}
