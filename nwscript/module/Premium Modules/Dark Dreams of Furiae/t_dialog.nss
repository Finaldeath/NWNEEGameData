#include "ddf_util"

// NAME the TRIGGER using the following format:
// "<maxCount>.placeableTAG.dialogName"
// you can leave the last ".dialogName" off if you want to use the default dialog associated with the placeable.
// set "<maxCount>" to 0 if you want to trigger the dialog on every trigger. Otherwise it plays it maxCount times.

void main()
{
    object oModule = GetModule();

    object oPC = GetEnteringObject();
    string sTriggerName = GetName(OBJECT_SELF);// GetTag(OBJECT_SELF);
    int iPos = FindSubString(sTriggerName, ".", 0); //
    int iRightPos = GetStringLength(sTriggerName) - iPos;
    int iMaxCount = StringToInt(GetStringLeft(sTriggerName, iPos)); // number of times triggerable.
    string subStringOne = GetStringRight(sTriggerName, iRightPos -1); // "placeableTag.dialogName"

    iPos = FindSubString(subStringOne, ".", 0);
    string sPlaceableTag = subStringOne;
    string sDialog = "";

    int iCount = GetLocalInt(oModule, sTriggerName + "count");

    if(iPos != -1)
    {
        sPlaceableTag = GetStringLeft(subStringOne, iPos);
        sDialog = GetStringRight(subStringOne, GetStringLength(subStringOne) - iPos - 1);
    }

    object oPlaceable = GetObjectByTag(sPlaceableTag);

    if(GetIsPC(oPC) && (iCount < iMaxCount || iMaxCount == 0))
    {
        debug("triggered dialog '" + sDialog + "', " + sPlaceableTag + " '" + sTriggerName + "' " + IntToString(iPos) + "/" + IntToString(iRightPos) + " " + IntToString(GetIsObjectValid(oPlaceable)) + " count: " + IntToString(iCount) + "/" + IntToString(iMaxCount));

        if(GetIsObjectValid(oPlaceable) == FALSE)
        {
            debug("badly named placeable/name for script. " + sTriggerName + "/" + sPlaceableTag);
            return;
        }

        DelayCommand(1.0, AssignCommand(oPlaceable, ActionStartConversation(oPC, sDialog, FALSE)));
        //DestroyObject(oPlaceable, 4.0);
        SetLocalInt(GetModule(), sTriggerName + "count", iCount + 1);
    }
}
