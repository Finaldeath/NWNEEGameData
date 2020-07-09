//::///////////////////////////////////////////////
//:: mdt_potscdeath
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Death script for the IoP Module
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"

void main()
{
    object oPlayer = GetLastPlayerDied();
    object oCursor = GetFirstPC();
    object oPC;
    object oArea = GetArea(oPlayer);
    object oModule = GetModule();
    object oCell = GetWaypointByTag("a1_trogcell");

    location lCell = GetLocation(oCell);
    effect eHeal = EffectResurrection();
    int iPlayers = 0;
    string sDeath = "There is no penalty for respawning. You will be returned to "+
                    "a safe point in the module.";

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        oCursor = GetNextPC();
        iPlayers++;
    }

    if ((GetTag(oArea) == "a1_trogarena") && (iPlayers > 1))
    {
        object oGarm = GetObjectByTag("a1_garmclone");
        object oDoor = GetObjectByTag("a1_fightgate");

        //SendMessageToPC(oPlayer, "You are defeated!");
        SetLocalObject(oArea, "A1_CURRFIGHTER", OBJECT_INVALID);

        //FadeToBlack(oPlayer);
        AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
        DestroyObject(oGarm, 0.5);

        DelayCommand(1.0f, ReviveTarget(oPlayer));
        DelayCommand(1.0f, AssignCommand(oPlayer, ClearAllActions(TRUE)));
        DelayCommand(1.0f, SetLocked(oDoor, FALSE));
        DelayCommand(1.0f, AssignCommand(oDoor, ActionOpenDoor(oDoor)));

        DelayCommand(1.2f, AssignCommand(oPlayer, JumpToLocation(lCell)));
        DelayCommand(1.5f, FadeFromBlack(oPlayer));

        //SendMessageToPC(oPlayer, "The troglodytes return you to your prison cell.");

        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC) == TRUE)
        {
            if (GetLocalInt(oPC, "A1_WATCHING_FIGHT") == TRUE)
            {
                //SendMessageToPC(oPC, "Garm has defeated your champion!");
                ExecuteScript("exe_a1nwtchfight", oPC);
            }

            oPC = GetNextPC();
        }
    }
    else
    {
        PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, sDeath);
    }
}

