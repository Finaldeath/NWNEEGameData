void main()
{
    object oPC = GetPCSpeaker();
    DelayCommand(14.0,SetIsDestroyable(TRUE,FALSE,FALSE));
    DelayCommand(15.0,ActionMoveToObject(GetWaypointByTag("TFEExitPoint"),TRUE));
    DelayCommand(15.0,AddJournalQuestEntry("Damsel",20,oPC));
    DestroyObject(OBJECT_SELF,20.0);

}
