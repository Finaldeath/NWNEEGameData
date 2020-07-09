//:://////////////////////////////////////////////////
//:: dla_hrs_percep
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnPerception event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated On: June 06, 2005

#include "X0_INC_HENAI"
#include "dla_i0_horse"

void main()
{
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("nw_c2_default2", OBJECT_SELF);
        return;
    }

    // * if henchman is dying and Player disappears then force a respawn of the
    if(GetIsHenchmanDying(OBJECT_SELF) == TRUE)
    {

        //henchman must be removed otherwise their corpse will follow the player
        object oPC = GetLastPerceived();
        int bVanish = GetLastPerceptionVanished();
        if(GetIsObjectValid(oPC) && bVanish == TRUE)
        {
            if(oPC == GetMaster())
            {
                DLA_RemoveHenchman(oPC, OBJECT_SELF);
            }
        }
    }

    //Go ahead and run the regular script for perception
    ExecuteScript("nw_ch_ac2", OBJECT_SELF);
}



