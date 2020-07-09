//:://////////////////////////////////////////////////
//:: dla_hrs_blocked
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnBlocked event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"

void main()
{

    object oDoor = GetBlockingDoor();

/*
    if (GetObjectType(oDoor) == OBJECT_TYPE_CREATURE)
    {
            SpeakString("Blocked by creature");
    }
*/
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("nw_c2_defaulte", OBJECT_SELF);
        return;
    }


    /*int nInt = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE); Intelligence equal to/greater than3 will never not be true...*/
    int nStr = GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH);

    if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN)/* &&  nInt >= 3*/)
    {
        DoDoorAction(oDoor, DOOR_ACTION_OPEN);
    }

    else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH) && nStr >= 16)
    {
        DoDoorAction(oDoor, DOOR_ACTION_BASH);
    }
}


