//February 2006
// B W-Husey
// This cutscene handles seeing the burning farm and the dead bodies, then launching the starting dialogue.

#include "cu_functions"
#include "cu_cameras"
#include "cu_cutscenes"

void main()
{
    object oPC = GetEnteringObject();
    object oJonas = GetNearestObjectByTag("Jonas");
    object oGodfroy = GetNearestObjectByTag("Godfroy");
    if (GetIsDefPC(oPC))
    {
    WCCameraMove(0.0,180.0,15.0,65.0,180.0,15.0,65.0,1.0,150.0,oPC,1);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,DLA_RemoveHenchman(oPC,oJonas));
    AssignCommand(oPC,DLA_RemoveHenchman(oPC,oGodfroy));
//    DelayCommand(2.0,ExecuteScript("dla_trigcut3",oPC));
    DelayCommand(0.5,ExecuteScript("dla_trigcut3",oPC));
    DestroyObject(OBJECT_SELF,3.0);
    }
}
