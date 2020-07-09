int StartingConditional()
{
    //has player spoken with Korin in Illefarn?
    if(GetLocalInt(GetModule(),"korin_met")==1&&
    !GetLocalInt(GetModule(), "derval_korin")==1)
    //has not mentioned this to Derval yet
    return TRUE;
    return FALSE;
}
