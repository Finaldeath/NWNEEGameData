// B W-Husey
// October 2005
//

#include "cu_functions"
//include the library for variable setting command AllParty()

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
//        AllParty("nMainPlot",oPC,1);
        Refresh(oPC);
        ExecuteScript("misc_tokens",oPC);

        //Set empty tokens only at start
        SetCustomToken(1021,"");
        SetCustomToken(1053,"");

    }
}




