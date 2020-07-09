//prisoners run for the exit
//Author: Damian Brown (Luspr)
//Date: 16-Aug-2005
void main()
{
    object oNPC;
    object oPC = GetPCSpeaker();
    //flag plot as complete
    SetLocalInt(GetModule(),"dropoffquest", 1);
    //prisoners run off
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
    oNPC = GetNearestObjectByTag("db_prisoner", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_prisoner001", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_prisoner002", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_prisoner003", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_prisoner004", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_prisoner005", oPC);
    ExecuteScript("hf_cs_exit", oNPC);
}
