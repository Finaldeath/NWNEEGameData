//::///////////////////////////////////////////////
//:: FileName ddf_gv_cityguard
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-11-01 3:22:41 PM
//:://////////////////////////////////////////////
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    if(GetIsItemPossessedByParty(oPC, "CityGuardKey") == FALSE)
    {
        CreateItemOnObject("cityguardkey", GetPCSpeaker(), 1);
    }
}
