//a3_door_closer
//To be placed on the onopened event of a door
//This will close the doors after 10 seconds
//
//Author Phil Mitchell (Baron of Gateford)
void main()
{
 object oPC = GetLastOpenedBy();
 if (!GetIsPC(oPC)) return;
 object oTarget;
 oTarget = OBJECT_SELF;
 DelayCommand(10.0,AssignCommand(oTarget, ActionCloseDoor(oTarget)));
}

