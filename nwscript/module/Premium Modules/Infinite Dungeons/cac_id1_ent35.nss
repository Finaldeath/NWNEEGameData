void main()
{
    string sFileName = GetLocalString(OBJECT_SELF, "sFileName");
    string sString = "Dungeon exported as " + sFileName;
    SetCustomToken(5200, sString);
}
