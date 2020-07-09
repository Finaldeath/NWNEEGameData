//::///////////////////////////////////////////////
//:: FileName con_ac_plagueq3
//:: Dax runs off and set appropriate variable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_plague_quest", 3);
    ActivateFleeToExit();
    GiveGoldToCreature(oPC, 100);

}
