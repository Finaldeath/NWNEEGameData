// March 2006
// B W-Husey
// Pause conversation for knighting of the PC and do the animations
#include "cu_cameras"
#include "nw_i0_2q4luskan"
#include "cu_cutscenes"

void main()
{
    ActionPauseConversation();
    //declare variables
    object oPC = GetPCSpeaker();
    object oHawklin = OBJECT_SELF;
    location lLoc = GetLocation(GetWaypointByTag("WP_KnightMe"));
    location lLoc2 = GetLocation(GetWaypointByTag("WP_Knighting"));
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);
    float fDelay = 0.0;
    //fade to black, set up camera, set cutscene mode
//    FadeToBlack(oPC);
    DelayCommand(fDelay+=0.5,AssignCommand(oPC,SetCameraFacing(179.0)));
    SetCutsceneMode(oPC,TRUE);

    //Get actors in position
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ActionMoveToLocation(lLoc,FALSE)));
    DelayCommand(fDelay+=0.1,AssignCommand(oHawklin,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oHawklin,ActionMoveToLocation(lLoc2,FALSE)));
    DelayCommand(fDelay+=0.1,AssignCommand(oHench1,ActionMoveAwayFromLocation(lLoc,FALSE,3.0)));
    DelayCommand(fDelay+=0.1,AssignCommand(oHench2,ActionMoveAwayFromLocation(lLoc,FALSE,3.0)));

    // Change music to something triumphant (if we have it)
    DelayCommand(fDelay+=1.1,MusicBattleChange(GetArea(oPC),90));
    DelayCommand(fDelay+=0.1,MusicBattlePlay(GetArea(oPC)));

    //Unfade, start camera rolling
    DelayCommand(fDelay+=1.1,FadeFromBlack(oPC));
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0,179.0,6.0,70.0,45.0,6.0,75.0,15.0,150.0,oPC,1));

    //Get actors facing each other
    DelayCommand(fDelay+=0.1,AssignCommand(oHench1,TurnToFaceObject(oHawklin)));
    DelayCommand(fDelay+=0.1,AssignCommand(oHench2,TurnToFaceObject(oHawklin)));
    DelayCommand(fDelay+=0.1,AssignCommand(oHawklin,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oHawklin,FaceNearestPC()));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND))));
    DelayCommand(fDelay+=0.7,AssignCommand(oHawklin,FaceNearestPC()));
    DelayCommand(fDelay+=0.1,AssignCommand(oHawklin,ActionEquipMostDamagingMelee()));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oPC,SetFacingPoint(GetPosition(oHawklin))));

    //Do the animation
    DelayCommand(fDelay+=1.5,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,10.0)));
    DelayCommand(fDelay+=0.5,AssignCommand(oHawklin,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4,1.0,3.0)));
    DelayCommand(fDelay+=4.0,AssignCommand(oHawklin,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4,1.0,5.0)));
    DelayCommand(fDelay+=5.5,AssignCommand(oHawklin,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND))));

    // Return everything back to the original settings and resume conversation
    DelayCommand(fDelay+=0.1,MusicBattleStop(GetArea(oPC)));
    DelayCommand(fDelay+=0.4,ActionResumeConversation());

    DelayCommand(15.5,MusicBackgroundChangeDay(GetArea(oPC),86));
    DelayCommand(15.5,MusicBackgroundChangeNight(GetArea(oPC),86));
}

