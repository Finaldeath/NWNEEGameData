//Bill Harper 2020 March 05
// Another missing script. Took my best guess from available data.


#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_blackr");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_blackr20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_blackr20", TRUE);

        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_BLACKR", 20);
        AddJournalQuestEntry("a2_blackr", 20, oPC);

    }
}
