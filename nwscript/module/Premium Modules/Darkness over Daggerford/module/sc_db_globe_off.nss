int StartingConditional()
{
    //the macine has been deactivated
    if(GetLocalInt(OBJECT_SELF,"deactivated")==1)
    return TRUE;
    return FALSE;
}
