//:://////////////////////////////////////////////////
//:: dla_d1_unhench
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////////
/*
    Simply removes the npc as a henchman to the PC speaker.
*/
//:://////////////////////////////////////////////////
//:: Created By: DirgeSinger  Created On: 07/06/05
//:: Updated On: 7/30/2006 - Deva B. Winblood  Mantis # 1949
//:://////////////////////////////////////////////////

//::PATCH VERSION HISTORY
//::mm/dd/yyyy | MODIFIED BY     | DESCRIPTION
//  09/15/2006 | Deva B. Winblood| Made it so a released Paladin Horse unsummons.

#include "dla_i0_horse"

void main()
{
    object oMe=OBJECT_SELF;
    ClearAllActions();
    DLA_RemoveHenchman(GetMaster(oMe),oMe);
    DLA_RefreshMovementSpeed(oMe);
    DelayCommand(4.0,AssignCommand(oMe,ClearAllActions(TRUE)));
    DelayCommand(4.1,DeleteLocalObject(oMe,"oDLA_HORSE_OWNER"));
    DelayCommand(4.11,DeleteLocalObject(oMe,"oDLAMyMaster"));
    if (DLA_GetIsPaladinMount(oMe))
    { // Paladin Mount
        DLA_DespawnPaladinMount(oMe);
    } // Paladin Mount
}
