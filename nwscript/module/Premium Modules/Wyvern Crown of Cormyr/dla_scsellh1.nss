////////////////////////////////////////////////////////////////////////////////
// dla_scsellh1 - Set Horse Selling price Tokens and Variables
// Scripted By: Deva B. Winblood   8/3/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"



int privateGetTemplate(string sRes)
{ // PURPOSE: Return the template number to use with this horse
    if (sRes=="dla_lighthorse") return DLA_TEMPLATE_LIGHT_HORSE_1;
    else if (sRes=="dla_lighthorse2") return DLA_TEMPLATE_LIGHT_HORSE_2;
    else if (sRes=="dla_lighthorse3") return DLA_TEMPLATE_LIGHT_HORSE_3;
    else if (sRes=="dla_heavyhorse") return DLA_TEMPLATE_HEAVY_HORSE_1;
    else if (sRes=="dla_heavyhorse2") return DLA_TEMPLATE_HEAVY_HORSE_2;
    else if (sRes=="dla_heavyhorse3") return DLA_TEMPLATE_HEAVY_HORSE_3;
    else if (sRes=="dla_lgtwarhorse") return DLA_TEMPLATE_LIGHT_WARHORSE_1;
    else if (sRes=="dla_lgtwarhorse2") return DLA_TEMPLATE_LIGHT_WARHORSE_2;
    else if (sRes=="dla_lgtwarhorse3") return DLA_TEMPLATE_LIGHT_WARHORSE_3;
    else if (sRes=="dla_lgtwarhorse4") return DLA_TEMPLATE_LIGHT_WARHORSE_4;
    else if (sRes=="dla_lgtwarhorse5") return DLA_TEMPLATE_LIGHT_WARHORSE_5;
    else if (sRes=="dla_hvywarhorse") return DLA_TEMPLATE_HEAVY_WARHORSE_1;
    else if (sRes=="dla_hvywarhorse2") return DLA_TEMPLATE_HEAVY_WARHORSE_2;
    else if (sRes=="dla_hvywarhorse3") return DLA_TEMPLATE_HEAVY_WARHORSE_3;
    else if (sRes=="dla_hvywarhorse4") return DLA_TEMPLATE_HEAVY_WARHORSE_4;
    else if (sRes=="dla_hvywarhorse5") return DLA_TEMPLATE_HEAVY_WARHORSE_5;

    return DLA_TEMPLATE_LIGHT_HORSE_1;
} // privateGetTemplate()



//////////////////////////////////////////////////////////////////////[ MAIN ]//
int StartingConditional()
{
    object oHorse=GetLocalObject(OBJECT_SELF,"oInterested");
    string sToken;
    string sRes=GetResRef(oHorse);
    int nTemplate=privateGetTemplate(sRes);
    int nValue=DLA_GetHorsePrice(nTemplate);
    float fPer=GetLocalFloat(GetModule(),"fHorseSellPercentage");
    float fActual=fPer*IntToFloat(nValue);
    nValue=FloatToInt(fActual);
    sToken=IntToString(nValue)+" gold for the steed.";
    SetLocalInt(OBJECT_SELF,"nSellPrice",nValue);
    SetCustomToken(112670,sToken);
    return TRUE;
}
//////////////////////////////////////////////////////////////////////[ MAIN ]//
