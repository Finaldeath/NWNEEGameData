#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    object oDungeon = GetCurrentDungeon();
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    int nGold = GetLocalInt(OBJECT_SELF, "nGold");
    int nXP = GetLocalInt(OBJECT_SELF, "nXP");
    string sMessage = GetLocalString(OBJECT_SELF, "sMessage");

    string sPlot = "Plot" + IntToString(nPlot);

    string sIdentifier;
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        // determine if this pc is involved in the plot
        sIdentifier = GetPCIdentifier(oPC);
        DebugMessage("Examining player " + sIdentifier);
        if (GetLocalInt(oDungeon, "b" + sPlot + "Player_" + sIdentifier) == TRUE)
        {
            DebugMessage("Rewarding player.");

            if (nGold > 0)
            {
                GiveGoldToCreature(oPC, nGold);

                // pay henchman tithe
                PayHenchmanTithe(oPC, nGold);
            }

            if (nXP > 0)
            {
                GiveXPToCreature(oPC, nXP);
            }

            SendMessageToPC(oPC, sMessage);
        }

        // cycle to next player
        oPC = GetNextPC();
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}

