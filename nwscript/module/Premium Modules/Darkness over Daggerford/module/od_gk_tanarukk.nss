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
    object oPC=GetFirstPC();
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    if(GetLocalInt(GetModule(), "hevesar_plot")==2)
    {
        //player has been briefed by hevesar
        AddJournalQuestEntry("j13", 9, oPC);
    }
    else
    {
        AddJournalQuestEntry("j13", 8, oPC);
    }
}
