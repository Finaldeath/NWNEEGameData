//::///////////////////////////////////////////////
//:: FileName con_ac_g_killmaz
//:: Set player talked to Gravia after killed them in the maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(OBJECT_SELF, "ac_kill_maze", 1);
GiveXPToCreature(GetPCSpeaker(),750);
}
