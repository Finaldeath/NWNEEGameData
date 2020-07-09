// is amara still staying at the chateau elite?

int StartingConditional()
{
    object oMod = GetModule();
    int n = GetLocalInt(oMod, "nAmaraHasLeftElite");
    return (n == 0);
}
