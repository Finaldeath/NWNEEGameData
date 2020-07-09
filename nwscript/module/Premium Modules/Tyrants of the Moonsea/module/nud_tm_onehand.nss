//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nud_tm_onehand
// DATE: March 23, 2006
// AUTH: Luke Scull
// NOTE: Onehand surrenders when reduced to 1 hp and
//       cutscene starts.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    // Define PC and Min/Max HP
    object oPC = GetFirstPC();
    int nMaxHP = GetMaxHitPoints();
    int nCurrHP = GetCurrentHitPoints();

    // Fires when Kalor is on 1hp
    if((nCurrHP * 204) <= nMaxHP && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        // Surrender
        SetLocalInt(OBJECT_SELF, "fired", 1);
        SurrenderToEnemies();

        SetLocalInt(GetFirstPC(), "onehandbeaten", 1);

        // Fires cutscene script
        CutscenePlay(oPC, "cut_tm_arena5b");
    }
}
