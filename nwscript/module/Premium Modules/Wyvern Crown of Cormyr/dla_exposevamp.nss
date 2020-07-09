void main()
{
    object oVamp = GetEnteringObject();
    object oShaft = GetNearestObjectByTag("pf_lightshaft");
    object oCoffin = GetNearestObjectByTag(GetTag(OBJECT_SELF)+"SHAD");
    object oShade;
    string sTag = GetTag(oVamp);
    if(sTag=="Vampire1" || sTag=="Vampire2" || sTag=="Vampire3" || sTag=="Vampire4")
    {
        if(GetIsNight()||GetIsDusk()||!GetIsObjectValid(oShaft))
        {
            return;
        }
        if(GetIsObjectValid(oShaft))
        {
            oShade = CreateObject(OBJECT_TYPE_CREATURE, "VAMPIRE_SHADE",GetLocation(oVamp),FALSE,sTag+"_SHAD");
            SetLocalString(oShade, "NW_L_MYCREATOR", sTag);
            DestroyObject(oVamp);
        }
    }
}
