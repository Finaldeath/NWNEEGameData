int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"nDummyResult")==1)
    {
        DeleteLocalInt(oPC,"nDummyResult");
        return TRUE;
    }
    return FALSE;
}
