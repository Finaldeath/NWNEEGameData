int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"NW_G_M3Q2PLOTULTARGSEEDSPLANTED") ==0;
    return iResult;
}