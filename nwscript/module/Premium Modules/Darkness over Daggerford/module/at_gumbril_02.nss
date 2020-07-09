void main()
{
    object oPC = GetPCSpeaker();
    object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
    object oGumbril = GetNearestObjectByTag("ks_gumbril", oPC);
    object oAltar = GetNearestObjectByTag("pl_umgatliks_altar", oPC);
    AssignCommand(oVetrixia, SetFacingPoint(GetPosition(oAltar)));
    AssignCommand(oGumbril, SetFacingPoint(GetPosition(oAltar)));
    AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 4.0));
}
