//::///////////////////////////////////////////////
//:: Act 2 Tasina, end conversation script
//:: cex_a2_tasina
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Since Tasina is leaving the island, change
    the weather for the Sandy Spit area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9, 2005
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oArea = GetObjectByTag("SpindriftIslandSpindrift");

    //light blue for the day
    SetFogColor(FOG_TYPE_SUN, 13158640, oArea);
    // Dark grey for the night
    SetFogColor(FOG_TYPE_MOON, 986895, oArea);

    // Modify the fog amount and turn off the rain
    SetFogAmount(FOG_TYPE_ALL, 5, oArea);
    SetWeather(oArea, WEATHER_CLEAR);
    SetSkyBox(SKYBOX_GRASS_CLEAR, oArea);
}
