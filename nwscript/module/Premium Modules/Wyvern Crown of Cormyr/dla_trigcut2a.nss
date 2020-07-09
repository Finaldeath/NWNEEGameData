// January 2006
// B W-Husey
// When the PC enters the trigger, Jonas must go to the chest, get the ring,
// WL then appears and initiates conversation. Jonas will kill any companions, then run off.

#include "cu_functions"
#include "cu_cameras"
#include "cu_cutscenes"

void ObjectKill(object oSelf)
{
    SetPlotFlag(oSelf,FALSE);
    AssignCommand(oSelf,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oSelf,0.1);
}

void main()
{
    object oJonas = GetNearestObjectByTag("Jonas");
    object oChest = GetNearestObjectByTag("HFBCPlotChest");
    object oPC = GetEnteringObject();
    object oRing = GetObjectByTag("TheWitchRing");
    location lLoc = GetLocation (GetWaypointByTag("WP_WLAppear"));
    location lLoc2 = GetLocation (GetWaypointByTag("TP_CutJRing2"));
    object oExit = GetWaypointByTag("WP_JonasKill");
    object oArea = GetArea(oPC);
    SetLocalInt(oJonas,"nManthiaPlot1",4); //Set status of raids quest to cleaned out barrow

    if (GetIsDefPC(oPC))
    {
    DelayCommand(1.0,FadeFromBlack(oPC));
    // Find any other henchman.
    object oCheck = ReturnHenchman(oPC,1);
    object oHench;
    if (oCheck !=oJonas && oCheck !=OBJECT_INVALID)
        oHench = oCheck;
    else if (ReturnHenchman(oPC,2)!=oJonas && ReturnHenchman(oPC,2)!=OBJECT_INVALID)
        oHench = ReturnHenchman(oPC,2);
    else
        oHench = OBJECT_INVALID;
    //**************Journal entry dependant on whether/who the other henchman is
    if (GetIsObjectValid(oHench))
    {
        SetCustomToken(1026,GetName(oHench));
        AddJournalQuestEntry("QRing",11,oPC);
        SetPlotFlag(oHench,TRUE);
    }
    else AddJournalQuestEntry("QRing",10,oPC);

    //**************Debug line*************
    //SendMessageToPC(oPC,"Fired cut");

    //set token
        if (GetGender(oPC)==GENDER_MALE)        SetCustomToken(1054,"brother");
        else        SetCustomToken(1054,"sister");
    //set the music changes & camera start
    MusicBackgroundChangeDay(oArea,16);
    MusicBackgroundChangeNight(oArea,16);

    AssignCommand(oPC,SetCameraFacing(90.0));
    WCCameraStop(oPC);

    //Set up variables
    float fDelay = 0.0;
    effect eKill = EffectVisualEffect(496);
    effect eAppear = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eDrain = EffectVisualEffect(VFX_IMP_DEATH);
    effect eDam = EffectDamage(500);
    effect eLeave = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);

    WCCameraMove(3.0, 90.0, 15.0, 50.0, 40.0, 8.0, 65.0, 4.0, 100.0, oPC, 1);
    //Early movements  - Jonas goes to chest and gets the ring
    DelayCommand(fDelay,AssignCommand(oJonas,ClearAllActions()));
    DelayCommand(fDelay+=1.0,AssignCommand(oJonas,ActionForceMoveToObject(oChest,FALSE,1.0,4.9)));
    DelayCommand(fDelay+=5.0,AssignCommand(oJonas,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.5)));
    DelayCommand(fDelay+=0.1,AssignCommand(oChest,ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN,1.0,2.0)));
    DelayCommand(fDelay+=3.0,AssignCommand(oJonas,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,SpeakOneLinerConversation("ring1")));
    DelayCommand(fDelay+=3.0,AssignCommand(oJonas,ClearAllActions()));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.5)));
    DelayCommand(fDelay+=1.1,AssignCommand(oJonas,ActionTakeItem(oRing,oChest)));
    SetPlotFlag(oRing, FALSE);
    DestroyObject(oRing,25.0); //get rid of ring just in case
    //Camera move 2
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0, 40.0, 8.0, 65.0, 130.0, 12.0, 65.0, 4.0, 100.0, oPC, 0));

    //Witch Lord appears - music change, interchange between Jonas and WL
    DelayCommand(fDelay+=0.1,MusicBackgroundChangeDay(oArea,68));
    DelayCommand(fDelay+=0.1,MusicBackgroundChangeNight(oArea,68));
    DelayCommand(fDelay+=1.0,ActionCreateCreature("witchlordghost",lLoc,"DudLord",FALSE));
    DelayCommand(fDelay+=0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc));
    DelayCommand(fDelay+=1.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("I am called. What does thou seek?")));
    DelayCommand(fDelay+=0.1,TurnToFaceObject(GetObjectByTag("DudLord"),oPC));
    if (GetIsObjectValid(oHench))     DelayCommand(fDelay+=0.1,TurnToFaceObject(GetObjectByTag("DudLord"),oHench));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ClearAllActions()));

    //Conversation starts here. If there is a second henchman they join in. Dialogue actions
    DelayCommand(fDelay+=1.0,AssignCommand(oJonas,ActionMoveToLocation(lLoc2,FALSE)));
    DelayCommand(fDelay+=5.1,TurnToFaceObject(GetObjectByTag("DudLord"),oJonas));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,SpeakString("I seek to avenge my wife's death. Who are you?")));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    //Camera move 3
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0, 130.0, 12.0, 65.0, 70.0, 12.0, 65.0, 4.0, 100.0, oPC,1));

    // Witch lord convinces Jonas to put on the ring
    DelayCommand(fDelay+=5.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("I am sent to aid you. Put on the ring and my power and strength will be thine.")));
    DelayCommand(fDelay+=0.1,AssignCommand(GetObjectByTag("DudLord"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    DelayCommand(fDelay+=5.1,AssignCommand(oJonas,SpeakString("It's true it is time I got to choose some treasure...")));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    DelayCommand(fDelay+=5.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("Yes. Take it. With the ring thou will be able to get the justice thou seeks.")));
    DelayCommand(fDelay+=0.1,AssignCommand(GetObjectByTag("DudLord"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    if (GetIsObjectValid(oHench))    DelayCommand(fDelay+=5.0,AssignCommand(oHench,SpeakString("Don't be a fool Jonas! Put it down!")));
    if (GetIsObjectValid(oHench))    DelayCommand(fDelay+=0.1,AssignCommand(oHench,ClearAllActions()));
    if (GetIsObjectValid(oHench))    DelayCommand(fDelay+=0.1,AssignCommand(oHench,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,4.5)));
    DelayCommand(fDelay+=5.1,AssignCommand(oJonas,SpeakString("What will the ring do for me?")));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    DelayCommand(fDelay+=5.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("With the ring on thy finger, I shall be there to guide thee to thine enemies...")));
    DelayCommand(fDelay+=0.1,AssignCommand(GetObjectByTag("DudLord"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    DelayCommand(fDelay+=4.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("...and thy blows will fall with the strength of ten, giving thee the justice thou seeks.")));
    DelayCommand(fDelay+=0.1,AssignCommand(GetObjectByTag("DudLord"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,3.5)));
    DelayCommand(fDelay+=5.1,AssignCommand(oJonas,SpeakString("Then I will take the ring to avenge my poor Lena's death...")));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,1.0)));

    //Jonas dons the ring
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ClearAllActions()));
    DelayCommand(fDelay+=2.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,1.0)));
    DelayCommand(fDelay+=0.7,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrain,oJonas));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0,4.0)));
    DelayCommand(fDelay+=0.5,AssignCommand(oJonas,SpeakString("I can feel the power...")));
    DelayCommand(fDelay+=5.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("Justice requires sacrifices... sacrifices in blood for the lives you demand.")));
    DelayCommand(fDelay+=4.1,AssignCommand(GetObjectByTag("DudLord"),SpeakString("Kill these here with thee and vengeance shall by thine!")));
    DelayCommand(fDelay+=0.1,AssignCommand(GetObjectByTag("DudLord"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,2.5)));

    //Camera move 4
    DelayCommand(fDelay+=0.1,WCCameraMove(0.0, 70.0, 12.0, 65.0, 30.0, 12.0, 65.0, 4.0, 100.0, oPC, 1));

    // Jonas kills any companion. Conversation and actions
    if (GetIsObjectValid(oHench))
    {
        DelayCommand(fDelay+=5.0,AssignCommand(oHench,SpeakString("Jonas, take off the ring! Can't you sense that creature's evil!")));
        DelayCommand(fDelay+=0.1,AssignCommand(oHench,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,4.5)));
        DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ClearAllActions()));
        DelayCommand(fDelay+=0.1,TurnToFaceObject(oHench,oJonas));
        DelayCommand(fDelay+=2.0,AssignCommand(oJonas,ActionMoveToObject(oHench,TRUE,0.8)));
        DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionEquipMostDamagingMelee()));
        DelayCommand(fDelay+=1.0,AssignCommand(oJonas,ActionAttack(oHench,TRUE)));
        DelayCommand(fDelay+=0.1,SetLocalInt(oHench,"nCanDie",1));
        DelayCommand(fDelay+=1.0,SetPlotFlag(oHench,FALSE));
        DelayCommand(fDelay+=0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,oHench));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHench));
    }

    //Jonas tries to kill PC, overcome, runs off
    DelayCommand(fDelay+=2.5,AssignCommand(oJonas,ClearAllActions(TRUE)));
    DelayCommand(fDelay+=0.1,TurnToFaceObject(oPC,oJonas));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionMoveToObject(oPC,TRUE,0.8)));
    DelayCommand(fDelay+=0.6,AssignCommand(oJonas,SpeakString("I...I can't...kill my own family!")));
    DelayCommand(fDelay+=5.1,AssignCommand(oJonas,SpeakString("Aaah, the power! I...must get...away before...it's too much...")));
    DelayCommand(fDelay+=0.1,DLA_RemoveHenchman(oPC,oJonas));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ActionMoveToObject(oExit,TRUE)));
    DelayCommand(fDelay+=0.1,WCCameraTrack(0.0,oJonas,12.0,65.0,15.0,65.0,3.0,100.0,oPC,1));
    DelayCommand(fDelay+=3.0,WCCameraTrack(0.0,GetObjectByTag("DudLord"),15.0,65.0,6.0,65.0,6.0,100.0,oPC,1));
    DelayCommand(fDelay+=2.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLeave,GetObjectByTag("DudLord")));
    DelayCommand(fDelay+=1.1,AssignCommand(oPC,ObjectKill(GetObjectByTag("DudLord"))));
    DelayCommand(fDelay+=0.1,ExecuteScript("dla_misclootbag",oHench));
    DelayCommand(fDelay+=0.1,AssignCommand(oJonas,ObjectKill(OBJECT_SELF)));
    DelayCommand(fDelay+=0.1,MusicBackgroundChangeDay(oArea,81));
    DelayCommand(fDelay+=0.1,MusicBackgroundChangeNight(oArea,81));

    //if a henchman died, PC goes and kneels over them
    if (GetIsObjectValid(oHench))
    {
        DelayCommand(fDelay+=0.1,AssignCommand(oPC,ActionMoveToObject(oHench,TRUE,0.7)));
        DelayCommand(fDelay+=1.1,AssignCommand(oPC,TurnToFaceObject(oHench,oPC)));
        DelayCommand(fDelay+=0.4,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,3.0)));
    }
    DelayCommand(fDelay+=2.0,SetCutsceneMode(oPC,FALSE));

    AllParty("nManthiaPlot1",oPC,4);
    AllParty("nQRing",oPC,1);
    DelayCommand(fDelay+=0.1,ObjectKill(OBJECT_SELF));
    }
}

