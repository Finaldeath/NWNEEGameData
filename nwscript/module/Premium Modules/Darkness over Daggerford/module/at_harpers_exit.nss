void main()
{
    object oNPC;
    object oPC = GetPCSpeaker();
    oNPC = GetNearestObjectByTag("db_meyhew", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_drelia", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_brenda", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    // int set for cave transition
    SetLocalInt(GetModule(), "teygan_start", 4);
}
