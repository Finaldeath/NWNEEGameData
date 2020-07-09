void main()
{
    object oPC=GetPCSpeaker();
    object oRab=GetObjectByTag("db_rabbitnez");
    location lRab=GetLocation(oRab);
    location lMirror=GetLocation(GetWaypointByTag("rabs_mirror"));
    ActionPauseConversation();
    AssignCommand(oRab,ActionForceMoveToLocation(lMirror,TRUE));
   // DelayCommand(3.5,AssignCommand(oRab,ActionForceMoveToLocation(lRab,TRUE)));
    DelayCommand(3.5,AssignCommand(oRab,ActionForceMoveToObject(oPC,TRUE,0.5)));
    DelayCommand(7.0,ActionResumeConversation());
   // DelayCommand(7.5,AssignCommand(oRab,SetFacingPoint(GetPosition(oPC))));
}
