// B W-Husey
// October 2005
// Sets the custom token 1013 (preferred title for female PCs)
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    string sItems = "";
    SetCustomToken(1013,"Lady");
}
