void main()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");
    nOffset += 10;
    SetLocalInt(OBJECT_SELF, "nQuestLogOffset", nOffset);
}
