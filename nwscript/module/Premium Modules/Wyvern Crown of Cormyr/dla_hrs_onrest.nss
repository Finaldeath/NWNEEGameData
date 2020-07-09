//:://////////////////////////////////////////////////
//:: dla_hrs_onrest
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnRest event handler for horses

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
        ExecuteScript("nw_c2_defaulta", OBJECT_SELF);
        return;
    }

    // Nothing at present
}


