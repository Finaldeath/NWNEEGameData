//::///////////////////////////////////////////////
//:: dla_scjoustready
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Joust conversation conditional script that returns TRUE if the PC is ready
    to joust.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: 26 Feb 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    return DLA_JoustGetCanJoust(GetPCSpeaker());
}
