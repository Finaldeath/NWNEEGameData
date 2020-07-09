int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"nDartLostLastGame"))
    {
        return TRUE;
    }
    return FALSE;
}
