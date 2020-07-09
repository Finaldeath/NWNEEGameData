//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_magicglm
// DATE: March 18, 2006
// AUTH: Luke Scull
// NOTE: Start cutscene upon death.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetFirstPC();

    CutscenePlay(oPC, "cut_tm_arena3b");

    // Drizzle Dialog, questions about golen/Blizzard not available anymore
    SetLocalInt(oPC, "magicgolem_defeated", 1);
    SetLocalInt(GetObjectByTag("DrizzletheAlchemist"), "potions", 0);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

