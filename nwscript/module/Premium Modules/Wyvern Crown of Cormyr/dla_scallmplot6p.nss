//: B W-Husey
//  December 2005
//  The main plot variable nMainPlot > 6
// The PC has found and sunk Wyvernwater castle. Within this section is up to the tournament and poisoning
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 6)
        return TRUE;

    return FALSE;
}
