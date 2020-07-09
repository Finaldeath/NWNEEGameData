//::///////////////////////////////////////////////
//:: pod_a3_oilfountn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create Flasks of oil in the fountains
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void FillFlasks (object oInventory, int iFlasks);

void main()
{
    object oSelf = OBJECT_SELF;
    object oItemDisturbed = GetInventoryDisturbItem();
    object oInventory = GetFirstItemInInventory(oSelf);
    int iCount, iDifficulty, iSuggested, iOilCount;
    int iType = GetInventoryDisturbType();

    // if somthing was removed or stolen activate the respawn
    if (((iType == INVENTORY_DISTURB_TYPE_REMOVED)
      || (iType == INVENTORY_DISTURB_TYPE_STOLEN))
      && (GetTag(oItemDisturbed) == "a3_oilflask"))
    {
        while (GetIsObjectValid(oInventory) == TRUE)
        {
            if (GetResRef(oInventory) == "a3_oilflask")
                iOilCount++;

            oInventory = GetNextItemInInventory(oSelf);
        }

        iDifficulty = GetGameDifficulty();
        switch (iDifficulty)
        {
            case GAME_DIFFICULTY_CORE_RULES:
            case GAME_DIFFICULTY_DIFFICULT:
                iSuggested = 2;
            break;
            case GAME_DIFFICULTY_NORMAL:
                iSuggested = 3;
            break;
            default:
                iSuggested = 4;
            break;
        }

        if (iOilCount < iSuggested)
        {
            FillFlasks(oSelf, iSuggested - iOilCount);
        }
    }
}

void CreateFlask(object oInventory, int iCount)
{
    CreateItemOnObject("a3_oilflask", oInventory, iCount);
}

void FillFlasks (object oInventory, int iFlasks)
{
    float fDelay = 5.5f;

    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0f, fDelay);
    DelayCommand(fDelay + 0.5, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DelayCommand(fDelay + 0.5, CreateFlask(oInventory, iFlasks));
}
