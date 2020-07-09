// veiti will only talk to the player outside the hall of wonders
// .. if the door is still locked

void main()
{
    object oDoor = GetObjectByTag("EXIT_AR2501_AR2501D");
    if (GetLocked(oDoor))
    {
        ExecuteScript("hf_tu_henchman", OBJECT_SELF);
    }
}
