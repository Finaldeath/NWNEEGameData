//B W-Husey
// September 2005
// Londro Sidequest variable = 5, convinced Matron (written), need Mander's Witnessing.
#include "nw_i0_tool"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "WitnessDoc"))
        return FALSE;

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") == 5)
        return TRUE;

    return FALSE;
}
