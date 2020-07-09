//at_chatue_gold2
//This will take the gold from the PC but also check the amount.
//
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
   object oPC = GetPCSpeaker();
   int iGold = GetGold(oPC);
   if (iGold < 100)
       {
        SetLocalInt(oPC,"Tricker",1);
       }
   else
       {
        SetLocalInt(oPC,"Tricker",0);
        AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));
       }
}

