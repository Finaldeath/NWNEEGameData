// dla_areahb_031.nss
// May 14 2006
// Robert Faber
// Recompute lighting on day/night cycle for escape hatch

//Resets the lightshaft placeable and area lighting (based on time of day)
void RelightDayNight(object oArea, location lTile, int nMain1, int nMain2);

void main()
{
    object oPC = GetFirstPC();
    object oWay = GetWaypointByTag("WP_lightshaft_031");
    object oArea = OBJECT_SELF;
    location lLoc = GetLocation(oWay);

    //tile location on x/y grid
    vector vTile = Vector(2.0f,11.0f);
    location lTile = Location(oArea, vTile, 0.0f);
    object oShaft = GetNearestObjectByTag("pf_lightshaft",oPC);

    int nTime = GetTimeHour();
    int bChange = FALSE;
    //if it is dawn or dusk, and the buffer hasn't been hit, and the
    //hatch is open (oShaft is valid), change the lightshaft and lighting
    if((nTime == 6 || nTime == 18) &&
       GetLocalInt(oArea,"nShaftTimeChanged")==FALSE &&
       GetIsObjectValid(oShaft))
    {
        bChange = TRUE;
    }
    //if not, bail out of heartbeat.
    if(!bChange)
    {
        return;
    }
    //set buffer
    SetLocalInt(oArea,"nShaftTimeChanged",TRUE);
    DestroyObject(oShaft);
    //delayed remove buffer
    DelayCommand(HoursToSeconds(2), DeleteLocalInt(oArea,"nShaftTimeChanged"));
    //if it is dawn, setup the sunlight effect
    if(nTime == 6)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"pf_lightday",lLoc);
        RelightDayNight(oArea,lTile,TILE_MAIN_LIGHT_COLOR_DARK_YELLOW,TILE_MAIN_LIGHT_COLOR_DARK_YELLOW);
        vTile = Vector(3.0f,11.0f);
        lTile = Location(oArea, vTile, 0.0f);
        RelightDayNight(oArea,lTile,TILE_MAIN_LIGHT_COLOR_DARK_YELLOW,TILE_MAIN_LIGHT_COLOR_DARK_YELLOW);

    }
    //else setup the moonlight effect
    else
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"pf_lightnight",lLoc);
        RelightDayNight(oArea,lTile,TILE_MAIN_LIGHT_COLOR_DARK_BLUE,TILE_MAIN_LIGHT_COLOR_DARK_BLUE);
        vTile = Vector(3.0f,11.0f);
        lTile = Location(oArea, vTile, 0.0f);
        RelightDayNight(oArea,lTile,TILE_MAIN_LIGHT_COLOR_DARK_BLUE,TILE_MAIN_LIGHT_COLOR_DARK_BLUE);
    }
}
void RelightDayNight(object oArea, location lTile, int nMain1, int nMain2)
{
    SetTileMainLightColor(lTile,nMain1,nMain2);
    RecomputeStaticLighting(oArea);
}
