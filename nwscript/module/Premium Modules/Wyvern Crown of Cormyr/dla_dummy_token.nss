void main()
{
    object oDummy = GetObjectByTag("dla_strengthdummy");
    string sChamp = GetLocalString(oDummy,"sDummyChamp");
    SetCustomToken(1032, sChamp);
}
