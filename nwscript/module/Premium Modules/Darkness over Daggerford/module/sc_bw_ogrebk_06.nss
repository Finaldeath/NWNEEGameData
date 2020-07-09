// returns TRUE if gnolls have been eliminated

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if ((GetLocalInt(oPC, "nWH_Been_C1AR0904") == 1) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnoll01"))) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnoll02"))) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnoll03"))) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnoll04"))) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnoll05"))) &&
        (!GetIsObjectValid(GetObjectByTag("bw_gnollking"))))
    {
        return TRUE;
    }
    else return FALSE;
}
