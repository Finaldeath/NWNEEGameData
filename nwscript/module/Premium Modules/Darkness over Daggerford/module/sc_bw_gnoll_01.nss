// returns TRUE if ogres have been eliminated

int StartingConditional()
{
    object oPC = GetPCSpeaker();

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
        return TRUE;
    }
    else return FALSE;
}
