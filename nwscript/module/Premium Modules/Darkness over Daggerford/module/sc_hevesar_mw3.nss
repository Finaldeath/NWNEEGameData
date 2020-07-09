int StartingConditional()
{
    //wilsey quest completed, pc may now engage hevesar again
    if(GetLocalInt(GetModule(),"mayor_wilsey")>2)
    return TRUE;
    return FALSE;
}
