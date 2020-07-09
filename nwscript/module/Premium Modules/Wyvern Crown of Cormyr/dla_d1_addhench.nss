//:://////////////////////////////////////////////////
//:: dla_d1_addhench
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////////
/*
    Simply adds the npc as a henchman to the PC speaker.
*/
//:://////////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: 07/06/05  Updated On: 17/06/05
//:://////////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
    DLA_SetHenchman(OBJECT_SELF, GetPCSpeaker());
    DLA_RefreshMovementSpeed(OBJECT_SELF);
}

