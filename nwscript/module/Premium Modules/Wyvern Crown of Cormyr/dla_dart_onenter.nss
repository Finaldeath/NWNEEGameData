// October 2005
// B W-Husey
// Unequip weapons from hand

#include "cu_functions"
#include "dla_i0_feats"
void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsDefPC(oPC))
    {
    //disarm entering party and store what weapons they used
    DisarmParty(oPC);
    }
    if(!GetIsDefPC(oPC) || GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE,oPC))
    {
        return;
    }
    DLA_GiveFeat(oPC, IP_CONST_FEAT_WEAPON_PROF_SIMPLE);
}
