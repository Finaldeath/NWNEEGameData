//::///////////////////////////////////////////////
//:: Name inc_debtsystem
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Debit a PC for attacking or stealing from a
    non-combatant.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

const int POTSC_PICKPOCKET = 1;
const int POTSC_ASSAULT = 2;

void AddToDebtList(object oPlayer, object oSource, int iCrime = POTSC_PICKPOCKET);
void CollectDebt(object oPlayer, int iDebt);
void _CollectDebt(object oPlayer);

void AddToDebtList(object oPlayer, object oSource, int iCrime)
{
    object oModule;
    string sPlayerID;
    string sXPValue;
    int iTotalDebt;
    int iDebt;

    oModule = GetModule();
    sPlayerID = "DEBT_" + GetPCPublicCDKey(oPlayer) + GetPCPlayerName(oPlayer);
    sXPValue = Get2DAString("exptable", "XP", GetHitDice(oPlayer) - 1);

    iDebt = (StringToInt(sXPValue) / 20) * iCrime;

    if (iDebt <= 0)
    {
        iDebt = 10;
    }

    iTotalDebt = GetLocalInt(oModule, sPlayerID);
    iTotalDebt = iTotalDebt + iDebt;

    FloatingTextStringOnCreature("Your fine is " + IntToString(iDebt)
        + " gold , for a total of " + IntToString(iTotalDebt) + " gold.",
        oPlayer, FALSE);

    CollectDebt(oPlayer, iDebt);
}

void CollectDebt(object oPlayer, int iDebt)
{
    object oModule;
    string sPlayerID;
    int iTotalDebt;

    oModule = GetModule();
    sPlayerID = "DEBT_" + GetPCPublicCDKey(oPlayer) + GetPCPlayerName(oPlayer);
    iTotalDebt = GetLocalInt(oModule, sPlayerID);

    if (iTotalDebt != FALSE)
    {
        iTotalDebt = iTotalDebt + iDebt;
        SetLocalInt(oModule, sPlayerID, iTotalDebt);
    }
    else
    {
        iTotalDebt = iTotalDebt + iDebt;
        SetLocalInt(oModule, sPlayerID, iTotalDebt);
        _CollectDebt(oPlayer);
    }
}

void _CollectDebt(object oPlayer)
{
    object oModule;
    string sPlayerID;
    int iTotalDebt;
    int iGold;

    oModule = GetModule();
    sPlayerID = "DEBT_" + GetPCPublicCDKey(oPlayer) + GetPCPlayerName(oPlayer);
    iTotalDebt = GetLocalInt(oModule, sPlayerID);

    iGold = GetGold(oPlayer);

    if (iGold >= iTotalDebt)
    {
        FloatingTextStringOnCreature("Your debt of " + IntToString(iTotalDebt)
            + " gold , has been paid in full.", oPlayer, FALSE);

        AssignCommand(oPlayer, TakeGoldFromCreature(iTotalDebt, oPlayer, TRUE));
        SetLocalInt(oModule, sPlayerID, FALSE);
    }
    else if (iGold > 0)
    {
        FloatingTextStringOnCreature("Your have lost " + IntToString(iGold)
            + " gold , to pay towards your debt of " + IntToString(iTotalDebt)
            + " gold.", oPlayer, FALSE);

        AssignCommand(oPlayer, TakeGoldFromCreature(iGold, oPlayer, TRUE));
        SetLocalInt(oModule, sPlayerID, (iTotalDebt - iGold));

        DelayCommand(5.0f, _CollectDebt(oPlayer));
    }
    else
    {
        DelayCommand(5.0f, _CollectDebt(oPlayer));
    }

}
