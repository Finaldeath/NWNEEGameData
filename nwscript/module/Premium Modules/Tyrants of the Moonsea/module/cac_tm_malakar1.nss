//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_malakar1
// DATE: October 30, 2005
// AUTH: Luke Scull
// NOTE: Update journal, causes all Zhents to flee and
//       be destroyed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oZhent1 = GetNearestObjectByTag("NeutralZhentarimFighter1");
    object oZhent2 = GetNearestObjectByTag("NeutralZhentarimFighter2");
    object oZhent3 = GetNearestObjectByTag("NeutralZhentarimMage");

    AddJournalQuestEntry("OrderoftheCrippledFang", 17, GetPCSpeaker());

    ExecuteScript("hf_cs_exit", OBJECT_SELF);
    ExecuteScript("hf_cs_exit", oZhent1);
    ExecuteScript("hf_cs_exit", oZhent2);
    ExecuteScript("hf_cs_exit", oZhent3);
}
