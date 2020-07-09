void main()
{
    object oPC = GetExitingObject();

    if(GetIsPC(oPC))
    {
        object oJonas = GetObjectByTag("ac_jonas1");
        object oJunior = GetObjectByTag("ac_jonas2");
        object oJonasTarget = GetWaypointByTag("wp_jonas_maze2");
        object oJuniorTarget = GetWaypointByTag("wp_junior_maze2");

        SoundObjectStop(GetObjectByTag("ac_snd_werewolf"));
        SoundObjectStop(GetObjectByTag("ac_snd_werewolf2"));

        AssignCommand(oJonas, ClearAllActions(TRUE));
        AssignCommand(oJonas, ActionJumpToObject(oJonasTarget));
        AssignCommand(oJunior, ClearAllActions(TRUE));
        AssignCommand(oJunior, ActionJumpToObject(oJuniorTarget));
    }
}
