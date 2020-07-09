//::///////////////////////////////////////////////
//::
//:: dla_mod_unacquir
//::
//:://////////////////////////////////////////////
/*
    Handles removal of various items.

*/
//:://////////////////////////////////////////////
//:: Created By: Dradjeel, Gale, B W-Husey
//:: Last Edit On: 16th May 2006
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "cu_functions"
#include "dla_i0_feats"

void main()
{
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();
    string sTag = GetTag(oItem);
    object oPos = GetItemPossessor(oItem);
    string sPosTag = GetTag(oPos);

    if (!GetIsObjectValid(oItem))
        return;

    // * Generic Item Script Execution Code
    // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // * it will execute a script that has the same name as the item's tag
    // * inside this script you can manage scripts for all events by checking against
    // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNACQUIRE);
        int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }

    //Make sure the object lost is still in existence and not vanished into thin air AND that the item
    //is still tagged Plot (currently only the Helms of the Deep can become non-plot).
    if (GetPlotFlag(oItem))
    {
        //Any of the three keystones can be put into any of the three pedestals
        if (sTag == "Keystone1" || sTag == "Keystone2" || sTag == "Keystone3")
        {
            if (!(sPosTag == "CWPPed1" ||
                  sPosTag == "CWPPed2" ||
                  sPosTag == "CWPPed3" ||
                  GetIsDefPC(oPos)))
            {
                RetakeItem(oPC, oItem, oPos);
            }
        }

        //Any of the four golem hearts can be put into any of the four pedestals
        if (sTag == "GolemGem1" || sTag == "GolemGem2" || sTag == "GolemGem3" ||
            sTag == "GolemGem4")
        {
            if (!(sPosTag == "CBPedestal1" ||
                  sPosTag == "CBPedestal2" ||
                  sPosTag == "CBPedestal3" ||
                  sPosTag == "CBPedestal4" ||
                  GetIsDefPC(oPos)))
            {
                RetakeItem(oPC, oItem, oPos);
            }
        }

        if (sTag == "HelmoftheDeep")
        {
            //The Helms can be given to your henchmen but nobody else
            if (!(sPosTag == "Edgar"   ||
                  sPosTag == "Lacinda" ||
                  sPosTag == "Kathryn" ||
                  sPosTag == "Godfroy" ||
                  sPosTag == "Jonas"   ||
                  GetIsDefPC(oPos)))
            {
                RetakeItem(oPC, oItem, oPos);
            }
        }
    }

    if (GetBaseItemType(oItem)==BASE_ITEM_LARGEBOX)
    {
        if (!GetIsDefPC(oPC))
            return;

        //AssignCommand(oPC, SpeakString("Boxcheck."));

        object oContents = GetFirstItemInInventory(oItem);
        int nExit = FALSE;

        while (oContents != OBJECT_INVALID && nExit == FALSE)
        {
            string sConTag = GetTag(oContents);
            if (sConTag == "Keystone1" ||
                sConTag == "Keystone2" ||
                sConTag == "Keystone3" ||
                sConTag == "GolemGem1" ||
                sConTag == "GolemGem2" ||
                sConTag == "GolemGem3" ||
                sConTag == "GolemGem4" ||
                sConTag == "HelmoftheDeep")
            {
                //AssignCommand(oPC, SpeakString("Attempting retake."));
                //Stop the search at the first positive.
                nExit = TRUE;
                RetakeItem(oPC, oItem, oPos);
            }

            oContents = GetNextItemInInventory(oItem);
        }
    }

    if (sTag == "DLA_JOUST_ARMOR")
    {// Take heavy armor feat when the player returns jousting armor.
     // Needs to be taken away if the player leaves the jousting ground
        DLA_TakeFeat(oPC, IP_CONST_FEAT_ARMOR_PROF_HEAVY);
    }

    if (sTag == "DLA_JOUST_SHIELD")
    {// Take shield feat when the player returns jousting armor.
     // Needs to be taken away if the player leaves the jousting ground
        DLA_TakeFeat(oPC, IP_CONST_FEAT_SHIELD_PROFICIENCY);
    }
}


