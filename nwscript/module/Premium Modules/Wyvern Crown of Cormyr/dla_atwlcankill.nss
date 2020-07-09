//Polter's Witch Lord can now be killed.
#include "cu_functions"
void main()
{
    SetImmortal(OBJECT_SELF,FALSE);
    AllParty("nWitchDead",GetPCSpeaker(),1);
    DelayCommand(0.1,SetPlotFlag(OBJECT_SELF,FALSE));
    DelayCommand(0.2,SetLocalInt(OBJECT_SELF,"nSurrendered",1));//don't keep surrendering
    DelayCommand(0.3,SetIsDestroyable(TRUE,FALSE));
}
