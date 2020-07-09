void main()
{
  object oDragon = GetObjectByTag("ac_blackdragon");
  object oPC = GetExitingObject();

    if(GetIsPC(oPC))
    {
        SetLocalInt(oDragon,"iHeartbeat",0);
    }
}
