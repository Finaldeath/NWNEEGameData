#include "ddf_util"

void main()
{
    debug("-- setup second nightmare.");
    //SetLocalInt(GetModule(), "ddf_aladara_dead", TRUE);
    //SetLocalInt(GetModule(), "ddf_ulan_dead", TRUE);


    int nDay = 5;//GetCurrentDay();
    object oPC = GetFirstPC();

    // Nightmare related script
    object oLocation = GetObjectByTag("ddf_SpawnPoint_FirstNightmare01");
    if(nDay == 5) oLocation = GetObjectByTag("ddf_SpawnPoint_SecondNightmare01");

    MovePartyToObject(oPC, oLocation, TRUE, TRUE);
}
