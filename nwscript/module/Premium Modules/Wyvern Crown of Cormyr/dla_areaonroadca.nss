//::///////////////////////////////////////////////
//:: dla_areaonroad
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    OnEnter script of area "On the Road: Caravan Duty"

    Rolls the clock forward to 6am for the sunrise
    and triggers Salvatori to speak
*/
//:://////////////////////////////////////////////
//:: Created By: Ben W-Husey
//:: Created On: January, 2006
//:://////////////////////////////////////////////

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //Get of the one time event was already fired
    int nOnce = GetLocalInt(OBJECT_SELF,"nFired");

    if (GetIsDefPC(oPC) && nOnce<1)
    {
        int nAdjust = 30-GetTimeHour();
        if (GetTimeHour()<6) SetTime(6,1,1,1);
        else  SetTime(GetTimeHour()+nAdjust,1,1,1);
        FadeFromBlack(oPC);

        //Get Salvatori Object
        object oSalv = GetObjectByTag("Salvatori2a");

        //Start Conversation with PC
        AssignCommand(oSalv,DelayCommand(2.8,ClearAllActions()));
        AssignCommand(oSalv,DelayCommand(3.0,ActionStartConversation(oPC,"salvatori2",FALSE,FALSE)));

        //Set one time event as fired
        SetLocalInt(OBJECT_SELF,"nFired",1);
    }
}
