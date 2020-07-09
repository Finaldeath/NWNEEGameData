// tala identifies items in player's pack

void IdentifyAll(object oPC)
{
    int nMyLore = 20;
    int nItemValue; // gold value of item
    string sMaxValue = Get2DAString("SkillVsItemCost", "DeviceCostMax", nMyLore); // max value that the henchman can id
    int nMaxValue = StringToInt(sMaxValue);

    // handle overflow
    if (sMaxValue == "")
    {
        nMaxValue = 120000000;
    }

    object oItem = GetFirstItemInInventory(oPC);
    while(oItem != OBJECT_INVALID)
    {
        if(!GetIdentified(oItem))
        {
            SetIdentified(oItem, TRUE); // setting TRUE to get the true value of the item
            nItemValue = GetGoldPieceValue(oItem);
            SetIdentified(oItem, FALSE); // back to FALSE
            if(nMaxValue >= nItemValue)
            {
                SetIdentified(oItem, TRUE);
                SendMessageToPC(oPC, GetName(OBJECT_SELF) + " " +  GetStringByStrRef(75930) + " " + GetName(oItem));
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    IdentifyAll(oPC);
}
