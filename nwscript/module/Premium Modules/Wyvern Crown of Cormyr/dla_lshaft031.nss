// dla_lshaft031.nss
// May 14 2006
// Robert Faber
// Recompute lighting OnUsed for escape hatch

// Sets up or destroys the shaft of light placeable and recalcs area lighting
void Relight(object oPC, int nMain1, int nMain2, string sSound, int nTime);

void main()
{
    object oPC = GetLastUsedBy();
    object oWay = GetWaypointByTag("WP_lightshaft_031");
    object oArea = GetArea(oPC);
    location lLoc = GetLocation(oWay);
    vector vTile = Vector(2.0f,11.0f);
    location lTile = Location(oArea, vTile, 0.0f);
    object oShaft = GetNearestObjectByTag("pf_lightshaft");

    if(GetLocalInt(oPC,"nShaftLighting"))
    {
        return;
    }

    int nMain1,nMain2,nTime;
    string sSound;
    int nDay = GetIsDay() || GetIsDawn();
    PlaySound("as_cv_ropecreak3");
    if(GetIsObjectValid(oShaft))
    {
        DestroyObject(oShaft);
        nMain1 = TILE_MAIN_LIGHT_COLOR_BLACK;
        nMain2 = TILE_MAIN_LIGHT_COLOR_DARK_PURPLE;
        nTime = 0;
        sSound = "as_dr_metlmedcl1";
    }
    else if(nDay)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"pf_lightday",lLoc);
        nMain1 = TILE_MAIN_LIGHT_COLOR_DARK_YELLOW;
        nMain2 = TILE_MAIN_LIGHT_COLOR_DARK_YELLOW;
        nTime = 1;
        sSound = "as_dr_metlmedop1";
    }
    else
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"pf_lightnight",lLoc);
        nMain1 = TILE_MAIN_LIGHT_COLOR_DARK_BLUE;
        nMain2 = TILE_MAIN_LIGHT_COLOR_DARK_BLUE;
        nTime = 2;
        sSound = "as_dr_metlmedop1";
    }
    DelayCommand(3.0, Relight(oPC,nMain1,nMain2,sSound,nTime));
}
void Relight(object oPC, int nMain1, int nMain2, string sSound, int nTime)
{
    object oArea = GetArea(oPC);
    vector vTile = Vector(2.0f,11.0f);
    location lTile = Location(oArea, vTile, 0.0f);
    SetTileMainLightColor(lTile,nMain1,nMain2);
    vTile = Vector(3.0f,11.0f);
    lTile = Location(oArea, vTile, 0.0f);
    SetTileMainLightColor(lTile,nMain1,nMain2);
    RecomputeStaticLighting(oArea);
    DeleteLocalInt(oPC,"nShaftLighting");
    PlaySound(sSound);
    string sFeedback;
    switch(nTime)
    {
        case 0: sFeedback = "The hatch above slams shut";break;
        case 1: sFeedback = "A hatch opens above, letting the sunlight in";
                ExecuteScript("dla_burnvamps",oPC);break;
        case 2: sFeedback = "A hatch opens above, letting the moonlight in";break;
    }
    FloatingTextStringOnCreature(sFeedback,oPC);
}
