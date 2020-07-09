//::///////////////////////////////////////////////
//:: FileName dla_scallinns
//:: B W-Husey
//:: October 2005
//  Checks the PC has enough gold to pay for inns, (if there are inns on this route).
// the cost has already been stored on the PC in the dialogue choice they made.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
//    SendMessageToPC(GetPCSpeaker(),"Travel Cost "+IntToString(GetLocalInt(GetPCSpeaker(),"nTravelCost")));
    if(GetLocalInt(GetPCSpeaker(),"nTravelCost") > GetGold(GetPCSpeaker()))
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(),"nTravelHasInn") < 1 )
        return FALSE;
    return TRUE;
}
