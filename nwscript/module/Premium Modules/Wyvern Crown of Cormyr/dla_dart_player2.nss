#include "nw_i0_plot"
#include "X0_INC_HENAI"
void main()
{
    object oPC = GetPCSpeaker();
    object oBoard = GetNearestObjectByTag("dla_dartboard");
    object oScore0 = GetObjectByTag("dart_score0");
    object oScore1 = GetObjectByTag("dart_score1");
    object oPrevious = GetLocalObject(oPC,"oMyPreviousDartOpponent");
    int nLoc;
    location lLoc;
    object oHench = GetFirstFactionMember(oPC, FALSE);
    while(GetIsObjectValid(oHench))
    {
        if(oHench != oPC)
        {
            ExecuteScript("dla_dart_movehen", oHench);
        }
        oHench = GetNextFactionMember(oPC,FALSE);
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneGhost(),OBJECT_SELF);
    SetName(oBoard, "Round: 1");
    SetName(oScore0, GetName(OBJECT_SELF)+": 0");
    SetName(oScore1, GetName(oPC)+": 0");
    SetLocalInt(oBoard,"nMyDartRoundNumber",1);
    SetLocalInt(oPC,"nMyDartTurn",FALSE);
    SetLocalInt(oPC,"nMyDartRound",1);
    SetLocalInt(oPC,"nMyDartThrow",0);
    SetLocalInt(oPC,"nPlayingDarts",1);
    SetLocalInt(oPC,"nDartPCWentFirst",0);
    SetLocalObject(oPC,"oMyDartOpponent",OBJECT_SELF);
    DeleteLocalInt(oPC,"nDartLostLastGame");
    DeleteLocalInt(oPC,"nDartWonLastGame");
    if(!HasItem(OBJECT_SELF,"dla_gamedart"))
    {
        object oDart = CreateItemOnObject("dla_gamedart",OBJECT_SELF,10);
        AssignCommand(OBJECT_SELF, ActionEquipItem(oDart,INVENTORY_SLOT_RIGHTHAND));
    }
    if(GetIsObjectValid(oPrevious) && oPrevious!=OBJECT_SELF)
    {
        nLoc = GetLocalInt(oPrevious,"nMyDartWaitSpot");
        lLoc = GetLocation(GetObjectByTag("dart_waiting"+IntToString(nLoc)));
        AssignCommand(oPrevious, ActionForceMoveToLocation(lLoc));
        DelayCommand(3.0, AssignCommand(oPrevious, SetFacingPoint(GetPosition(oBoard))));
    }
}
