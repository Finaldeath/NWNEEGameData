int StartingConditional()
{
    //Metastakixx quest activated, shadows defeated
    if(GetLocalInt(GetModule(),"meta_quest")==2)
    return TRUE;
    return FALSE;
}

