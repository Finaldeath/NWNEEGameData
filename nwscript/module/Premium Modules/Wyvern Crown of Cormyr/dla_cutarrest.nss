// October 2005
// B W-Husey
// This cutscene starts the arrest dialogues and cameras
#include "cu_cutscenes"
#include "cu_cameras"

void ActionCreate(string sResRef,location lLoc,int nTrue,string sTag) //turn the create command into an action so we can delay it
{
    CreateObject(OBJECT_TYPE_CREATURE,sResRef,lLoc,nTrue,sTag);
}

void main()
{
    object oPC = OBJECT_SELF;
    ClearForCut(oPC); // Function does all the cleaning up needed before the cutscene starts
    // debug line *************************
//    DelayCommand(12.0,SetCutsceneMode(oPC,FALSE)); //To stop us getting stuck. Remove when done.

    SetCutsceneMode(oPC,TRUE);
    JumpToObject(GetWaypointByTag("TP_CutArrest"));
}
