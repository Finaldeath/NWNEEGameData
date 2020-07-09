// dla_d1_tothefarm
// Syrsnein. May 2006
// Sends Henchmen to the farm area, with suitable camera movements
// Modified 15th May, B W-Husey to call the invalid name script

#include "cu_functions"
#include "dla_i0_csintro"
#include "dla_i0_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsDefPC(oPC)) return;
    object oJonas = OBJECT_SELF;
    object oGodfroy = GetObjectByTag(CS_Godfroy);
    object oExit = GetObjectByTag(CS_WPExitCS);

    DelayCommand(0.5, AssignCommand(oJonas, ActionMoveToObject(oExit, TRUE)));
    DelayCommand(1.5, AssignCommand(oGodfroy, ActionMoveToObject(oExit, TRUE)));
    DelayCommand(2.0, Pan(GetFacing(oJonas), 10.0, 55.0, FAST));
    DelayCommand(2.5, AssignCommand(oPC, TurnToFaceObject(oExit)));
    DelayCommand(4.0, EndCutscene(GetFacing(oPC), 10.0, 55.0));
}
