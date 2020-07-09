#include "ddf_util"

void main()
{
    debug("-- setup first nightmare.");
    debug("*** ULAN DEAD ***");

    SetLocalInt(GetModule(), "ddf_aladara_dead", TRUE);
    SetLocalInt(GetModule(), "ddf_ulan_dead", TRUE);

    int i;

    for(i = 0; i < 5; i++)
    {
        if(GetCurrentDay() < 4) IncrementDay();
    }

    SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);

    /*
    int nDay = 4;//GetCurrentDay();
    object oPC = GetFirstPC();

    // Nightmare related script
    object oLocation = GetObjectByTag("ddf_SpawnPoint_FirstNightmare01");
    if(nDay == 5) oLocation = GetObjectByTag("ddf_SpawnPoint_SecondNightmare01");

    MovePartyToObject(oPC, oLocation, TRUE, TRUE);
    */
}
