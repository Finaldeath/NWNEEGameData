void main()
{
    object oVampExit=GetWaypointByTag("wp_vamp_exit");
    ActionMoveToObject(oVampExit,TRUE,4.0f);
    DestroyObject(OBJECT_SELF,6.0);
}
