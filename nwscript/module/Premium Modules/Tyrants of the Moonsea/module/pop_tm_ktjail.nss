void main()
{
    if(GetLocalInt(OBJECT_SELF, "nOpened") == 0)
    {
        object oBaerimel = GetNearestObjectByTag("Baerimel");
        AssignCommand(oBaerimel, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 32767.0));
        SetLocalInt(OBJECT_SELF, "nOpened", 1);
    }
}
