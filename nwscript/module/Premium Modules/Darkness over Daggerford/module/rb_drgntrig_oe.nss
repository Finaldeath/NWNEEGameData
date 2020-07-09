void main()
{
    object oDragon = GetObjectByTag("ac_blackdragon");
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        if(GetLocalInt(oDragon,"iHeartbeat") == 0)
        {
            SetLocalInt(oDragon,"iHeartbeat",1);
            ExecuteScript("rb_dragon_phb",oDragon);
        }
    }
}
