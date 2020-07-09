int StartingConditional()
{
    int iResult;

    iResult =(GetLocalInt(GetPCSpeaker(), "nWH_SpokeGnolls") == 2); // spoke to shaman
    return iResult;
}
