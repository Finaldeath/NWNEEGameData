void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        object oBench = GetNearestObjectByTag("ChapelBench", oPC);
        object oOrc = GetNearestObjectByTag("KurTharsuHighChaplain", oPC);

        AssignCommand(oOrc, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 32767.0));
        AssignCommand(GetNearestObjectByTag("KTShaman1", oPC),
            ActionSit(oBench));
        AssignCommand(GetNearestObjectByTag("KTShaman2", oPC),
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 32767.0));
        AssignCommand(GetNearestObjectByTag("KTShaman3", oPC),
            ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 32767.0));
        AssignCommand(GetNearestObjectByTag("KTShaman4", oPC),
            ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 32767.0));
        AssignCommand(GetNearestObjectByTag("KTShaman5", oPC),
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 32767.0));
        AssignCommand(GetNearestObjectByTag("KTShaman6", oPC),
            ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 32767.0));
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }
}
