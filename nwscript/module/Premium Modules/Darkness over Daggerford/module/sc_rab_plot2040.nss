int StartingConditional()
{
    if(GetLocalInt(GetModule(),"rab_plot")>=20&&GetLocalInt(GetModule(),"rab_plot")<40)
    return TRUE;
    return FALSE;
}
