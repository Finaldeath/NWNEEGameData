#include "ddf_util"
#include "x2_inc_switches"


void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oSpellOrigin;                             // The origin of the spell
    object oSpellTarget;                             // The target of the spell
    int    iSpell;                                   // The Spell ID number
    object oPlaceable;
    int    iNewspaperDay;                           // Local day set on the newspaper item.
    int    iPlaceableDay;
    string dlg_resref;

    // Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {


        case X2_ITEM_EVENT_ACTIVATE:
            // * This code runs when the Unique Power property of the item is used or the item
            // * is activated. Note that this event fires for PCs only

            oPC   = GetItemActivator();             // The player who activated the item
            oItem = GetItemActivated();             // The item that was activated

            // Your code goes here

            // create placeable which can trigger the dialog.
            //debug("Activated the newspaper DAY 1.");
            //oItem = GetObjectByTag("p_dlg_fs");
            // I need to set the DAY local var on this item, so the dialog scripts will work.

            oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, "pl_dlg_fs", GetLocation(oPC));

            //SetName(oPlaceable, "Furiae Sentinel");

            iNewspaperDay = GetLocalInt(oItem, "DDF_CURRENT_DAY");
            dlg_resref = "dlg_fs" + IntToString(iNewspaperDay);

            //SetLocalInt(oPlaceable, CURRENT_DAY, 0);
            //iPlaceableDay = GetLocalInt(oPlaceable, CURRENT_DAY);

            debug("day = " + IntToString(iNewspaperDay) + " res: " + dlg_resref);

            //object oFSDLG = GetObjectByTag("p_dlg_fs");
            //DelayCommand(0.2, AssignCommand(oItem, ActionStartConversation(oPC, FS_DLG)));

            //DelayCommand(0.3, SetLocalInt(oPlaceable, CURRENT_DAY, iNewspaperDay));
            DelayCommand(1.0, AssignCommand(oPlaceable, ActionStartConversation(oPC, dlg_resref)));

            break;


    }

    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}


