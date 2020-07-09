int StartingConditional()
{
    //Metastakixx quest activated, but not complete
    if(GetLocalInt(GetModule(),"meta_quest")==1)
    return TRUE;
    return FALSE;
}
