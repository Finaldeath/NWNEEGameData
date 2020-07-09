// B W-Husey
// October 2005
// This script is executed from other scripts
// Closes Polter's Fort Drawbridge and locks it. Unlocking is only possible from inside the fort.

void main()
{
object oDraw1 = GetObjectByTag("PFDrawBridgeIn");
object oDraw2 = GetObjectByTag("PFDrawBridgeOut");
DelayCommand(5.0,AssignCommand(oDraw1,ActionCloseDoor(OBJECT_SELF)));  //test the timings vs horseback
DelayCommand(5.0,AssignCommand(oDraw2,ActionCloseDoor(OBJECT_SELF)));
DelayCommand(5.2,SetLocked(oDraw1,TRUE));
DelayCommand(5.2,SetLocked(oDraw2,TRUE));
}


