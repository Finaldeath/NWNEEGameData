void main()
{
    object oPC = GetLastOpenedBy();
    object oJerick = GetObjectByTag("db_shepherd2");
    if (!GetLocalInt(OBJECT_SELF, "do_once") ==1)
    {
        //flag Jerick's conversation
        SetLocalInt(GetModule(), "drop_off_conv", 2);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oJerick, ActionStartConversation(oPC));
        SetLocalInt(OBJECT_SELF, "do_once", 1);
    }
}
