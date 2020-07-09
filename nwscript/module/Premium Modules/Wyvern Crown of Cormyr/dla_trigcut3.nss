//February 2006
// B W-Husey
// This cutscene handles seeing the burning farm and the dead bodies, then launching the starting dialogue.
// Actually fired from the dla_trigcutfarm script since it was being problematic from a trigger.

#include "cu_functions"
#include "cu_cameras"
#include "cu_cutscenes"

void main()
{
    object oPC = OBJECT_SELF;
    object oJonas = GetNearestObjectByTag("Jonas");
    object oGodfroy = GetNearestObjectByTag("Godfroy");
    object oLena = GetNearestObjectByTag("dLena");
    location lLoc1 = GetLocation(GetWaypointByTag("WP_Cut31"));
    location lLoc2 = GetLocation(GetWaypointByTag("WP_Cut32"));
    location lLoc1b = GetLocation(GetWaypointByTag("WP_Cut31b"));
    location lLoc2b = GetLocation(GetWaypointByTag("WP_Cut32b"));
    location lLoc3 = GetLocation(GetWaypointByTag("WP_Cut3J"));
    location lLoc4 = GetLocation(GetWaypointByTag("WP_Cut3G"));
    location lLoc5 = GetLocation(GetWaypointByTag("WP_Cut3G2"));
    location lLoc6 = GetLocation(GetWaypointByTag("WP_Cut3J2"));

    // debug line *************************
//    DelayCommand(50.0,SetCutsceneMode(oPC,FALSE)); //To stop us getting stuck. Remove when done.
    AssignCommand(oPC,SetCameraFacing(179.0));
    ClearForCut(oPC); // Function does all the cleaning up needed before the cutscene starts
    AssignCommand(oPC,ClearAllActions(TRUE));
    SetCutsceneMode(oPC,TRUE);
//    SetTime(17,45,0,0);
    float fDelay=2.0;
    DelayCommand(fDelay,AssignCommand(oPC,DLA_RemoveHenchman(oPC,ReturnHenchman(oPC,1))));
    DelayCommand(fDelay,AssignCommand(oPC,DLA_RemoveHenchman(oPC,ReturnHenchman(oPC,2))));
    DelayCommand(fDelay+=1.1,AssignCommand(oGodfroy,TurnToFaceObject(GetObjectByTag("MCormas"))));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,TurnToFaceObject(GetObjectByTag("MCormas"))));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,TurnToFaceObject(GetObjectByTag("MCormas"))));
    DelayCommand(fDelay+=0.1,TalkNormal(oGodfroy,"Oh Sweet Lathander! Just look...",2.0,TRUE));
    DelayCommand(fDelay+=0.1,TalkForce(oJonas,"Lena!",2.0,TRUE));
    DelayCommand(fDelay+=1.5,TalkForce(oGodfroy,"Mother! Father!",1.0,TRUE));
    //Camera Move 1
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0,180.0,15.0,65.0,50.0,6.0,80.0,12.0,150.0,oPC,1));

    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionMoveToLocation(lLoc1b,TRUE)));
    DelayCommand(fDelay+=2.0,AssignCommand(oGodfroy,ActionMoveToLocation(lLoc1,TRUE)));
    DelayCommand(fDelay+=2.5,AssignCommand(oPC,ActionMoveToLocation(lLoc1b,TRUE)));


    DelayCommand(fDelay+=3.1,AssignCommand(oJonas,ActionMoveToLocation(lLoc2b,TRUE)));
    DelayCommand(fDelay+=2.0,AssignCommand(oGodfroy,ActionMoveToLocation(lLoc2,TRUE)));
    DelayCommand(fDelay+=2.5,AssignCommand(oPC,ActionMoveToLocation(lLoc2,TRUE)));
    //Camera Move 2
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0,50.0,6.0,80.0,70.0,35.0,60.0,10.0,150.0,oPC,0));

//    DelayCommand(fDelay+=0.5,AssignCommand(oJonas,ActionMoveToLocation(lLoc3,TRUE)));
//    DelayCommand(fDelay+=2.0,AssignCommand(oGodfroy,ActionMoveToLocation(lLoc4,TRUE)));
    DelayCommand(fDelay+=0.5,AssignCommand(oGodfroy,ActionMoveToLocation(lLoc4,TRUE)));
    DelayCommand(fDelay+=2.0,AssignCommand(oJonas,ActionMoveToLocation(lLoc3,TRUE)));
      DelayCommand(fDelay+=0.1,AssignCommand(oPC,TurnToFaceObject(GetObjectByTag("MCormas"))));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0,5.0)));
    DelayCommand(fDelay+=3.5,AssignCommand(oJonas,TurnToFaceObject(GetObjectByTag("dLena"))));
    DelayCommand(fDelay+=0.1,AssignCommand(oLena,SpeakString("Avenge... me... Jonas...")));
    DelayCommand(fDelay+=0.1,TalkForce(oJonas,"Lena!",2.0,TRUE));
    DelayCommand(fDelay+=2.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,9.0)));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,4.0)));
    DelayCommand(fDelay+=1.5,AssignCommand(oGodfroy,TurnToFaceObject(GetObjectByTag("MCormas"))));
    DelayCommand(fDelay+=0.5,AssignCommand(oGodfroy,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,2.0)));
    DelayCommand(fDelay+=2.5,AssignCommand(oGodfroy,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,4.0)));
    DelayCommand(fDelay+=4.4,AssignCommand(oGodfroy,ClearAllActions(TRUE)));
    DelayCommand(fDelay+=0.1,AssignCommand(oGodfroy,ActionForceMoveToLocation(lLoc5,TRUE,5.6)));
    //Camera Move 3
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0,70.0,35.0,60.0,70.0,15.0,60.0,5.0,420.0,oPC,1));

    DelayCommand(fDelay+=3.1,TalkForce(oJonas,"Lena! Nooooooooo",0.1,TRUE));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,3.0)));
    DelayCommand(fDelay+=2.5,AssignCommand(oJonas,ActionMoveToLocation(lLoc6,TRUE)));
    //Camera Move 4
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0,70.0,15.0,60.0,0.0,8.0,70.0,5.0,420.0,oPC,1));

    DelayCommand(fDelay+=2.5,AssignCommand(oGodfroy,TurnToFaceObject(oPC)));
    DelayCommand(fDelay+=0.5,AssignCommand(oJonas,TurnToFaceObject(oPC)));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,StoreCameraFacing()));
    DelayCommand(fDelay+=2.5,AssignCommand(oGodfroy,ActionStartConversation(oPC,"farms",FALSE,FALSE)));
}
