void main()
{
    if ((IsInConversation(OBJECT_SELF) == FALSE) && (GetLocalInt(OBJECT_SELF, "bCataloging") == FALSE))
    {
        SetLocked(OBJECT_SELF, FALSE);
    } else
    {
    }
}
