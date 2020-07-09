//::///////////////////////////////////////////////
//:: dla_atjoustmatch
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation action script sets a variable on the PC to indicate that
    they have been assigned a jousting match
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 2 Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

void main()
{
    DLA_SetHasJoustMatch(GetPCSpeaker());
}
