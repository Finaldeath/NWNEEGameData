int StartingConditional()
{
    int iResult;

    iResult = ((GetLocalInt(GetModule(), "nWH_OgresDispatched") == 1) && (d4() == 1));  // ogres dead - RANDOM LINE!
    return iResult;
}
