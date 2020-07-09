// encounter limit script checks if the ogres are friendly (or all dead)
// .. all encounter limit scripts set HF_RETVAL to -1 if the limit should be enforced

void main()
{
    int nRetVal = 1;
    object oPC = GetFirstPC();

    // are the ogres friendly?
    if (GetLocalInt(oPC, "nWH_PaidToll") == 100)
    {
        nRetVal = -1; // fail the check
    }

    // are the ogres dead?
    if ((GetLocalInt(oPC, "nWH_Been_C1AR0902") == 1) &&
    (GetLocalInt(oPC, "nWH_Been_C1AR0903") == 1) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre01"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre02"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre03"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre04"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre05"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogre06"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogremage"))) &&
    (!GetIsObjectValid(GetObjectByTag("bw_ogreking"))))
    {
        nRetVal = -1; // fail the check
    }

    SetLocalInt(OBJECT_SELF, "HF_RETVAL", nRetVal);
}

