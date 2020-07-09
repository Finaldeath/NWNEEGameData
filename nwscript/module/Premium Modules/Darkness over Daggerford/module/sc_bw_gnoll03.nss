int StartingConditional()
{
    int iResult;

    iResult =(GetLocalInt(GetPCSpeaker(), "nWH_SpokeGnolls") == 1); // told to see shaman
    return iResult;
}
