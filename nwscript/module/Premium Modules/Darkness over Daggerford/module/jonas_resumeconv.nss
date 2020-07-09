void main()
{
    if(GetLocalInt(OBJECT_SELF, "iDruggedPC") == 1)
    {
        ActionStartConversation(GetPCSpeaker());
    }
}
