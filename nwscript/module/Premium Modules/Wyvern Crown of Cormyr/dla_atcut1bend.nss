void main()
{
    object oPC = GetPCSpeaker();
    SetCutsceneMode(oPC,FALSE);
    AssignCommand(oPC,JumpToObject(GetObjectByTag("CP_Cut1End")));
    AssignCommand(oPC,RestoreCameraFacing());
}
