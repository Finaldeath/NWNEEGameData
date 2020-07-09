// January 2006
// B W-Husey
// Handing over the charter.

void main()
{
    object oFaril = GetNearestObjectByTag("LaheralsonCut1");
    object oChart = GetItemPossessedBy(OBJECT_SELF,"AdventurersChart");
    if (GetIsObjectValid(oChart)==FALSE)
    {
    //SendMessageToPC(GetPCSpeaker(),"Chart not found");
    CreateItemOnObject("adventurerschart",oFaril);
    }
    DelayCommand(0.1,ActionGiveItem(oChart,oFaril));
}
