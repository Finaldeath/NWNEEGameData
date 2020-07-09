//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nud_tm_bron
// DATE: August 31, 2005
// AUTH: Luke Scull/ Attila Gyoerkoes
// NOTE: Bron surrenders when reduced to 1 hp and
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

    // Fires when Bron is on 1hp
    if((nCurrHP * 99) <= nMaxHP && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        // Surrender
        SetLocalInt(OBJECT_SELF, "fired", 1);
        SurrenderToEnemies();

        SetLocalInt(GetFirstPC(), "bronbeaten", 1);

        // Fires cutscene script
        CutscenePlay(oPC, "cut_tm_voonrun");
    }
}
