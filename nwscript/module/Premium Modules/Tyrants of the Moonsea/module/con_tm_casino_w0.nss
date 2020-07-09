//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_casino_w0
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Mulmaster Casino - Wheel of Fortune
//::
//:: PC places his bet in the container and
//:: selects a color (Red or Blue) with a dialog.
//:: - PCs can triple their money, but only with a
//::   25% chance of winning.
//:: - Items can be wagered away as well, in which
//::   case their full value will be used.
//::////////////////////////////////////////////////////


const int CUSTOM_TOKEN_COLOR = 5000;
const int ODDS_RATIO = 2;

const string SOUND_WIN  = "as_pl_nobyaygrp2";
const string SOUND_LOSE = "as_pl_comtntgrp1";


// Generate a modified result influenced by various feats
// - oPC: the player using the wheel
// - nPCSelection: The Color the PC has selected
// 25% chance of blue, 25% chance of Red, 50% chance of white
int getSpinResult(object oPC, int nSelectedColor)
{
    int nResult = Random(4);

    // Certain feats allow the PC to re-roll on a bad result
    if (nResult != nSelectedColor)
    {
        if (GetHasFeat(FEAT_LUCK_DOMAIN_POWER, oPC) ||
            GetHasFeat(FEAT_LUCKY, oPC))
        {
            nResult = Random(4);
        }
    }
    return nResult;
}


// Give all items back and calculate values of all items in the container
// to get the winnings
void exeWin(object oPC, object oContainer)
{
    int nTotalValue = 0;
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        if (!GetPlotFlag(oItem))
        {
            if (GetResRef(oItem) == "nw_it_gold001")
                nTotalValue = nTotalValue + GetNumStackedItems(oItem);
            else
                nTotalValue = nTotalValue + GetGoldPieceValue(oItem);
        }
        ActionGiveItem(oItem, oPC);
        oItem = GetNextItemInInventory(oContainer);
    }

    GiveGoldToCreature(oPC, nTotalValue * ODDS_RATIO);
}


// Destroy all items in the container
void clearInventory(object oPC, object oContainer)
{
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        if (GetPlotFlag(oItem))
        {
            ActionGiveItem(oItem, oPC);
        }
        else
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oContainer);
    }
}


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Using HF_ARG to select the color in the dialog
    int nPlayerSelection = GetLocalInt(OBJECT_SELF, "HF_ARG");
    int nResult = getSpinResult(oPC, nPlayerSelection);

    // Set a custom token for the dialog
    switch (nResult)
    {
        case 2:
        {
            SetCustomToken(CUSTOM_TOKEN_COLOR, "blue");
            break;
        }
        case 1:
        {
            SetCustomToken(CUSTOM_TOKEN_COLOR, "red");
            break;
        }
        default:
        {
            SetCustomToken(CUSTOM_TOKEN_COLOR, "white");
            break;
        }
    }
    DeleteLocalInt(OBJECT_SELF, "HF_ARG");

    if (nPlayerSelection == nResult)
    {
        AssignCommand(oPC, PlaySound(SOUND_WIN));
        exeWin(oPC, OBJECT_SELF);
        return TRUE;
    }
    else
    {
        AssignCommand(oPC, PlaySound(SOUND_LOSE));
        clearInventory(oPC, OBJECT_SELF);
        return FALSE;
    }
}
