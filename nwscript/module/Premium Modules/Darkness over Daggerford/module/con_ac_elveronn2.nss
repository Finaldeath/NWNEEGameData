//::///////////////////////////////////////////////
//:: FileName sc_ac_elveronne2
//:: Muriel and Alicine run upstairs
//:: Don't forget to set flag on NPC
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
object oWP3 = GetWaypointByTag("wp_ac_spawnelveronne");
object oM = GetObjectByTag("ac_muriel");
object oA = GetObjectByTag("ac_alicine");
object oWPM = GetWaypointByTag("wp_ac_muriel2");
object oWPA = GetWaypointByTag("wp_ac_alicine2");
object oWP2 = GetWaypointByTag("wp_ac_downstairs2");
object oPC = GetPCSpeaker();
object oD = GetObjectByTag("C1AR0701A_C1AR0701B_EXIT");

SetLocalInt(oA,"no_banter",1);
SetLocalInt(oM,"no_banter",1);

AssignCommand(oA, ActionMoveToObject(oWP2, TRUE));
AssignCommand(oA, ActionJumpToObject(oWPA));
DelayCommand(0.2, AssignCommand(oM,ActionMoveToObject(oWP2, TRUE)));
DelayCommand(0.3, AssignCommand(oM,ActionJumpToObject(oWPM)));

SetLocalInt(GetPCSpeaker(),"elveronne_quest",2);
CreateObject(OBJECT_TYPE_CREATURE,"ac_elveronne",GetLocation(oWP3));
SetLocked(oD, FALSE);
DelayCommand(5.0,AssignCommand(oD, ActionOpenDoor(oD)));

//AssignCommand(oM,ActionDoCommand(SetCommandable(TRUE,oM)));
//AssignCommand(oM,SetCommandable(FALSE,oM));
//AssignCommand(oA,ActionDoCommand(SetCommandable(TRUE,oA)));
//AssignCommand(oA,SetCommandable(FALSE,oA));
SoundObjectStop(GetObjectByTag("ac_snd_nobles"));
SoundObjectPlay(GetObjectByTag("ac_snd_nobles2"));
}

