void main()
{
       SetPlotFlag(GetNearestObjectByTag("pm_secondvoice",GetFirstPC()),FALSE);
       SetPlotFlag(GetNearestObjectByTag("pm_firstvoice",GetFirstPC()),FALSE);
       DestroyObject(GetNearestObjectByTag("pm_secondvoice",GetFirstPC()));
       DestroyObject(GetNearestObjectByTag("pm_firstvoice",GetFirstPC()));
}
