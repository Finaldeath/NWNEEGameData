void main()
{
object oArea = GetArea(OBJECT_SELF);
object oPC = GetFirstPC();
if (GetLocalInt(GetModule(),"pm_taygen_bandits") &&
    (GetLocalInt(oArea,"Encounter_Finished") == 0) )
      {
       object oZhent = GetObjectByTag("pm_raider_fgtr",0);
       object oCreature = GetFirstFactionMember(oZhent,FALSE);

       if (!GetIsObjectValid(oCreature))
        {
         //Set the plot flag here
         //FloatingTextStringOnCreature("Damian's plot flag will be set here :-)",GetFirstPC());
         if (GetLocalInt(GetModule(),"pm_camp") == 1)
             {
             //FloatingTextStringOnCreature("Damian's plot flag will be set here :-)",GetFirstPC());
             SetLocalInt(GetModule(),"teygan_bandits",1);
             AddJournalQuestEntry("j8",2,oPC);
             }
         else
             SetLocalInt(GetModule(),"pm_camp",1);
         //SendMessageToPC( GetFirstPC(), "Damian's plot flag will be set here :-)" );
         SetLocalInt(oArea, "Encounter_Finished", 1);
         }

      }
}
