//::///////////////////////////////////////////////
//:: FileName con_ac_marinerop
//:: Mariner guard opens door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 4:28:19 PM
//:://////////////////////////////////////////////
void main()
{
    ClearAllActions();
    object oD = GetObjectByTag("DT_AR0302_BASEMENT");
    SetLocked(oD, FALSE);
    SetFacingPoint(GetPosition(oD));
    DelayCommand(0.5, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
    DelayCommand(2.5, AssignCommand(oD,ActionOpenDoor(oD)));
    SetLocalInt(OBJECT_SELF,"ac_taffy_opendoor",1);
}
