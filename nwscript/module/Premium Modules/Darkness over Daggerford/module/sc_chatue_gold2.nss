//sc_chatue_gold2
//if the PC has tried to be clever and remove the 100gp before entering the Chateu
//this will check for it.
//
//Author: Phil Mitchell (Baron of Gateford)

int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetPCSpeaker(),"Tricker") == 1;
    return iResult;
}
