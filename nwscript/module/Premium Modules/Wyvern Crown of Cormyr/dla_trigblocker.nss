// B W-Husey
// Prevents the PC from crossing this trigger, by jumping them backwards to the nearby waypoint.

void ClearEnter(object oPC,object oTarget)
{

    AssignCommand(oPC,JumpToObject(oTarget));
    AssignCommand(oPC, ActionDoCommand(SetCommandable(TRUE)));
    AssignCommand(oPC, SetCommandable(FALSE));
}


void main()
{
    object oPC = GetEnteringObject();
    object oTarget = GetNearestObjectByTag("WP_Blocked");
    if (GetLocalInt(OBJECT_SELF,"nActive")==1)
    {
//        AssignCommand(oPC,ClearAllActions());
          ClearEnter(oPC,oTarget);
    }
}

