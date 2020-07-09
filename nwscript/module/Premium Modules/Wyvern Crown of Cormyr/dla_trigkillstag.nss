// January 2006
// B W-Husey
// Remove the White Stag and update journal.
#include "cu_functions"

void main()
{
    object oStag = GetEnteringObject();

    if(GetTag(oStag)=="WhiteStag")
    {
        object oPC = GetFirstPC();
        FloatingTextStringOnCreature("The stag escapes into the forest...",oPC, TRUE);
        if (GetLocalInt(oPC,"nWStag")==1)
        {
            AddJournalQuestEntry("WStag",65,oPC);
            AllParty("nWStag",oPC,2);
        }
        DestroyObject(oStag);
        DestroyObject(OBJECT_SELF,5.5);
        DelayCommand(5.0,MusicBattleChange(GetArea(oStag),60)); //change track
    }
}
