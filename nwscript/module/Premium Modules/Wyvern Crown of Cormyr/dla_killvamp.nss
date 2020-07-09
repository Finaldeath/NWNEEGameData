void main()
{
    object oVamp = GetEnteringObject();
    object oCoffin = GetNearestObjectByTag(GetTag(OBJECT_SELF)+"SHAD");
    object oShade;
    string sTag = GetTag(oVamp);
    if(sTag=="Vampire1" || sTag=="Vampire2" || sTag=="Vampire3" || sTag=="Vampire4")
    {
        oShade = CreateObject(OBJECT_TYPE_CREATURE, "VAMPIRE_SHADE",GetLocation(oVamp),FALSE,sTag+"_SHAD");
        SetLocalString(oShade, "NW_L_MYCREATOR", sTag);
        DestroyObject(oVamp);
    }
}
