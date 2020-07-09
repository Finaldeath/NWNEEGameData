//January 2006
// B W-Husey
// Get rid of Jenny

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(OBJECT_SELF,"nNoTalk",1);
    ActionMoveAwayFromObject(oPC,FALSE,30.0);
    DestroyObject(OBJECT_SELF,5.0);
}
