// December 2005
// B W-Husey
// PC has Intimidate, and has not used it before.
// Special version used on huntcrown that allows those without the skill to intimidate (as it's the only dialogue branch)
// AND the PC has the horn

#include "nw_i0_tool"
int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "UnicornHorn"))
        return FALSE;

    string sName = "INTIM2"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(nOnce>0)
        return FALSE;
    return TRUE;
}


