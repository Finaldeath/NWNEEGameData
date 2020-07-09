
int PlotLevelGet(string sChar)
{
    string sVar = "n" + sChar + "_PL";
    int nLevel = GetLocalInt(GetModule(), sVar);
    return(nLevel);
}

void PlotLevelSet(string sChar, int nLevel)
{
    string sVar = "n" + sChar + "_PL";
    SetLocalInt(GetModule(), sVar, nLevel);
}

int PlotLevelCheckEquals(string sChar, int nLevel)
{
    return(PlotLevelGet(sChar) == nLevel);
}

