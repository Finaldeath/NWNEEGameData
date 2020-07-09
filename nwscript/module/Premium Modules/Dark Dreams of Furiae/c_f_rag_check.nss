int StartingConditional()
{
    int bChatted = GetLocalInt(GetModule(), "ddf_rag_check");

    // if the players *have* chatted with the rag peddler, and have an outcome
    // we should not show this dialog...
    if(bChatted == 0) return TRUE;

    return FALSE;
}
