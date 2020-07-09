//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_merrik3
// DATE: November 2, 2005
// AUTH: Luke Scull
// NOTE: Merrik dies, Red Plumes leave area.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oRedPlume1 = GetObjectByTag("RedPlumeMercenary1");
    object oRedPlume2 = GetObjectByTag("RedPlumeMercenary2");
    object oMerrik = GetObjectByTag("Merrik");
    object oHaliator = GetObjectByTag("CaptainHaliator");

    ExecuteScript("hf_cs_exit", oRedPlume1);
    ExecuteScript("hf_cs_exit", oRedPlume2);
    ExecuteScript("hf_cs_exit", oHaliator);

    AssignCommand(oMerrik, SetIsDestroyable(TRUE, FALSE, FALSE));
    SetPlotFlag(oMerrik, FALSE);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMerrik));
}
