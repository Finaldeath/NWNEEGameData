void main()
{
    // check to see if the journal is being used
    if (IsInConversation(OBJECT_SELF) == FALSE)
    {
//        SendMessageToPC(GetFirstPC(), "Journal not in conversation. Destroying.");
        DestroyObject(OBJECT_SELF);
    } else
    {
//        SendMessageToPC(GetFirstPC(), "Journal in conversation.");
    }
}
