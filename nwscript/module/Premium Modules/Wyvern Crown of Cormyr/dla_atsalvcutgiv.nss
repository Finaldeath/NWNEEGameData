// Jan 2006
// B W-Husey
// Give PC the Adventurer's Charter.

void main()
{
    object oPC = GetPCSpeaker();
    object oChart = GetItemPossessedBy(OBJECT_SELF,"AdventurersChart");
    if (GetIsObjectValid(oChart)==FALSE)
    {
    //SendMessageToPC(GetPCSpeaker(),"Chart not found (final)");
    oChart = CreateItemOnObject("adventurerschart",oPC);
    }
    else DelayCommand(1.0,ActionGiveItem(oChart,oPC));
    DelayCommand(2.0,SetPlotFlag(oChart,TRUE));
    SetCommandable(TRUE,GetPCSpeaker());
}
