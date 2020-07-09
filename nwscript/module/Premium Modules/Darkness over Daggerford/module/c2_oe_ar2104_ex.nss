#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object o = GetEnteringObject();
    if (GetTag(o) == "ks_umgatlik")
    {
        object oPC = GetFirstPC();
        object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
        AssignCommand(oVetrixia, SetIsDestroyable(TRUE, TRUE, TRUE));
        DestroyObject(oVetrixia, 0.5);
        DestroyObject(o, 0.3);
        AddJournalQuestEntry("j80", 7, oPC);
        GiveQuestXPToCreature(oPC, "j80");
        PlotLevelSet("ks_umgatlik", 5);
        SetLocalInt(GetModule(), "StrongholdQuest_cleric", 0);
    }
    if (GetTag(o) == "ks_gumbril")
    {
        DestroyObject(o);
    }
    if (GetTag(o) == "ks_jared")
    {
        DestroyObject(o);
    }
}
