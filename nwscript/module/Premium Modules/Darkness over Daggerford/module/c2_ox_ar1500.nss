// onExit event for AR1500 (Wild Pastures)
// .. the laughing goblin won't stay around forever!

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        object oGoblin = GetObjectByTag("_ar1500_goblin_invis");
        if (GetIsObjectValid(oGoblin))
        {
            object oVoice = GetLocalObject(oGoblin, "HF_VOICE");
            DestroyObject(oVoice);
            DestroyObject(oGoblin);
        }
    }
}
