int StartingConditional()
{
    if(GetLocalInt(GetModule(),"rab_plot")>=30&&GetLocalInt(GetModule(),"rab_plot")<=50)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
