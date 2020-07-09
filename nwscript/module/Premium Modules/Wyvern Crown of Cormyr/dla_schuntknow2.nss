//December 2005
// B W-Husey
// PC knows that Huntcrown is interested in hunting. Info came from Kathryn.
// PC has not taken the horn quest. (getting nHOrder to 1 without taking the quest is impossible
// so we don't need to test for it).

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nHOrder") <2)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nToOrder") > 0)
        return FALSE;

    return TRUE;
}
