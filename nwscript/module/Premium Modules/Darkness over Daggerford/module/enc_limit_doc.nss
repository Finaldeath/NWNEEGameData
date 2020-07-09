// encounter limit script checks if gorgo has appeared yet
// .. all encounter limit scripts set HF_RETVAL to -1 if the limit should be enforced

void main()
{
    int nRetVal = 1;
    object oPC = GetFirstPC();
    if (GetLocalInt(oPC, "nTanarukkLeaderInDOCAppeared") == 1)
    {
        nRetVal = -1; // fail the check
    }
    SetLocalInt(OBJECT_SELF, "HF_RETVAL", nRetVal);
}
