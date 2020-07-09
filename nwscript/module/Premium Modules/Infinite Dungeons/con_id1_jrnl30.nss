#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // camp frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
    sString += "An active Safe Zone has a " + IntToString(nTemp) + "% chance of being a camp.";
    sString = AddLineBreak(sString);

    // rest tent frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_REST_FREQUENCY);
    sString += "A Rest Tent will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // forge frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY);
    sString += "A Mystic Anvil will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // caster frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY);
    sString += "A Spellcaster will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // store frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY);
    sString += "A Merchant will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // hireling frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY);
    sString += "A Hireling will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // seller frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY);
    sString += "A Monster Seller will appear in camp " + IntToString(nTemp) + "% of the time.";
    sString = AddLineBreak(sString);

    // decor frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY);
    sString += "An unused spot in a camp will be decor " + IntToString(nTemp) + "% of the time.";

    SetCustomToken(5100, sString);

    return TRUE;
}
