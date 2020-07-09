//:://////////////////////////////////////////////////
//:: dla_hrs_userdef
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnUserDefined event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated On: June 06, 2005

#include "x0_inc_henai"
#include "dla_i0_horse"

void main()
{
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("x2_def_userdef", OBJECT_SELF);
        return;
    }

    //Perform events for the horse henchman, if master stealthed or detecting,
    //horse does likewise
    int nEvent = GetUserDefinedEventNumber();
    if(nEvent == 20000 + ACTION_MODE_STEALTH)
    {
        int bStealth = GetActionMode(GetMaster(), ACTION_MODE_STEALTH);
        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, bStealth);
    }
    else if(nEvent == 20000 + ACTION_MODE_DETECT)
    {
        int bDetect = GetActionMode(GetMaster(), ACTION_MODE_DETECT);
        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, bDetect);
    }
}

