#include "ddf_util"
#include "x0_i0_partywide"

void main()
{
    MovePartyToObject(GetPCSpeaker(), GetObjectByTag("seamarket_arrival"));
    // AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("seamarket_arrival"), FALSE));
}
