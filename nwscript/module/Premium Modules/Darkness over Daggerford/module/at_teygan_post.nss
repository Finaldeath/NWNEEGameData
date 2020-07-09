void main()
{
    object oTeygan=GetObjectByTag("Teygan");
    object oBrazier = GetObjectByTag("teygans_brazier");
    vector vTeygan = GetPosition(oBrazier);
    location lWaits=GetLocation(GetWaypointByTag("wp_teygan_waits"));
    AssignCommand(oTeygan,ActionForceMoveToLocation(lWaits,FALSE));
    DelayCommand(5.0f, AssignCommand(oTeygan, SetFacingPoint(vTeygan)));
}
