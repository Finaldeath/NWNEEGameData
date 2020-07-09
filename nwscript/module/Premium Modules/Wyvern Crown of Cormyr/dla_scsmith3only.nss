// October 2005
// B W-Husey
// These weapons can only use a max of 3 shards due to size of metal area.
int StartingConditional()
{

    // Inspect local variables

    if(GetLocalString(GetPCSpeaker(), "sItem") == "rscythe")
        return TRUE;
    if(GetLocalString(GetPCSpeaker(), "sItem") == "rquarterstaff")
        return TRUE;

    return FALSE;
}
