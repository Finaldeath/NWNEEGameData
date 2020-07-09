void main()
{
     object oPC = GetPCSpeaker();
     AssignCommand(GetNearestObjectByTag("pm_impchest",oPC),SetIsDestroyable(TRUE));
     DestroyObject(GetNearestObjectByTag("pm_impchest",oPC));
     CreateItemOnObject("a2_pm_impchest", oPC, 1);

     if(GetLocalInt(oPC, "pm_metericthefin") > 0)
     {
        AddJournalQuestEntry("j42",3,oPC);
     }
     else
     {
        AddJournalQuestEntry("j42",2,oPC);
    }
}
