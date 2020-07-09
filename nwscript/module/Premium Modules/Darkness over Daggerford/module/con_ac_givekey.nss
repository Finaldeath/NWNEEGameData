//::///////////////////////////////////////////////
//:: FileName con_ac_marinerfl
//:: Mariner guard gives player key
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    CreateItemOnObject("key_c1ar0302", oPC);
    SetLocalInt(OBJECT_SELF,"ac_taffy_opendoor",1);
}
