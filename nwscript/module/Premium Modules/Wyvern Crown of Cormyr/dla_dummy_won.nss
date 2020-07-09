int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"nDummyResult")==2)
    {
        DeleteLocalInt(oPC,"nDummyResult");
        return TRUE;
    }
    return FALSE;
}
