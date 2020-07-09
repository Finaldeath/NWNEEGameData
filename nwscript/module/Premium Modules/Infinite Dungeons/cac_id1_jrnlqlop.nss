void main()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");
    nOffset -= 10;
    if (nOffset < 0)
    {
        nOffset = 0;
    }
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", nOffset);
}
