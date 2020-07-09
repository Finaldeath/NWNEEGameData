//November 2005
// B W-Husey
// Get rid of the Witch Lord

void main()
{
    object oPC = GetPCSpeaker();
    ActionMoveAwayFromObject(oPC,FALSE,60.0);
    SetIsDestroyable(TRUE,FALSE,FALSE);
    SetImmortal(OBJECT_SELF,FALSE);
    SetPlotFlag(OBJECT_SELF,FALSE);
    DestroyObject(OBJECT_SELF,10.0);
}
