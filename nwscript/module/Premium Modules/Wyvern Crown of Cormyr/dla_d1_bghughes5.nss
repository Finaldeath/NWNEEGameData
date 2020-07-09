void main()
{
    object oPC = GetPCSpeaker();
    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, JumpToLocation(GetStartingLocation()));
}
