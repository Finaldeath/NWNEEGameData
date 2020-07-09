//: B W-Husey
//  December 2005
//  The main plot variable nMainPlot == 5
// The PC has found but not sunk Wyvernwater castle. Within this section is the decision tree
// on Salvatori and his fate (this is only possible within this section). Plot characters use
// a 'castle in progression, stop the pirates' dialogue.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") == 5)
        return TRUE;

    return FALSE;
}
