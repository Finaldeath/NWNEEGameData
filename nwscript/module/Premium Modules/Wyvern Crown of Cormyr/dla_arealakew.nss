// October 2005
// B W-Husey
// This OnEnter script is used on Lake Wyvernwater. First 2 entries the lake is clear.
// Third time on it is foggy.

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsDefPC(oPC))
    {
    int nFog = 20;
    int nSky = SKYBOX_ICY;
    int nCheck = GetLocalInt(oPC,"nFirstLWArea");
    if (nCheck<2)
    {
        SetLocalInt(oPC,"nFirstLWArea",nCheck+1);
        nFog = 0;
        nSky = SKYBOX_GRASS_CLEAR;
        SetWeather(oArea,WEATHER_CLEAR);
    }
    SetSkyBox(nSky,oArea);
    SetFogAmount(FOG_TYPE_SUN,nFog,oArea);
    SetFogAmount(FOG_TYPE_MOON,nFog,oArea);
    }
}


