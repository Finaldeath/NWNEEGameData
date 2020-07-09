void main()
{
    object oPC = GetEnteringObject();
    object oJ1 = GetObjectByTag("ac_jonas1");
    object oJ2 = GetObjectByTag("ac_jonas2");
    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;

    if (GetLocalInt(GetModule(), "ac_werewolf") == 4)
    {
        //AssignCommand(oJ1, ActionStartConversation(oPC));
        //AssignCommand(oJ2, ActionMoveToObject(oPC));
        SetLocalInt(OBJECT_SELF,"fired",1);
    }
}
