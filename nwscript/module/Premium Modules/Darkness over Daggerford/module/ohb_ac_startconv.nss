//::///////////////////////////////////////////////
//:: ohb_ac_startconv
//:: NPC tried to start a convo on heartbeat until successful
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: November 11, 2005
//:://////////////////////////////////////////////
void main()
{
if (GetLocalInt(OBJECT_SELF,"start_convo")!=1) return;
//Nearest player to oG
object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
DelayCommand(1.0,ActionStartConversation(oPC,"at_dragsurrendr"));

}
