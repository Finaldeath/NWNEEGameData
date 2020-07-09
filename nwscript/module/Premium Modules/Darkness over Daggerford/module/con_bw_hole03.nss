void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetObjectByTag("wp_ar0807_entry");
    location lWP = GetLocation(oWP);

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lWP));
}
