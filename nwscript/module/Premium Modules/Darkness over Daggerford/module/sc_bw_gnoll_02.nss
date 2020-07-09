int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetModule(), "nWH_OgresDispatched") == 1);  // ogres dead
    return iResult;
}
