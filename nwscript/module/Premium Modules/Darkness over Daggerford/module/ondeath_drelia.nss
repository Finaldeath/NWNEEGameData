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
    SetLocalInt(GetModule(),"drelia_dead",1);
    object oPC = GetFirstPC();
    if(GetLocalInt(GetModule(), "teygan_start") < 4)
    {
        AddJournalQuestEntry("j10", 2, oPC);
    }
    else
    {
        AddJournalQuestEntry("j10", 11, oPC);
    }
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
