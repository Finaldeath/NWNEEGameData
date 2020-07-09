//:://////////////////////////////////////////////////
//:: dla_hrs_damaged
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

   OnDamaged event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("x2_def_ondamage", OBJECT_SELF);
        return;
    }

    ExecuteScript("nw_ch_ac6", OBJECT_SELF);
}


