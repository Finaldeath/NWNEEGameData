//the player traveled to confront Teygan alone
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"harpers_teygan")==2)
    return TRUE;
    return FALSE;
}
