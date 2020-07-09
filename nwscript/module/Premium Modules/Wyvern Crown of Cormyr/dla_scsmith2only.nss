// October 2005
// B W-Husey
// These weapons can only use a max of 2 shards due to size of metal area.
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rdagger")
        return TRUE;
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rhandaxe")
        return TRUE;
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rkama")
        return TRUE;
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rkukri")
        return TRUE;
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rlighthammer")
        return TRUE;

    return FALSE;
}
