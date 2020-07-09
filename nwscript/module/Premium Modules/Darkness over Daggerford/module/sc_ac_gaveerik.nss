// did the player give the chest to erik?

int StartingConditional()
{
    int n = GetLocalInt(GetModule(), "nGaveChestToErik");
    return(n!=0);
}
