void main()
{
    object oJonas = GetObjectByTag("ac_jonas2");
    //SetLocalInt(OBJECT_SELF,"has_met_pc",1);
    SetLocalInt(oJonas, "no_hb", 1);
    AssignCommand(oJonas, ClearAllActions());
    AssignCommand(oJonas, ActionMoveToObject(GetFirstPC()));
}
