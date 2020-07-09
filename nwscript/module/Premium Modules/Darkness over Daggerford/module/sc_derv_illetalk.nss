int StartingConditional()
{
    //luspr...
    //returns true in 3 cases:
    //veiti has talked about illefarn, or
    //player has read the illefarn book in the daggerford library,
    //player must head to Illefarn from critical plot
    if (GetLocalInt(GetModule(), "knows_illefarn") ==1||
        GetLocalInt(GetModule(), "veiti_mention") ==1||
        GetLocalInt(GetModule(), "illefarn_active") ==1)
    return TRUE;
    return FALSE;
}
