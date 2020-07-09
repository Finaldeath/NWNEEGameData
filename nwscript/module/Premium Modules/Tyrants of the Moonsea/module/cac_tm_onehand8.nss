//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_onehand8
// DATE: February 27, 2006
// AUTH: Luke Scull
// NOTE: Update journal and set int so that the Inn-
//       -ovator of Pain's dialogue updates, then
//       move Onehand and destroy.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("TheCityofHillsfar", 40, oPC);

    SetLocalInt(oPC, "onehandarena", 1);

    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
