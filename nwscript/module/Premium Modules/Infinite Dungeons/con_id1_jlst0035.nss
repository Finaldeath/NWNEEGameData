#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType >= 35) && (nListType <= 64))
    {
        string sString = "";
        int nTemp;

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BASTARDSWORD_PERCENTAGE);
        sString += "Bastard swords have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BATTLEAXE_PERCENTAGE);
        sString += "Battle axes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_CLUB_PERCENTAGE);
        sString += "Clubs have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DAGGER_PERCENTAGE);
        sString += "Daggers have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DIREMACE_PERCENTAGE);
        sString += "Dire maces have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DOUBLEAXE_PERCENTAGE);
        sString += "Double axes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DWARVENWARAXE_PERCENTAGE);
        sString += "Dwarven war axes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_GREATAXE_PERCENTAGE);
        sString += "Greataxes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_GREATSWORD_PERCENTAGE);
        sString += "Greatswords have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HALBERD_PERCENTAGE);
        sString += "Halberds have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HANDAXE_PERCENTAGE);
        sString += "Handaxes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HEAVYFLAIL_PERCENTAGE);
        sString += "Heavy flails have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KAMA_PERCENTAGE);
        sString += "Kamas have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KATANA_PERCENTAGE);
        sString += "Katanas have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KUKRI_PERCENTAGE);
        sString += "Kukris have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTFLAIL_PERCENTAGE);
        sString += "Light flails have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTHAMMER_PERCENTAGE);
        sString += "Light hammers have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTMACE_PERCENTAGE);
        sString += "Light maces have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LONGSWORD_PERCENTAGE);
        sString += "Longswords have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_STAFF_PERCENTAGE);
        sString += "Staves have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_MORNINGSTAR_PERCENTAGE);
        sString += "Morningstars have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_RAPIER_PERCENTAGE);
        sString += "Rapiers have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SCIMITAR_PERCENTAGE);
        sString += "Scimitars have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SCYTHE_PERCENTAGE);
        sString += "Scythes have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTSPEAR_PERCENTAGE);
        sString += "Shortspears have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTSWORD_PERCENTAGE);
        sString += "Shortswords have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SICKLE_PERCENTAGE);
        sString += "Sickles have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_TWOBLADEDSWORD_PERCENTAGE);
        sString += "Two-bladed swords have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_WARHAMMER_PERCENTAGE);
        sString += "Warhammers have a proportional chance of " + IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // weapon frequency
        nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_WHIP_PERCENTAGE);
        sString += "Whips have a proportional chance of " + IntToString(nTemp) + ".";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
