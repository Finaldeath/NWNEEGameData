void main()
{
    object oXanda=GetObjectByTag("db_xanda_unc");
    object oExit=GetWaypointByTag("wp_vamp_exit");
    AssignCommand(oXanda,ActionMoveToObject(oExit,TRUE,0.5));
    DestroyObject(oXanda,5.0);
}
