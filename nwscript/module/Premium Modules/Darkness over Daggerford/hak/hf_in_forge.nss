// item forging system

// ---------------------------- INIT ---------------------------------------

// init the variables used in the forge system
// .. use this script at start of convo
void ForgeInit(object oNPC)
{
    SetLocalInt(oNPC, "HF_FORGE_ITEM_NUM", 0);
    SetLocalInt(oNPC, "HF_ARG", 0);
    SetLocalInt(oNPC, "HF_FORGE_CHOICES", 0);

    int i;
    for (i=1; i<=5; i++)
    {
        string sIndex = "HF_FORGE_ITEM_" + IntToString(i) + "_";
        SetLocalInt(oNPC, sIndex + "HIDE", 0);
    }
}

// ---------------------------- DISPLAY ---------------------------------------

// can a particular item be displayed to the player?
int ForgeCanDisplay(object oNPC, int nItemNum)
{
    string sIndex  = "HF_FORGE_ITEM_" + IntToString(nItemNum) + "_";
    int nHide      = GetLocalInt(oNPC, sIndex+"HIDE");
    return(nHide == 0);
}

// was at least one forge-able item described to the player?
int ForgeChoicesAvailable(object oNPC)
{
    int nChoices = GetLocalInt(oNPC, "HF_FORGE_CHOICES");
    return(nChoices > 0);
}

// does the player have the correct ingredients for an item?
// .. use this script to display if an item can be made, and to verify
// .. when the player asks to make an item
int ForgeHasIngredients(object oNPC, object oPC, int nItemNum)
{
    string sIndex   = "HF_FORGE_ITEM_" + IntToString(nItemNum) + "_";
    int nCost       = GetLocalInt(oNPC, sIndex+"COST");
    string sIngred1 = GetLocalString(oNPC, sIndex+"INGRED1");
    string sIngred2 = GetLocalString(oNPC, sIndex+"INGRED2");
    object oIngred1 = GetItemPossessedBy(oPC, sIngred1);
    object oIngred2 = GetItemPossessedBy(oPC, sIngred2);
    if (GetIsObjectValid(oIngred1) && GetIsObjectValid(oIngred2))
    {
        int nChoices = GetLocalInt(OBJECT_SELF, "HF_FORGE_CHOICES");
        SetLocalInt(oNPC, "HF_FORGE_CHOICES", ++nChoices);
        SetLocalInt(oNPC, sIndex + "HIDE", 1);
        return(TRUE);
    }
    return(FALSE);
}

// ---------------------------- MAKE ---------------------------------------

// does the player have enough gold to forge an item?
// .. use this to verify before making an item
int ForgeHasEnoughGold(object oNPC, object oPC, int nItemNum)
{
    string sIndex   = "HF_FORGE_ITEM_" + IntToString(nItemNum) + "_";
    int nCost       = GetLocalInt(oNPC, sIndex+"COST");
    return (GetGold(oPC) >= nCost);
}

// make an item (checks that player has enough gold and the correct ingredients)
// .. use this script when the player asks to forge the item
void ForgeMake(object oNPC, object oPC, int nItemNum)
{
    string sIndex   = "HF_FORGE_ITEM_" + IntToString(nItemNum) + "_";
    int nCost       = GetLocalInt(oNPC, sIndex+"COST");
    string sIngred1 = GetLocalString(oNPC, sIndex+"INGRED1");
    string sIngred2 = GetLocalString(oNPC, sIndex+"INGRED2");
    string sResult  = GetLocalString(oNPC, sIndex+"RESULT");
    if (GetGold(oPC) >= nCost)
    {
        object oIngred1 = GetItemPossessedBy(oPC, sIngred1);
        object oIngred2 = GetItemPossessedBy(oPC, sIngred2);
        if (GetIsObjectValid(oIngred1) && GetIsObjectValid(oIngred2))
        {
            TakeGoldFromCreature(nCost, oPC);
            DestroyObject(oIngred1);
            DestroyObject(oIngred2);
            object oItem = CreateItemOnObject(sResult, oPC);
            SetIdentified(oItem, TRUE);
        }
    }
}

// ---------------------------------------------------------------------------

/*
NPC:
- HF_FORGE_ITEM_1_INGRED1 = blueprint of the first ingredient
- HF_FORGE_ITEM_1_INGRED2 = blueprint of the second ingredient
- HF_FORGE_ITEM_1_RESULT  = blueprint of the resulting item
- HF_FORGE_ITEM_1_COST    = cost, in gold, of this item

- HF_FORGE_CHOICES        = number of choices given to player
- HF_FORGE_ITEM_1_HIDE    = true if this item should not be displayed
*/
