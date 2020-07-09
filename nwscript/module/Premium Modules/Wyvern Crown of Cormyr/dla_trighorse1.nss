//::///////////////////////////////////////////////
//:: dla_trighorse1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Offers PC the option to use their horse
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: June 2003
//:://////////////////////////////////////////////

#include "cu_functions"
void DelayConv(string sConv, object oPC)
{
    BeginConversation ("horseuse1",oPC);
}

void main()
{

    object oPC = GetEnteringObject();

    if(GetIsDefPC(oPC) && DLA_GetNumHorsesOwned(oPC)>0)
    {
        AssignCommand(oPC,ClearAllActions(TRUE));
        DelayCommand(0.1,DelayConv ("horseuse1",oPC));
    }
}
