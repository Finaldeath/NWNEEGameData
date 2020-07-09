// encounter limit script checks for "civilization" waypoints nearby
// .. all encounter limit scripts set HF_RETVAL to -1 if the limit should be enforced

void main()
{
    int nRetVal = 1;
    object oPC = GetFirstPC();
    object oCivilization = GetNearestObjectByTag("ENC_CIVILIZATION_NEARBY", oPC);
    float fDist = GetDistanceBetween(oPC, oCivilization);
    if (fDist > 0.0 && fDist < 30.0)
    {
        nRetVal = -1; // fail the check
    }
    SetLocalInt(OBJECT_SELF, "HF_RETVAL", nRetVal);
}
