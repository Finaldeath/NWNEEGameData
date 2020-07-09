const string GAMEFLAG = "GAMEFLAG";
const string DIALOG = "DIALOG";

void main()
{
    string sflag = GetLocalString(OBJECT_SELF, GAMEFLAG);
    int iFlag = GetLocalInt(GetModule(), sflag);

    if (iFlag == FALSE)
    {
        string sDialog = GetLocalString(OBJECT_SELF, DIALOG);
        ActionStartConversation(GetFirstPC(), sDialog);
        ActionCloseDoor(OBJECT_SELF);
    }
}
