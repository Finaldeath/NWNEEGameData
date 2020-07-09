// October 2005
// B W-Husey
// This cutscene releases the messenger bird and brings Hawklin's reply
#include "cu_cutscenes"


void ActionCreate(string sResRef,location lLoc,int nTrue,string sTag) //turn the create command into an action so we can delay it
{
    CreateObject(OBJECT_TYPE_CREATURE,sResRef,lLoc,nTrue,sTag);
}

void main()
{
    object oPC = OBJECT_SELF;
    ClearForCut(oPC); // Function does all the cleaning up needed before the cutscene starts
    DelayCommand(18.0,SetCutsceneMode(oPC,FALSE));
    DelayCommand(18.1,FloatingTextStringOnCreature("You have received a message",oPC));
    float fDelay = 1.5;
    SetCutsceneMode(oPC,TRUE);
    // Make our new messenger bird (release it), and have it fly off
    location lLoc = GetLocation(oPC);
    object oBird = CreateObject(OBJECT_TYPE_CREATURE,"messengerbird2",lLoc,FALSE,"OldBird");
    location lLoc2 = GetLocation(GetWaypointByTag("WP_HFWest"));
    DelayCommand(fDelay,AssignCommand(oBird,ActionMoveToLocation(lLoc2,TRUE)));
    DelayCommand(fDelay+=2.5,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,5.5)));
    DelayCommand(fDelay+=2.5,FadeToBlack(oPC));
    DelayCommand(fDelay+=0.5,DestroyObject(oBird));
    DelayCommand(fDelay+=2.5,FadeFromBlack(oPC));
    object oSound = GetObjectByTag("BirdNoise");
    DelayCommand(fDelay,SoundObjectPlay(oSound));
    DelayCommand(fDelay+=1.0,ActionCreate("messengerbird",lLoc,TRUE,"NewBird"));
    DelayCommand(fDelay+=0.3,AssignCommand(GetObjectByTag("NewBird"),ActionMoveAwayFromObject(oPC,FALSE,0.8)));
    DelayCommand(fDelay+=3.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0,2.0)));
    DelayCommand(fDelay+=2.0,AssignCommand(GetObjectByTag("NewBird"),ActionMoveToLocation(lLoc2,TRUE)));
    DelayCommand(fDelay+=3.0,DestroyObject(GetObjectByTag("NewBird")));
    DelayCommand(fDelay+=15.0,SoundObjectStop(oSound));
}
