//::///////////////////////////////////////////////
//:: dla_obbeamstop
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Reactivates a beam and trigger of the beam puzzle in the
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

void main()
{
    int nSec = GetTimeSecond() + 3;
    int nMin = GetTimeMinute();
    if (nSec > 59)
    {
        nSec -= 60;
        nMin++;
    }

    object oTrig    = GetObjectByTag("CWPTrig" + GetStringRight(GetTag(OBJECT_SELF),1));
    SetLocalInt(oTrig, "nActMin", nMin);
    SetLocalInt(oTrig, "nActSec", nSec);
    DelayCommand(3.0, SignalEvent(oTrig, EventUserDefined(DLA_EVENT_DEATHBEAM_ON)));
}
