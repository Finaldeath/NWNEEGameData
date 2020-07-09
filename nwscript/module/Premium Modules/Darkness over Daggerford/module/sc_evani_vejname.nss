int StartingConditional()
{
    if(GetLocalInt(GetModule(),"vejoni_named")==1
      &&GetLocalInt(GetModule(),"vejoni_plot")>9)
    return TRUE;
    return FALSE;
}
