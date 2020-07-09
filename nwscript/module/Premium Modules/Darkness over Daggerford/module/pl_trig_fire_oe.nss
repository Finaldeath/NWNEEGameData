void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nActive") != 0)
        {
            SetLocalInt(oPC, "nInsideFire", 1);
            ExecuteScript("pl_trig_fire_in", oPC);
        }
    }
}
