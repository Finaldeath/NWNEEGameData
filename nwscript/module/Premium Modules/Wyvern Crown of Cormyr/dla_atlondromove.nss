// September 2005
// B W-Husey
// Londro leaves via exit. Teleported back to forge, where he falls asleep.
// Modification July 06: remove witness doc if still on PC.
void main()
{
 location lLoc = GetLocation(GetWaypointByTag("JP_Londro2"));
 object oLondro = OBJECT_SELF;
 object oDoor = GetObjectByTag("MADoorExitMain");
 DestroyObject(GetObjectByTag("WitnessDoc"));
 ClearAllActions();
 DelayCommand(0.1,ActionMoveToObject(GetObjectByTag("MADoorExitMain"),FALSE,0.7));
 SetLocalInt(OBJECT_SELF,"nNoTalk",1);
 DelayCommand(4.0,AssignCommand(oDoor,ActionOpenDoor(OBJECT_SELF)));
 DelayCommand(3.9,AssignCommand(oLondro,JumpToLocation(lLoc)));
 DelayCommand(9.0, SetLocalInt(OBJECT_SELF,"nNoTalk",0));
 DelayCommand(12.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSleep(),OBJECT_SELF,300.0));
}


