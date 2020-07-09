#include "ddf_journal"

void DebugNightmareTwo();

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("-- Debug Nightmare Journal");

    IncrementDay();
    IncrementDay();
    IncrementDay();
    IncrementDay();

    UpdateJournal(oPC);

    DelayCommand(30.0, DebugNightmareTwo());
}

void DebugNightmareTwo()
{
    SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_COMPLETE);
    UpdateJournal(GetFirstPC());
}
