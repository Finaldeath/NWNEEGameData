int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"nDartJustLost")==1)
    {
        DeleteLocalInt(oPC,"nDartJustLost");
        return TRUE;
    }
    return FALSE;
}
