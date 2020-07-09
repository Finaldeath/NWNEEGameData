int StartingConditional()
{
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    return GetLocalInt(OBJECT_SELF, "b" + sVariable1 + "Hide");
}
