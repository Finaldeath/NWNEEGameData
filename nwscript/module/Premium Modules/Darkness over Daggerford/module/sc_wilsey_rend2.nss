int StartingConditional()
{
    //now uses a new routine
    //if(GetIsObjectValid(GetObjectByTag("db_jethromunroe")) == FALSE)
    if(GetLocalInt(GetModule(),"render")==2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
