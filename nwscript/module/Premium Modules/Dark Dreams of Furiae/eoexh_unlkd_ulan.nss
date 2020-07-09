#include "ddf_util"
void main()
{
    debug("-- all bad guys dead...");

    object oTarget = GetObjectByTag("UlanOfficeDoor");
    if(oTarget == OBJECT_INVALID) debug("Unable to find UlanOfficeDoor...");
    SetPlotFlag(oTarget, FALSE);
    SetLockKeyRequired(oTarget, FALSE);
    AssignCommand(oTarget, ActionUnlockObject(oTarget));

    object oPC = GetFirstPC();// GetEnteringObject();
    if(GetIsObjectValid(oPC))
    {
        oTarget = oPC;
    }

    AssignCommand(oTarget, ActionSpeakString("[Sound of a door unlocking]"));
}
