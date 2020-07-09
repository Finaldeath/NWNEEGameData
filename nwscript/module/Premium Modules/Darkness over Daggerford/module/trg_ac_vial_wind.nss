//::///////////////////////////////////////////////
//:: FileName trg_ac_vial_wind
//:: Muriel throws vial of poison out of window
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcFace(object o1)
{
AssignCommand(o1, SetFacing(180.0));
}

void main()
{
    object oPC = GetEnteringObject();
    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;

    SetLocalInt(OBJECT_SELF,"fired",1);
    SetLocalInt(GetArea(OBJECT_SELF), "iMetSister", 1);

    object oM = GetObjectByTag("ac_muriel");
    SetLocalInt(oM,"no_banter",1);
    DelayCommand(1.9,SetLocalInt(oM,"no_banter",0));

    object oWPV = GetWaypointByTag("wp_ac_poisonvial");
    object oWPW = GetWaypointByTag("wp_ac_muriel2");
    AssignCommand(oM, ActionForceMoveToObject(oWPW));
    AssignCommand(oM, ActionDoCommand(ahcFace(oM)));
    DelayCommand(0.8, AssignCommand(oM, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0)));
    CreateObject(OBJECT_TYPE_ITEM,"ac_itm_poisonv",GetLocation(oWPV));
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.2,TurnToFaceObject(oM,oPC));
    DelayCommand(2.0, AssignCommand(oM, ActionStartConversation(oPC)));
}

