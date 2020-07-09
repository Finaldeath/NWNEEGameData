#include "inc_bw_worldmap"
void main()
{
    object oPC=GetPCSpeaker();
    object oTarget = GetObjectByTag("AR1500_AR2200_EXIT");
    RevealMapLocation("C1AR1500");
    AssignCommand(oPC, ClearAllActions());
    //ActionStartConversation(oClicker,"db_ar1500_s_exit");
    MapTravel(oPC,oTarget,0,16);
    SetLocalInt(GetModule(),"area_trans_popup",1);
    //DelayCommand(4.0,AssignCommand(oClicker,SpeakString
    //("The forest is dense and many times you fear that you have lost your way."))
}
