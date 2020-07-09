//::///////////////////////////////////////////////
//:: Name od_ac_bleader
//:: Sets Cheese variable on death.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: Dec. 10, 2005
//:://////////////////////////////////////////////

void main()
{

    object oPC = GetLastKiller();
    SetLocalInt(oPC,"ac_cheese_qst",2);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    AddJournalQuestEntry("j54",6,GetPCSpeaker());
}
