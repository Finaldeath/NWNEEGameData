// 2019-08-27
// https://app.asana.com/0/842177838074622/1135298748483782
#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    object oGem = CreateItemOnObject("nw_it_gem005", oPC);

    debug("Created Gem? " + IntToString(GetIsObjectValid(oGem)));
}
