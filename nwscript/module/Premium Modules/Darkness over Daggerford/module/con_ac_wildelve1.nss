//::///////////////////////////////////////////////
//:: FileName con_ac_wildelve1
//:: Set player to be on wild elves quest for Frederick.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_wildelves_quest", 1);
    AddJournalQuestEntry("j56", 1, oPC);
}
