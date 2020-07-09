int StartingConditional()
{
    int bChatted = GetLocalInt(GetModule(), "ddf_rag_check");

    if(bChatted == 0) return FALSE;

    return TRUE;
}
