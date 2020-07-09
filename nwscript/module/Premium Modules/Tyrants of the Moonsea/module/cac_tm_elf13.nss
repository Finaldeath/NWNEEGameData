//Elf agrees to join assault on Kur-Tharsu and exits

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    //Set Plot flag according to whether Tusk has been met.
    //If Tusk met, Elf will wait in Kur-Tharsu, otherwise in the Scarred Lands
    if(PlotLevelGet("Tusk") == 1)
    {
        PlotLevelSet(GetTag(OBJECT_SELF), 15);
    }
    else
    {
        PlotLevelSet(GetTag(OBJECT_SELF), 13);
    }

    //Update journal if Kur-Tharsu not yet entered
    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRYTharAllies") < 50)
    {
        AddJournalQuestEntry("TharAllies", 30, oPC, FALSE, FALSE, TRUE);
    }

    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_MEAW_ELF_EXIT");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
