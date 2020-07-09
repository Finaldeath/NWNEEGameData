int StartingConditional()
{
    if(GetLocalInt(GetModule(),"rab_plot")>=40&&GetLocalInt(GetModule(),"rab_plot")<=45)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
