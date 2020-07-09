void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    FloatingTextStringOnCreature("... Tracking ...", oPC);
    DelayCommand(2.1, ActionStartConversation(oPC));
}
