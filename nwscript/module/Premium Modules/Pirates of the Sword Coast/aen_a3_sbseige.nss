//::///////////////////////////////////////////////
//:: aen_a3_sbseige
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the Seige aboard the skull and bones.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "inc_undead"
#include "x0_i0_henchman"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oWPCrew, oNPCCrew;
    object oWPGarm, oWPNisar;
    object oMaster, oGarm, oNisar;
    object oWPLeave, oWPSpwnS;

    int iDoOnce = GetLocalInt(oModule, "aen_a3_sbseige");
    int iCounter = 1;

    string sNPCTag;
    location lSpawn;

    if ((GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE))
    {
        DelayCommand(0.5f, ApplyVFXEyes(oPC));

        if (iDoOnce == FALSE)
        {
            UpdateSafePoint();

            SetLocalInt(oModule, "aen_a3_sbseige", TRUE);
            sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));

            while (sNPCTag != "")
            {
                oWPCrew = GetObjectByTag("A3_SEIGESPWN_0" + IntToString(iCounter));
                lSpawn = GetLocation(oWPCrew);

                sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
                oNPCCrew = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, lSpawn);

                //SendMessageToPC(oPC, "***aen_a3_sbseige fired; crew '"
                //    + GetTag(oNPCCrew) + "' at waypoint '" + GetTag(oWPCrew) + "'");

                iCounter++;
            }

            // Remove garm and paint him up
            oGarm = GetObjectByTag("a1_hench_garm");
            oMaster = GetMaster(oGarm);

            FireHenchman(oMaster, oGarm);
            RemoveHenchman(oMaster, oGarm);

            oWPGarm = GetObjectByTag("A3_SEIGESPWN_GARM");
            DelayCommand(0.5f, AssignCommand(oGarm,
                JumpToLocation(GetLocation(oWPGarm))));
            DelayCommand(1.0f, ApplyVFXEyes(oGarm));

            // Remove Nisar and paint him up
            oNisar = GetObjectByTag("a2_hench_nisar");
            oMaster = GetMaster(oNisar);

            FireHenchman(oMaster, oNisar);
            RemoveHenchman(oMaster, oNisar);

            oWPNisar = GetObjectByTag("A3_SEIGESPWN_NISAR");
            DelayCommand(0.5f, AssignCommand(oNisar,
                JumpToLocation(GetLocation(oWPNisar))));
            DelayCommand(1.0f, ApplyVFXEyes(oNisar));

            //save
            ExecuteScript("exe_autosave", GetModule());
        }
    }
}
