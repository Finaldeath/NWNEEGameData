//::///////////////////////////////////////////////
//:: FileName con_ac_milliewin
//:: Millie goes to window to call Porto in, and then resumes convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/18/2005 3:25:02 PM
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oM = GetObjectByTag("ac_millie");
    object oP = GetObjectByTag("ac_porto");
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oP);
    object oWindow = GetObjectByTag("ac_cheese_window");

    SetLocalInt(oM,"no_banter",1);
    SetLocalInt(oM,"no_hb",1);
    SetLocalInt(oP,"no_banter",1);
    SetLocalInt(oP,"no_hb",1);

    AssignCommand(oP, ClearAllActions());
    AssignCommand(oP, ActionDoCommand(ActionUnequipItem(oTorch)));
    DelayCommand(4.0, AssignCommand(oP, ActionJumpToObject(GetWaypointByTag("wp_ac_porto_inside"))));
    DelayCommand(4.2, AssignCommand(oP, ActionForceMoveToObject(oPC, TRUE, 1.0, 10.0)));

    ClearAllActions();
    ActionForceMoveToObject(oWindow, TRUE, 1.0, 5.0);
    ActionDoCommand(SetFacingPoint(GetPosition(oWindow)));
    ActionSpeakString("PORTO! COME INSIDE A MOMENT, WILL YOU!");
    ActionWait(5.0);
    ActionDoCommand(SetFacingPoint(GetPosition(oPC)));
    ActionForceMoveToObject(oPC, TRUE, 1.0, 5.0);
    ActionDoCommand(SetLocalInt(oM, "no_banter",0));
    ActionDoCommand(SetLocalInt(oM, "no_hb",0));
    ActionDoCommand(SetLocalInt(oP, "no_banter",0));
    ActionWait(4.0);
    ActionStartConversation(oPC, "at_millie2");
    ActionDoCommand(SetCommandable(TRUE, oPC));
}
