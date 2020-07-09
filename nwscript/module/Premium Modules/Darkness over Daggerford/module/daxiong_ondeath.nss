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
    SetLocalInt(GetFirstPC(),"ac_plague_quest",2);
    AddJournalQuestEntry("j52", 5, GetFirstPC());
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
