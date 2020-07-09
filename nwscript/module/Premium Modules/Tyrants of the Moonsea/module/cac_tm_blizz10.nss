//Blizzard agrees to join assault on Kur-Tharsu and exits

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Blizzard", 10);

    //Update journal if Kur-Tharsu not yet entered
    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRYTharAllies") < 50)
    {
        AddJournalQuestEntry("TharAllies", 20, oPC, FALSE, FALSE, TRUE);
    }

    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_MEBWI_BLIZZARD_EXIT");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
