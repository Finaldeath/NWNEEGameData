int StartingConditional()
{
    //is drelia waiting for the render quest to be completed?
    if(GetLocalInt(GetModule(),"db_drelia_waiting")==1)
    return TRUE;
    return FALSE;
}
