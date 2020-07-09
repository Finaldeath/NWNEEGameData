//November 2005
// B W-Husey
// Get rid of the Old Man

void main()
{
    object oPC = GetPCSpeaker();
    ActionMoveToObject(GetWaypointByTag("WP_Coin"));
    DelayCommand(10.0,ActionMoveAwayFromObject(oPC,FALSE,60.0));
    DestroyObject(OBJECT_SELF,20.0);
    SetLocalInt(OBJECT_SELF,"nNoTalk",1);
}
