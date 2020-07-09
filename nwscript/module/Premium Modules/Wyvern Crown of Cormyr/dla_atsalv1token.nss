// B W-Husey
// October 2005
// Sets the custom token 1006 (companion)
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);
    object oHench3 = ReturnHenchman(oPC,3);
    if (GetTag(oHench1) == "Godfroy") SetCustomToken(1006,"and our friend Godfroy Cormas");
    else if (GetTag(oHench2) == "Godfroy") SetCustomToken(1006,"and our friend Godfroy Cormas");
    else if (GetTag(oHench3) == "Godfroy") SetCustomToken(1006,"and our friend Godfroy Cormas");
    else  SetCustomToken(1006,"");
}
