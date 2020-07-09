//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_grazkahn3
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Appears if player has Hellforged Sword.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "HellforgedSword"))
        return FALSE;

    return TRUE;
}
