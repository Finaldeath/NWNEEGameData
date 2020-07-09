void main()
{
    object oPray = GetNearestObjectByTag("PrayAmb");
    AssignCommand(oPray,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,10.0));
}
