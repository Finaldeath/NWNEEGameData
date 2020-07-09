/* Dart OnClick UI

    dart_onclick.nss
    created by: Robert Faber
    date: 04/27/06

    Checks permissions to throw.  If valid, starts cutscene and fires dart
    at the dartboard.

    situations to resolve:
    Not playing = Action examine (shows rules), return
    playing but Not my turn = return
    Three darts thrown = turn feedback, return
    outside the box = move to box
    In the box, playing, and my turn = throw

*/

#include "nw_i0_plot"
#include "dla_inc_darts"
#include "x2_inc_cutscene"
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPlaceableLastClickedBy();
    object oOpponent = GetLocalObject(oPC,"oMyDartOpponent");
    location lMove = GetLocation(GetWaypointByTag("WP_dartmove"));
    int nAC,bMove;

    //First, clear all actions.  This will stop the PC from moving to target.
    AssignCommand(oPC, ClearAllActions());

    //check dart permissions.  If it is not the PCs turn, or a game is not in progress,
    //bail out of the script.
    if(!GetLocalInt(oPC,"nPlayingDarts"))
    {
        //AssignCommand(oPC, ActionExamine(oSelf));
        return;
    }
    /*turn is over, change players
    if(GetLocalInt(oPC, "nMyDartThrow")==3)
    {
        RemoveImmobility(oPC);
        DeleteLocalInt(oPC,"nMyDartThrow");
        DeleteLocalInt(oPC,"nMyDartTurn");
        ExecuteScript("dla_dart_aiturn",oOpponent);
        return;
    } */
    if(!GetLocalInt(oPC, "nMyDartTurn"))
    {
        FloatingTextStringOnCreature("**Wait your Turn**", oPC);
        return;
    }

    //move the PC to the throwing box if he's not there, and opponent to wait zone.
    object oBox = GetNearestObjectByTag("dart_throwing");
    object oWait = GetNearestObjectByTag("dart_wait1");
    object oWait2 = GetNearestObjectByTag("dart_waiting0");
    object oDart;
    object oArea = GetArea(oPC);
    location lMarker1 = GetLocation(oBox);
    location lMarker2 = GetLocation(oWait);
    location lMarker3 = GetLocation(oWait2);
    location lPC = GetLocation(oPC);
    if(GetDistanceBetween(oPC,oBox)>0.2f)
    {
        FloatingTextStringOnCreature("*You need to throw from the box*", oPC);
        AssignCommand(oPC, ActionMoveToLocation(lMarker1));
        AssignCommand(oOpponent, ActionForceMoveToLocation(lMarker3));
        AssignCommand(oOpponent, SetFacing(GetFacingFromLocation(GetLocation(OBJECT_SELF))));
        return;
    }
    //Set up the dart in player's hand. We use three so the PC does not run to
    //target after the last throw.  need to make sure dart is in hand
    if(!HasItem(oPC,"dla_gamedart"))
    {
        oDart = CreateItemOnObject("dla_gamedart",oPC,3);
    }
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))!="dla_gamedart")
    {
        oDart = GetItemPossessedBy(oPC,"dla_gamedart");
        AssignCommand(oPC, ActionEquipItem(oDart,INVENTORY_SLOT_RIGHTHAND));
    }
    //track criticals
    SetLocalInt(oSelf,"nDartBoardHP",GetCurrentHitPoints());
    //have the opponent face the board
    AssignCommand(oOpponent, SetFacingPoint(GetPosition(OBJECT_SELF)));

    //moved to Furniture's fate, so we have to watch for wandering commoners
    //debugEffect
    effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_RED);
    object oMove = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oMove))
    {
        if(GetLocalInt(oMove,"bDartsInTheWay") && oMove!= oOpponent)
        {
            bMove=TRUE;
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGlow,oMove,6.0);
            AssignCommand(oMove,ActionMoveToLocation(lMove));
            //debug
            AssignCommand(oPC, SetFacing(GetFacingFromLocation(GetLocation(oMove))));
            //SendMessageToPC(oPC,GetName(oMove));
        }
        oMove = GetNextObjectInArea(oArea);
        if(bMove)
        {
            AssignCommand(oPC,PlayVoiceChat(VOICE_CHAT_MOVEOVER,oPC));
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING,1.0));
            return;
        }
    }
    //Setup the cutscene
    ApplyEffectToObject(2,EffectCutsceneImmobilize(),oPC);
    DelayCommand(0.1,AssignCommand(oPC, DoPlaceableObjectAction(oSelf,PLACEABLE_ACTION_BASH)));
    //DelayCommand(0.1,AssignCommand(oPC, ActionAttack(OBJECT_SELF)));
    //CutActionAttack(0.1,oPC,OBJECT_SELF);
    SetCutsceneMode(oPC,TRUE,TRUE);
    //SetCameraMode(oPC,CAMERA_MODE_TOP_DOWN);
    CutSetCamera(0.0f,oPC,CAMERA_MODE_TOP_DOWN,90.0f,4.0f,70.0f,0);
}
