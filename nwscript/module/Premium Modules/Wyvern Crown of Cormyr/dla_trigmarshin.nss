// dla_trigmarshin
// May 2006
// B W-Husey
// March entry script - apply slow movement

#include "x2_inc_toollib"
//#include "nw_i0_tool"
#include "dla_i0_horse"

void main()
{
    // Applies slowing effect to all creatures, except those .
    object oPC = GetEnteringObject();
    effect eSlow = EffectMovementSpeedDecrease(30);
    int nApp = GetAppearanceType(oPC);
    string sTag = GetTag(oPC);
    sTag = GetStringLeft(sTag,5);
    if(HasItem(oPC, "TreasureMap")) AddJournalQuestEntry("Treasure",20,oPC);

    //exclude creatures that are not affected
    if (nApp==APPEARANCE_TYPE_ELEMENTAL_WATER || nApp==APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER || nApp==APPEARANCE_TYPE_SHARK_MAKO || nApp==APPEARANCE_TYPE_SHARK_HAMMERHEAD || nApp==APPEARANCE_TYPE_SHARK_GOBLIN)
    {
    return;
    }
    else if (sTag=="Curst" || sTag =="Black" || sTag =="Gold") return;
    else
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oPC);
        if (DLA_GetIsMounted(oPC)) FloatingTextStringOnCreature("Your horse's hooves are sticking in the soft ground",oPC,FALSE);
        else FloatingTextStringOnCreature("Your feet are sticking in the soft ground",oPC,FALSE);
    }
}
