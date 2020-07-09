// March 2006
// B W-Husey
// When the PC enters the trigger, Jonas fires starting conversation

#include "cu_functions"
#include "cu_cameras"
#include "cu_cutscenes"

void main()
{
    object oJonas = GetNearestObjectByTag("Jonas");
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsDefPC(oPC))
    {
    if (GetTag(oArea)=="Start") SetLocalInt(oArea,"sOff",0); //stops the NPCs doing animations
    float fDelay;
    AssignCommand(oPC,SetCameraFacing(90.0));
    WCCameraStop(oPC);
    AssignCommand(oJonas,ClearAllActions());
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionStartConversation(oPC,"start",FALSE,FALSE)));
    DestroyObject(OBJECT_SELF,0.5);
    }
}
