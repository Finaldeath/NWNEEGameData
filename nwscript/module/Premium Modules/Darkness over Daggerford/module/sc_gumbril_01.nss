int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oUmgatlik = GetNearestObjectByTag("ks_umgatlik", oPC);
    if(GetIsObjectValid(oUmgatlik) && !GetIsDead(oUmgatlik))
    {
        return(TRUE);
    }
    return(FALSE);
}
