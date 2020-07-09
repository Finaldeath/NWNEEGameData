//::///////////////////////////////////////////////
//:: FileName con_setjouka1
//:: Player is now on Jouka quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 4/9/2006 5:16:05 PM
//:://////////////////////////////////////////////

#include"inc_bw_worldmap"

void main()
{
    // Set the variables
    SetLocalInt(OBJECT_SELF, "ac_jouka_quest", 1);
    RevealMapLocation("c1ar1800");
}
