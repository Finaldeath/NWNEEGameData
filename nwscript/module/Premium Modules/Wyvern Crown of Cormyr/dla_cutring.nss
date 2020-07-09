// January 2006
// B W-Husey
// This cutscene starts the ring dialogues and cameras
#include "cu_cutscenes"
#include "cu_cameras"
#include "cu_functions"

void ActionCreate(string sResRef,location lLoc,int nTrue,string sTag) //turn the create command into an action so we can delay it
{
    CreateObject(OBJECT_TYPE_CREATURE,sResRef,lLoc,nTrue,sTag);
}

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsDefPC(oPC))
    {
    object oJonas = GetNearestObjectByTag("Jonas");
    FadeToBlack(oPC);
    // debug line *************************
//    DelayCommand(12.0,SetCutsceneMode(oPC,FALSE)); //To stop us getting stuck. Remove when done.

    //Section finds a second henchman if there is one.
    object oCheck = ReturnHenchman(oPC,1);
    object oHench;
    if (oCheck !=oJonas && oCheck !=OBJECT_INVALID)
        oHench = oCheck;
    else if (ReturnHenchman(oPC,2)!=oJonas && ReturnHenchman(oPC,2)!=OBJECT_INVALID)
        oHench = ReturnHenchman(oPC,2);
    else
        oHench = OBJECT_INVALID;

    AllParty("nManthiaPlot1",oPC,4);
    ClearForCut(oPC); // Function does all the cleaning up needed before the cutscene starts
    AssignCommand(oPC,ClearAllActions(TRUE));
    SetCutsceneMode(oPC,TRUE);
    DelayCommand(2.0,AssignCommand(oJonas,JumpToObject(GetWaypointByTag("TP_CutJRing"))));
    DelayCommand(2.0,AssignCommand(oHench,JumpToObject(GetWaypointByTag("TP_CutHRing"))));
    DelayCommand(3.0,AssignCommand(oPC,JumpToObject(GetWaypointByTag("TP_CutRing"))));
    DestroyObject(OBJECT_SELF,4.0);
    }
}
