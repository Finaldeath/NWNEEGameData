//::///////////////////////////////////////////////
//:: FileName con_ac_cheestst
//:: Set player to have tasted one of the Churlgo Cheese samples.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/10/2005 4:47:28 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_taste_cheese", 1);
AddJournalQuestEntry("j54",3,GetPCSpeaker());
}
