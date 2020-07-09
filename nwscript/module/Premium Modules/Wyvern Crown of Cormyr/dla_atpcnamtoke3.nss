// B W-Husey
// December 2005
// Sets the custom token 1020 (preferred title for PCs sometimes used by Edgar)
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    string sItems = "";
    if (GetGender(oPC)==GENDER_MALE) SetCustomToken(1020,GetName(oPC)+" my friend");
    else SetCustomToken(1020,"My Lady "+GetName(oPC));
}
