//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_redgrd1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Unlocks all of the gates in Hillsfar so that
//       player can pass through.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"
#include "hf_in_plot"

void main()
{
    object oGate1 = GetObjectByTag("TempleDistrictGate");
    object oGate2 = GetObjectByTag("MerchantDistrictGate");
    object oGate3 = GetObjectByTag("HillsfarEntranceGate");
    object oGuard = OBJECT_SELF;

    if(GetLocked(oGate1))
    {
        SetLocalInt(OBJECT_SELF, "nBusy", 1);
        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oGuard);
        SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oGuard);
        ActionUnlockObject(oGate1);
        ActionOpenDoor(oGate1);
        ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oGuard));
        ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 1));
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
    }

    AssignCommand(oGate2, ActionUnlockObject(OBJECT_SELF));
    AssignCommand(oGate3, ActionUnlockObject(OBJECT_SELF));
    DelayCommand(0.5, AssignCommand(oGate2, ActionOpenDoor(OBJECT_SELF)));
}
