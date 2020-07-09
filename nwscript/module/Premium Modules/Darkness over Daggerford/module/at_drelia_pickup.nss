void main()
{
    object oDrelia = GetObjectByTag("db_drelia");
    object oLetter = GetObjectByTag("db_teyganletter");
    ActionPauseConversation();
    //AssignCommand(oDrelia,ClearAllActions());
    AssignCommand(oDrelia,ActionPickUpItem(oLetter));
    DelayCommand(2.5,ActionResumeConversation());
}
