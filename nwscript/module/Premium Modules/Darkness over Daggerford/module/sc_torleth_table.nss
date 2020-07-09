// set the price variable for torleth's junk

int StartingConditional()
{
    int n = GetLocalInt(OBJECT_SELF, "PRICE");
    SetCustomToken(100, IntToString(n));
    return(TRUE);
}
