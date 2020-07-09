// player sends "rex" to the gates of kur-tharsu

#include "hf_in_plot"

void exitRex(object oNPC)
{
    if (GetIsObjectValid(oNPC))
    {
        SetLocalString(oNPC, "HF_EXIT_NAME", "WP_MEPP_REX_EXIT");
        ExecuteScript("hf_cs_exit", oNPC);
    }
}


void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("HighArtificerHlessen", 5);
    PlotLevelSet("TheWrecker", 1);

    //Update journal if Kur-Tharsu not yet entered
    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRYTharAllies") < 50)
    {
        AddJournalQuestEntry("TharAllies", 40, oPC, FALSE, FALSE, TRUE);
    }

    object oRex = GetNearestObjectByTag("TheWrecker");
    if (GetIsObjectValid(oRex))
    {
        exitRex(oRex);
    }
}
