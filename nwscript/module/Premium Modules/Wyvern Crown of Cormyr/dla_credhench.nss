//::///////////////////////////////////////////////
//:: ndt_potsc_hench
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Custom Death script for PotSC NPC Henchmen.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:: Modified: B W-Husey
//:: Modified code so that Lacinda and Godfroy can be permanently killed (but raisable)
//:://////////////////////////////////////////////

#include "inc_safehench"

// added by gaoneng erick
#include "dla_mel_inc2"
// Added by Deva B. Winblood 7/29/2006 - to deal with mounted NPCs on death
#include "dla_i0_horse"
// Modified by Deva B. Winblood  10/04/2006 - made horses not die on henchman
// death if mounted.   Per discussion with team.  Also addressed some lag issues.
// end add

void main()
{
    object killer;
    object master;
    object oHorse; // Deva  7/29/2006
    object oMe=OBJECT_SELF;
    if (GetLocalInt(OBJECT_SELF,"nCanDie")==1)
    {
    SetIsDestroyable(FALSE,TRUE,TRUE);
    SetLocalInt(OBJECT_SELF,"nCanDie",0);
    }
    else
    {
// added by gaoneng erick
// if henchmen got killed in melee tournament, increase the kill count for the opponent
        if (GetTag(GetArea(OBJECT_SELF)) == DLA_ATAG_MELEEAREA)
        {
            killer = GetLastKiller();
            master = GetMaster(killer);
            while (GetIsObjectValid(master))
            {
                killer = master;
                master = GetMaster(killer);
            }
            SetLocalInt(killer, DLA_NUMBER_OF_KILLS, GetLocalInt(killer, DLA_NUMBER_OF_KILLS) + 1);
        }
// end add
    HandleDeath();
    }
    /*if (DLA_GetIsMounted(oMe)) // Deva B. Winblood 7/29/2006  Mantis #1914
    { // this NPC is mounted - deal with horse
        oHorse=GetLocalObject(oMe,"oDLAMyMount");
        if (GetTag(oMe)!="Lacinda")
        { // alter appearance
            DLA_ChangeToOriginalAppearance(oMe);
            DelayCommand(30.0,DLA_ChangeToOriginalAppearance(oMe));
        } // alter appearance
        SetAILevel(oHorse,AI_LEVEL_HIGH);
        SetCommandable(TRUE,oHorse);
        AssignCommand(oHorse,ClearAllActions(TRUE));
        AssignCommand(oHorse,JumpToLocation(GetLocation(oMe)));
        DelayCommand(4.0,DLA_DespawnPaladinMount(oHorse));
    } // this NPC is mounted - deal with horse*/
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

