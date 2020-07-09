//c3_Mariner_enc
//This will fire the encounter in the mariners alliance when the PC picks up the
//shipping records
//
//Author: Phil Mitchell (Baron of Gateford)
#include "NW_I0_GENERIC"
void main()
{
  object oPC = GetEnteringObject();
  object oMariner1 = GetNearestObjectByTag("pm_mariner1",oPC,1);
  object oMariner2 = GetNearestObjectByTag("pm_mariner2",oPC,1);
  object oMariner3 = GetNearestObjectByTag("pm_mariner3",oPC,1);
  object oMariner4 = GetNearestObjectByTag("pm_mariner4",oPC,1);
  object oWP = GetNearestObjectByTag("Mariner_spawn",oPC,1);
  object oDoor = GetNearestObjectByTag("MarinerDoor1",oPC,1);
  if (GetIsPC(oPC) &&
       !GetLocalInt(OBJECT_SELF,"mariner_enc_fired")&&
       GetLocalInt(GetModule(),"barge_activity") == 2)
     {
       SetPlotFlag(GetNearestObjectByTag("pm_secondvoice",oPC),FALSE);
       SetPlotFlag(GetNearestObjectByTag("pm_firstvoice",oPC),FALSE);
       DestroyObject(GetNearestObjectByTag("pm_secondvoice",oPC));
       DestroyObject(GetNearestObjectByTag("pm_firstvoice",oPC));
       AssignCommand(oDoor, ActionOpenDoor(oDoor));
       AssignCommand(oMariner1, ActionMoveToObject(oWP));
       AssignCommand(oMariner2, ActionMoveToObject(oWP));
       AssignCommand(oMariner3, ActionMoveToObject(oWP));
       AssignCommand(oMariner4, ActionMoveToObject(oWP));
       AssignCommand(oMariner1, DetermineCombatRound(oPC));
     }
}
