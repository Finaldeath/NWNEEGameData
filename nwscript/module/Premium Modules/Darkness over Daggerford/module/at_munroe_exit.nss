void main()
{
    object oNPC;
    object oPC = GetPCSpeaker();
    oNPC = GetNearestObjectByTag("db_jethromunroe", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_fang", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_sossimunroe", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_methromunroe", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_yagemunroe", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
}
