// B W-Husey
// October 2005
// The simplest of the door scripts. This one closes the door 20 seconds after it is opened.
// Use it only in areas where it won't interfere with combat.

void main()
{
//    object oPC = GetLastOpenedBy();
DelayCommand(30.0,ActionCloseDoor(OBJECT_SELF));
}
