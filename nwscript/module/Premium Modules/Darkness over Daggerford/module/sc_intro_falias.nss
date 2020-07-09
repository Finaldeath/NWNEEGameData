//trigger Falias' conversation outside the caravans in the
//intro area
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"falias_in_the_bush")==1)
    return TRUE;
    return FALSE;
}
