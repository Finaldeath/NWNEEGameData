// January 2006
// B W-Husey
// Handing over the charter.

void main()
{
    object oFaril = GetNearestObjectByTag("LaheralsonCut1");
    object oChart = GetItemPossessedBy(oFaril,"AdventurersChart");
    if (GetIsObjectValid(oChart)==FALSE)
    {
    //SendMessageToPC(GetPCSpeaker(),"Chart not found (Faril)");
    CreateItemOnObject("adventurerschart",OBJECT_SELF);
    }
    DelayCommand(3.0,AssignCommand(oFaril,ActionGiveItem(oChart,OBJECT_SELF)));
}
