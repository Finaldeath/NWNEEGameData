void main()
{
    object oPC = GetPCSpeaker();
    object oDest = GetWaypointByTag("WP_AR1107_DOG_DEST");
    object oMinedi = GetNearestObjectByTag("ks_minedi", oPC);
    AssignCommand(oMinedi, ActionMoveToObject(oDest));
}
