void main()
{
    object oEnter = GetEnteringObject();

    if (GetIsPC(oEnter))
    {
        ActionStartConversation(oEnter, "epil_001");
    }
}
