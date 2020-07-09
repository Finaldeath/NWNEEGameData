void main()
{
    location lLoc = GetLocation(OBJECT_SELF);
    string sName = GetName(OBJECT_SELF);
    string sChamp = GetLocalString(OBJECT_SELF,"sDummyChamp");
    int nRecord = GetLocalInt(OBJECT_SELF,"nDummyDamageRecord");
    object oReplace = CreateObject(OBJECT_TYPE_PLACEABLE,"dla_strengthdumm",lLoc);
    SetLocalInt(oReplace,"nDummyDamageRecord",nRecord);
    SetLocalString(oReplace,"sDummyChamp",sChamp);
    SetName(oReplace,sName);
}
