int StartingConditional()
{
    object oPC = GetLastSpeaker();
    object oLeader = GetFactionLeader(oPC);

    if(oPC != oLeader) return TRUE;

    int nPickedBackgroundFlag = GetLocalInt(GetModule(), "ddf_background_picked_flag");

    if(nPickedBackgroundFlag > 0) return TRUE;

    return FALSE ;
}
