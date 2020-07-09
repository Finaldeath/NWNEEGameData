//::///////////////////////////////////////////////
//:: FileName con_ac_flee
//:: NPC speaker runs off
//:: Don't forget to set flag on NPC
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/30/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    SetLocalInt(OBJECT_SELF, "no_banter", 1);
    ActivateFleeToExit();
}
