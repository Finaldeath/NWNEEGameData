int StartingConditional()
{
    object oModule = GetModule();

    int iResult = GetLocalInt(oModule, "ddf_corano_noble_chat");

    if(iResult == FALSE)
    {
        SetLocalInt(oModule, "ddf_corano_noble_chat", TRUE);
        return TRUE;
    }

    return FALSE;
}
