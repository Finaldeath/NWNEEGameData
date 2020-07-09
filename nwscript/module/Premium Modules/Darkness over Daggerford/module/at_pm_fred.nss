void main()
{
     AssignCommand(GetObjectByTag("AR0500_AR0700_EXIT"), ActionCloseDoor(GetObjectByTag("AR0500_AR0700_EXIT")));
     AssignCommand(GetObjectByTag("C1AR0500_0401_EXIT"), ActionCloseDoor(GetObjectByTag("C1AR0500_0401_EXIT")));
     AssignCommand(GetObjectByTag("AR0500_AR0800_EXIT"), ActionCloseDoor(GetObjectByTag("AR0500_AR0800_EXIT")));
     AssignCommand(GetObjectByTag("pm_rivergate"), ActionCloseDoor(GetObjectByTag("pm_rivergate")));
     SetLocked(GetObjectByTag("AR0500_AR0700_EXIT"), TRUE);
     SetLocked(GetObjectByTag("C1AR0500_0401_EXIT"), TRUE);
     SetLocked(GetObjectByTag("AR0500_AR0800_EXIT"), TRUE);
     SetLocked(GetObjectByTag("pm_rivergate"), TRUE);

     ExecuteScript("at_remove_immob",OBJECT_SELF);

     SetLocalInt(GetModule(), "fred2_hasmet", 1);
}
