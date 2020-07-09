void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "pm_klevtormet", 1);
    CreateItemOnObject("pm_fernigoldberr", oPC);
    CreateItemOnObject("pm_badgerheart", oPC);
    CreateItemOnObject("x2_it_cmat_bone", oPC);

    AssignCommand(oPC, ActionJumpToObject(GetWaypointByTag("wp_c1ar1402_c1ar1400_exit")));
}
