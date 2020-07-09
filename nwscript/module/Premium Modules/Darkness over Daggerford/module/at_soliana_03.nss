// soliana and griswald leave the castle together

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    // give the final journal update
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j85", 11, oPC);
    GiveQuestXPToCreature(oPC, "j85");
    SetLocalInt(GetModule(), "StrongholdQuest_fighter", 0);

    // griswald and soliana walk away
    object oSoliana = OBJECT_SELF;
    SetLocalString(oSoliana,  "HF_EXIT_NAME", "WP_AR2003_SOLIANA_EXIT");
    ExecuteScript("hf_cs_exit", oSoliana);
    object oGriswald = GetObjectByTag("ks_griswald");
    PlotLevelSet("ks_griswald", 6);
    SetLocalString(oGriswald, "HF_EXIT_NAME", "WP_AR2003_SOLIANA_EXIT");
    ExecuteScript("hf_cs_exit", oGriswald);

    // griswald's knights leave too
    int i = 0;
    object oKnight = GetObjectByTag("ks_gris_knight", i);
    while (GetIsObjectValid(oKnight))
    {
        DestroyObject(oKnight);
        oKnight = GetObjectByTag("ks_gris_knight", ++i);
    }
}
