int StartingConditional()
{
    if(GetLocalInt(GetModule(),"rab_plot")>=10&&
    GetLocalInt(GetModule(),"rab_plot")<50)
    return TRUE;
    return FALSE;
}
