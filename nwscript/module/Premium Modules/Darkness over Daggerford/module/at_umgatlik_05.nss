void main()
{
    object oPC = GetPCSpeaker();
    object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
    object oExit = GetNearestObjectByTag("WP_AR2104_EXIT", oPC);

    AssignCommand(OBJECT_SELF, ClearAllActions());
    AssignCommand(OBJECT_SELF, ActionMoveToObject(oExit, FALSE, 0.5));

    object oSelf = OBJECT_SELF;
    AssignCommand(oVetrixia, ClearAllActions());
    AssignCommand(oVetrixia, ActionForceFollowObject(oSelf, 1.0));
}
