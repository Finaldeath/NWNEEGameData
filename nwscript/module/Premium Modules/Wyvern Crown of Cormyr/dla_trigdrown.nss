// February 2006
// B W-Husey
// PC cannot advance unless they wear a helm of the deep.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    if (GetTag(oHelm)!= "HelmoftheDeep")
    {
        if (GetIsDefPC(oPC)) FloatingTextStringOnCreature("You will likely drown if you proceed further", oPC,TRUE);
        else AssignCommand(oPC,SpeakString("I'll drown if we go further!"));
        object oTarget = GetNearestObjectByTag("WP_Blocked");
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC,JumpToObject(oTarget));
    }
}
