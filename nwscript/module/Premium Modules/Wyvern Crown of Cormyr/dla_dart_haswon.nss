int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"nDartJustWon")==1)
    {
        DeleteLocalInt(oPC,"nDartJustWon");
        return TRUE;
    }
    return FALSE;
}
