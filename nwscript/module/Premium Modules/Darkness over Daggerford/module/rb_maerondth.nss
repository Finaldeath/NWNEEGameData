//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetFirstPC();
    // check for journal update
    string sJournal = "j59"; // relevant quest
    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);

    int iState = GetLocalInt(oPC, sJournalVar);

    //Conclude Miller quest if you are at a stage where you'd speak to Maerovyna
    if(iState == 6)
    {
        AddJournalQuestEntry("j59", 10, oPC);
    }
    else
    if(iState == 7)
    {
        AddJournalQuestEntry("j59", 11, oPC);
    }

    //Update Xatuum entry
    AddJournalQuestEntry("j95", 30, oPC);

    SetLocalInt(GetModule(), "iMaerovynaDead", 1);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
