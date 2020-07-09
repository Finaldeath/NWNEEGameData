//::///////////////////////////////////////////////
//:: dla_trigclear
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Temporarily deactivates a beam and trigger of the beam puzzle in the
   Wyvernwater Castle: Through the Portal area.
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Hughes
//:: Created On: January, 2006
//:://////////////////////////////////////////////
//:: Modified:
//:: Syrsnein - 5 April 2006, Rewrote the script and removed the old code after
//::    debugging and ensuring everything works.

#include "dla_i0_const"

const int nDelay = 5;

void main()
{
    object oTrigger = GetObjectByTag("CWPTrigger" + GetStringRight(GetTag(OBJECT_SELF),1));
    int nTimer = GetLocalInt(oTrigger, "nTimer");
    if (nTimer < nDelay) SetLocalInt(oTrigger, "nTimer", nDelay);
    SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_OFF));
    DelayCommand(0.1, SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_ON)));
}
