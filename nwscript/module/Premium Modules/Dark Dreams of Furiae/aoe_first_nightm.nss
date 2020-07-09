#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_FIRST_NIGHTMARE);
     SetCurrentArea(oPC, AREA_FIRST_NIGHTMARE);


    if(GetLocalInt(GetModule(), "ddf_aladara_dead") == FALSE)
    {
        // Remove her from the AREA.
        object oAladara = GetObjectByTag("DDF_NPC_AladaraExplode");
        if(GetIsObjectValid(oAladara) == FALSE)
        {
            debug("Unable to find aladara in first nightmare...");
        }
        else
        {
            debug("Removing Aladara, as she is still alive...");
            DestroyObject(oAladara, 0.0);
        }

    }
    else
    {
        debug("Aladara is dead, leaving her in area.");
    }


    if(GetLocalInt(GetModule(), "ddf_ulan_dead") == FALSE && GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE)
    {
        // Remove him from the AREA
        object oUlan = GetObjectByTag("DDF_NPC_Ulan_FN");
        if(GetIsObjectValid(oUlan) == FALSE)
        {
            debug("Unable to find Ulan in first nightmare...");
        }
        else
        {
            debug("Removing Ulan, as he is still alive...");
            DestroyObject(oUlan, 0.0);
        }
    }
    else
    {
        debug("Ulan is dead, leaving him in area.");
    }

}
