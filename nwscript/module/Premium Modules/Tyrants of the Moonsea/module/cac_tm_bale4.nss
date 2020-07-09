// bale and his noble friends exit the beacon inn; look for them in the nearby ruins

#include "hf_in_plot"

void exit(object oNPC)
{
    if (GetIsObjectValid(oNPC))
    {
        SetLocalInt(oNPC, "HF_EXIT_RUN", 1);
        SetLocalString(oNPC, "HF_EXIT_NAME", "WP_THBI_EXIT");
        ExecuteScript("hf_cs_exit", oNPC);
    }
}

void ForceCharacterToExit(string sTag, object oPC)
{
    int n = 1;
    object oNoble = GetNearestObjectByTag(sTag, oPC, n);
    while (GetIsObjectValid(oNoble))
    {
        exit(oNoble);
        oNoble = GetNearestObjectByTag(sTag, oPC, ++n);
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("Bale", 4);
    PlotLevelSet("Gideon", 3);
    PlotLevelSet("Beirmoura", 2);
    AddJournalQuestEntry("ThentiasResistanceArmy", 40, oPC);

    exit(OBJECT_SELF);
    DelayCommand(0.5f, ForceCharacterToExit("ResistanceArmyNobleMale", oPC));
    DelayCommand(0.6f, ForceCharacterToExit("ResistanceArmyNobleFemale", oPC));
    DelayCommand(0.7f, ForceCharacterToExit("ResistanceArmyNobleOther", oPC));
}
