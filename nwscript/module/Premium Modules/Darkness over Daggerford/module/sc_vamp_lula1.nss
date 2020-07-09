int StartingConditional()
{
    if(GetLocalInt(GetModule(),"lula_met")==1&&
    GetLocalInt(GetModule(),"vamp_wedding")>0)
    return TRUE;
    return FALSE;
    //vampire has revealed his intentions for Xanda
    //&& PC has met Lula Redcap
}
