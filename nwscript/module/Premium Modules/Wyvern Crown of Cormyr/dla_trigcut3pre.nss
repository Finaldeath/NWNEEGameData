// February 2006
// B W-Husey
// For some reason I cannot understand, SPeakString will not work, unless I fire
// the cutscene through a sequence of triggers. All this one does is walk the PC to the next one
// So that tags are picked up properyly (i.e. henchies arrive) and SpeakString works.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
        BlackScreen(oPC);
        FadeFromBlack(oPC,FADE_SPEED_MEDIUM);
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC,ActionMoveToObject(GetWaypointByTag("WP_Cut3Start")));
        DestroyObject(OBJECT_SELF,15.0);
    }
}
