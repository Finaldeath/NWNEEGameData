int StartingConditional()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");
    int nRecipeNum = GetLocalInt(OBJECT_SELF, "n" + sVariable1 + sVariable2 + sVariable3 + sVariable4);

    if (nRecipeNum > nOffset + 10)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
