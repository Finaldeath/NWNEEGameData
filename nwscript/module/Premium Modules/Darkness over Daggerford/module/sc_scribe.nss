int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetModule(),"pm_klevtor_nomap") == 1);
    return iResult;
}

