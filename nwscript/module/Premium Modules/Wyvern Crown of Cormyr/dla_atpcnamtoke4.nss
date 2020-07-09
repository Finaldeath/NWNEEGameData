// B W-Husey
// October 2005
// Sets the custom token 1021 (preferred title)
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    string sItems = "";
    SetCustomToken(1021,"Sir");
}
