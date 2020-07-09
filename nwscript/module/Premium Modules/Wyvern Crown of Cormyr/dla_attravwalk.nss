// October 2005
// B W-Husey
// Transition PC to preset destination tag of current 'talking' trigger.

void main()
{
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    AssignCommand(GetPCSpeaker(),JumpToObject(oTarget));
}
