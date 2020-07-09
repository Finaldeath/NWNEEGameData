// returns true when the player solved the puzzle

int StartingConditional()
{
    int nFailed = GetLocalInt(OBJECT_SELF, "nFail");
    return (nFailed == 0);
}
