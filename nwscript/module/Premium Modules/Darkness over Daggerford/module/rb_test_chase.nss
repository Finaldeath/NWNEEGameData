void main()
{
    object oPC = GetPCSpeaker();
    SetCutsceneMode(oPC,TRUE);
    AssignCommand(oPC, ActionJumpToObject(GetWaypointByTag("wp_maze_pc")));
    SetLocalInt(GetObjectByTag("ac_gravia"), "no_banter", 1);
    SetLocalInt(GetModule(), "ac_werewolf", 3);
    SetLocalInt(GetObjectByTag("ac_jonas1"), "iDruggedPC", 1);
}
