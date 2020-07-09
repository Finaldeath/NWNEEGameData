//the harpers are with the PC in Teygan's Cave
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"harpers_teygan")==1)
    return TRUE;
    return FALSE;
}
