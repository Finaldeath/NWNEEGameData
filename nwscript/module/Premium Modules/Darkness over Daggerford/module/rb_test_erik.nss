void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("a2_pm_impchest", oPC);

    if(GetLocalInt(oPC, "pm_metericthefin") > 0)
     {
        AddJournalQuestEntry("j42",3,oPC);
     }
     else
     {
        AddJournalQuestEntry("j42",2,oPC);
    }
}
