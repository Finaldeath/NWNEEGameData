void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nActive") != 0)
        {
            SetLocalInt(oPC, "nInsideFire", 0);
        }
    }
}
