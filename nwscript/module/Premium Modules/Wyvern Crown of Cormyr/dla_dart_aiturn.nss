#include "dla_inc_darts"
#include "x2_inc_cutscene"
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetFirstPC();
    object oWait = GetObjectByTag("dart_waiting1");
    object oWait2 = GetObjectByTag("dart_waiting0");
    object oBox = GetNearestObjectByTag("dart_throwing");
    object oBoard = GetNearestObjectByTag("dla_dartboard");
    object oArea = GetArea(oPC);
    int nRound = GetDartRoundNumber();
    int nFirst = GetLocalInt(oPC, "nDartPCWentFirst");
    location lWait = GetLocation(oWait);
    location lWait2 = GetLocation(oWait2);
    location lBox = GetLocation(oBox);
    location lMove = GetLocation(GetWaypointByTag("WP_dartmove"));

    //moved to Furniture's fate, so we have to watch for wandering commoners
    object oMove = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oMove))
    {
        if(GetLocalInt(oMove,"bDartsInTheWay") && oMove!= oSelf)
        {
            AssignCommand(oMove,ActionMoveToLocation(lMove));
        }
        oMove = GetNextObjectInArea(oArea);
    }

    SetCutsceneMode(oPC,TRUE);
    AssignCommand(oPC, ActionForceMoveToLocation(lWait));
    AssignCommand(oSelf, ActionForceMoveToLocation(lBox));
    DelayCommand(3.0, AssignCommand(oPC, SetFacingPoint(GetPosition(oBoard))));
    DelayCommand(3.0, ApplyEffectToObject(2,EffectCutsceneImmobilize(),oPC));
    DelayCommand(3.0, AssignCommand(oSelf, SetFacingPoint(GetPosition(oBoard))));
    DelayCommand(3.0, SetDartTarget(nRound,3));
    DelayCommand(3.0, SetCutsceneMode(oPC,TRUE,TRUE));
    DelayCommand(6.0, AssignCommand(oSelf, DoPlaceableObjectAction(oBoard,PLACEABLE_ACTION_BASH)));
    //CutActionAttack(6.0,oSelf,oBoard);
    DelayCommand(7.4, AssignCommand(oSelf, ClearAllActions(TRUE)));
    DelayCommand(9.0, SetDartTarget(nRound,2));
    DelayCommand(13.0, AssignCommand(oSelf, DoPlaceableObjectAction(oBoard,PLACEABLE_ACTION_BASH)));
    //CutActionAttack(13.0,oSelf,oBoard);
    DelayCommand(14.4, AssignCommand(oSelf, ClearAllActions(TRUE)));
    DelayCommand(16.0, SetDartTarget(nRound,1));
    DelayCommand(20.0, AssignCommand(oSelf, DoPlaceableObjectAction(oBoard,PLACEABLE_ACTION_BASH)));
    //CutActionAttack(20.0,oSelf,oBoard);
    DelayCommand(21.4, AssignCommand(oSelf, ClearAllActions(TRUE)));
    DelayCommand(24.0, AssignCommand(oSelf, ActionForceMoveToLocation(lWait2)));
    DelayCommand(24.1, SetCutsceneMode(oPC,FALSE));
    //DelayCommand(24.2, DeleteLocalInt(oPC,"nMyDartThrow"));
    DelayCommand(24.2, SetLocalInt(oPC,"nMyDartTurn",TRUE));
    //DelayCommand(24.2, IncrementDartRound(nFirst,oSelf));
    //DelayCommand(24.2, RemoveImmobility(oPC));
    DelayCommand(24.2, AssignCommand(oSelf, SetFacingPoint(GetPosition(oBoard))));
}

