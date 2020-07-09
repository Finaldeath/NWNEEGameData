void main()
{
    object oPC = GetEnteringObject();
    object oThug1 = GetObjectByTag("a0_corridor_thug");
    object oThug2 = GetObjectByTag("a0_mutch");

    object oDoorThug1 = GetObjectByTag("a0_door_leader");
    object oDoorThug2 = GetObjectByTag("a0_door_bandit", 0);
    object oDoorThug3 = GetObjectByTag("a0_door_bandit", 1);

    int iDoOnce = GetLocalInt(OBJECT_SELF, "DOONCE");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(OBJECT_SELF, "DOONCE", TRUE);

        AssignCommand(oThug1, SpeakString("Hey, get back here!"));

        ChangeToStandardFaction(oThug1, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oThug2, STANDARD_FACTION_HOSTILE);

        AssignCommand(oThug1, ClearAllActions());

        DelayCommand(0.5f, AssignCommand(oThug1, ActionAttack(oPC)));
        DelayCommand(0.5f, AssignCommand(oThug2, ActionAttack(oPC)));

        ChangeToStandardFaction(oDoorThug1, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oDoorThug2, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oDoorThug3, STANDARD_FACTION_HOSTILE);
    }
}
