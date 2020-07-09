//Veiti leaves the smithy, Derval int set for pre-illefarn
//but Illefarn quest active
//Author: Damian Brown (Luspr)
//Date: 06-sept-2005
void main()
{
    SetLocalInt(GetModule(),"derval_met",2);
    object oVeiti = GetObjectByTag("db_veiti_nonhenc");
    SetLocalString(oVeiti, "HF_EXIT_NAME", "EXIT_db_veiti_nonhenc");
    SetLocalInt(oVeiti, "HF_EXIT_RUN", 1);
    SetLocalInt(oVeiti, "HF_EXIT_MAX_DELAY", 7);
    ExecuteScript("hf_cs_exit", oVeiti);
    location lSpawn1 = GetLocation(GetWaypointByTag("wp_create_veiti"));
    location lSpawn2 = GetLocation(GetWaypointByTag("wp_create_magdaren"));
    oVeiti = CreateObject(OBJECT_TYPE_CREATURE,"db_veiti",lSpawn1);
    SetLocalInt(oVeiti, "HF_ARG", 1);
    CreateObject(OBJECT_TYPE_CREATURE,"db_magdaren",lSpawn2);
}
