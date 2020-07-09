int StartingConditional()
{
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    return GetLocalInt(OBJECT_SELF, "b" + sVariable1 + sVariable2 + sVariable3 + "TrueNeutral");
}
