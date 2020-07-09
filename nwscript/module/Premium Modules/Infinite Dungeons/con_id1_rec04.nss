#include "inc_id1_debug"
int StartingConditional()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    DebugMessage("Offset is " + IntToString(nOffset));
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");
    int nRecipeNum = GetLocalInt(OBJECT_SELF, "n" + sVariable1 + sVariable2 + sVariable3 + sVariable4);
    DebugMessage("n" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + " is " + IntToString(nRecipeNum));

    if (nRecipeNum >= nOffset + 4)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
