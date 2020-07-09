//October 2005
//B W-Husey
// Edgar quits and changes his livery to Truesilver livery - teleported to Sign of Thunder.

#include "x0_i0_henchman"
#include "cu_cameras"
#include "dla_i0_horse"

void main()
{
//    object oSalvatori = GetNearestObjectByTag("SalvatoriCut1");
    object oSalvatori = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    //********debug line*******
//    SendMessageToPC(oPC,"I Fired cut1b");

    object oEdgar = GetNearestObjectByTag("Edgar");
    object oArmour = CreateItemOnObject("truesilvermail",oEdgar);
    object oShield = CreateItemOnObject("truesilvershiel",oEdgar);
    object oCloak = CreateItemOnObject("truesilvercloak",oEdgar);
    location lLoc = GetLocation(GetWaypointByTag("JP_EdgarSign"));
    location lLoc2 = GetLocation(GetWaypointByTag("CP_Cut5"));
    location lLoc3 = GetLocation(GetWaypointByTag("CP_EdgarExit"));
    effect eHeal = EffectHeal(50);
    WCCameraMove(0.0,300.0,5.0,80.0,145.0,5.0,80.0,2.0,50.0,oPC);
    AssignCommand(oEdgar,ClearAllActions());
    DelayCommand(0.1,AssignCommand(oSalvatori,ClearAllActions()));
    DelayCommand(0.2,AssignCommand(oEdgar,DLA_RemoveHenchman(oPC)));
    DelayCommand(0.3,AssignCommand(oSalvatori,ActionForceMoveToLocation(lLoc2,FALSE,6.0)));
    DelayCommand(0.4,AssignCommand(oEdgar,ActionMoveToLocation(lLoc3,FALSE)));
    DelayCommand(0.5,AssignCommand(oPC,ActionMoveToLocation(GetLocation(GetWaypointByTag("CP_Cut4")))));
    DelayCommand(8.0,AssignCommand(oSalvatori,ActionStartConversation(oPC,"cut1b",FALSE,FALSE)));
    DelayCommand(7.0,AssignCommand(oEdgar,JumpToLocation(lLoc)));
    DelayCommand(10.0,AssignCommand(oEdgar,ActionEquipItem(oArmour,INVENTORY_SLOT_CHEST)));
    DelayCommand(10.1,AssignCommand(oEdgar,ActionEquipItem(oShield,INVENTORY_SLOT_LEFTHAND)));
    DelayCommand(10.2,AssignCommand(oEdgar,ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK)));
    DelayCommand(10.3,AssignCommand(oEdgar,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oEdgar)));
}
