// onEnter event for area 1500 (Wild Pastures)

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // run standard spawns
        SpawnEnter(oPC);
    }

   if(GetIsPC(oPC)&&GetLocalInt(GetModule(),"area_trans_popup")==1)
   {
    SetLocalInt(GetModule(),"area_trans_popup",0);
    DelayCommand(4.0,AssignCommand(oPC,SpeakString
    ("The forest is dense and many times you fear that you have lost your way.")));
   }
}
