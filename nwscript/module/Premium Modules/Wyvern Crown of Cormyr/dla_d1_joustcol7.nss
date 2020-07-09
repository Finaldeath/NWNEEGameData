//::///////////////////////////////////////////////
//:: dla_scjoustcol7
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Color selection conversation action script to set the jousting horse tail
    to be used for jousting.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 14 Mar 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DLA_JoustSetColors(oPC, DLA_JOUST_TAIL_COLOR7);
    DeleteLocalInt(oPC, "bJoustArmorReturned");
}
