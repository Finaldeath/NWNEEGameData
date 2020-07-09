//sc_chatue_gold
//This script checks that the PC has enough gold to enter the Chateu Elite via the back door
//
//Author: Phil Mitchell (Baron of Gateford)

int StartingConditional()
{
   object oPC = GetPCSpeaker();
   int iGold = GetGold(oPC);

   if (iGold > 100)
       {
        return TRUE;
       }
   else
       {
        return FALSE;
       }
}




