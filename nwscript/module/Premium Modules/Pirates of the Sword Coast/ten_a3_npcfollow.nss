//::///////////////////////////////////////////////
//:: ten_a3_npcfollow
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    NPC crewman follow the PC around the Island
    of the Dead
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

void Debug(string sMSG);

void main()
{
    object oTrigger = OBJECT_SELF;
    object oPC = GetEnteringObject();
    object oModule = GetModule();
    object oNPC1, oNPC2, oNPC3, oNPC4, oNPC5;
    object oWP1, oWP2, oWP3, oWP4, oWP5;
    object oKey = GetItemPossessedBy(oPC, "a3_sigilkey");

    int iFollow =  GetLocalInt(GetModule(), "A3_HUNT");
    int iUnDead = GetLocalInt(oModule, "A3_DEAD");

    effect eGhost = EffectCutsceneGhost();
    string sGroupNum = GetStringRight(GetTag(oTrigger), 2);
    string sNPCTag1, sNPCTag2, sNPCTag3, sNPCTag4, sNPCTag5;

    if ((GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE)
        && (GetIsObjectValid(oKey) == TRUE) && (iFollow >= 10))
    {
        //Debug("Firing ten_a3_npcfollow");

        oWP1 = GetNearestObjectByTag("WPA3_FOLLOW_"+ sGroupNum +"_01");
        oWP2 = GetNearestObjectByTag("WPA3_FOLLOW_"+ sGroupNum +"_02");
        oWP3 = GetNearestObjectByTag("WPA3_FOLLOW_"+ sGroupNum +"_03");
        oWP4 = GetNearestObjectByTag("WPA3_FOLLOW_"+ sGroupNum +"_04");
        oWP5 = GetNearestObjectByTag("WPA3_FOLLOW_"+ sGroupNum +"_05");

        if (iUnDead >= 50)
        {
            sNPCTag1 = GetLocalString(oModule, "NPC_CREW_DEAD1");
            sNPCTag2 = GetLocalString(oModule, "NPC_CREW_DEAD2");
            sNPCTag3 = GetLocalString(oModule, "NPC_CREW_DEAD3");
            sNPCTag4 = GetLocalString(oModule, "NPC_CREW_DEAD4");
            sNPCTag5 = GetLocalString(oModule, "NPC_CREW_DEAD5");
        }
        else
        {
            sNPCTag1 = GetLocalString(oModule, "NPC_CREW1");
            sNPCTag2 = GetLocalString(oModule, "NPC_CREW2");
            sNPCTag3 = GetLocalString(oModule, "NPC_CREW3");
            sNPCTag4 = GetLocalString(oModule, "NPC_CREW4");
            sNPCTag5 = GetLocalString(oModule, "NPC_CREW5");
        }

        oNPC1 = GetObjectByTag(sNPCTag1);
        oNPC2 = GetObjectByTag(sNPCTag2);
        oNPC3 = GetObjectByTag(sNPCTag3);
        oNPC4 = GetObjectByTag(sNPCTag4);
        oNPC5 = GetObjectByTag(sNPCTag5);

        //Debug("OBJECT NPC1:" + GetTag(oNPC1) + "; NPC2:" + GetTag(oNPC2)
        //    + "; NPC3:" + GetTag(oNPC3) + "; NPC4:" + GetTag(oNPC4)
        //    + "; NPC5:" + GetTag(oNPC5) + ".");


        if (GetLocalInt(oNPC1, "STATIONED") == FALSE)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC1, 10.0f);
            AssignCommand(oNPC1, ClearAllActions(TRUE));

            if (GetIsInCombat(oPC) == FALSE)
                AssignCommand(oNPC1, ActionForceMoveToObject(oWP1, TRUE, 0.5f, 10.0f));
            else
                AssignCommand(oNPC1, ActionForceMoveToObject(oPC, TRUE, 15.0f, 10.0f));
        }
        if ((GetLocalInt(oNPC2, "STATIONED") == FALSE)&& (GetIsInCombat(oNPC2) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC2, 10.0f);
            AssignCommand(oNPC2, ClearAllActions(TRUE));

            if (GetIsInCombat(oPC) == FALSE)
                AssignCommand(oNPC2, ActionForceMoveToObject(oWP2, TRUE, 0.5f, 10.0f));
            else
                AssignCommand(oNPC2, ActionForceMoveToObject(oPC, TRUE, 15.0f, 10.0f));

        }
        if ((GetLocalInt(oNPC3, "STATIONED") == FALSE) && (GetIsInCombat(oNPC3) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC3, 10.0f);
            AssignCommand(oNPC3, ClearAllActions(TRUE));

            if (GetIsInCombat(oPC) == FALSE)
                AssignCommand(oNPC3, ActionForceMoveToObject(oWP3, TRUE, 0.5f, 10.0f));
            else
                AssignCommand(oNPC3, ActionForceMoveToObject(oPC, TRUE, 15.0f, 10.0f));

        }
        if ((GetLocalInt(oNPC4, "STATIONED") == FALSE) && (GetIsInCombat(oNPC4) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC4, 10.0f);
            AssignCommand(oNPC4, ClearAllActions(TRUE));

            if (GetIsInCombat(oPC) == FALSE)
                AssignCommand(oNPC4, ActionForceMoveToObject(oWP4, TRUE, 0.5f, 10.0f));
            else
                AssignCommand(oNPC4, ActionForceMoveToObject(oPC, TRUE, 15.0f, 10.0f));

        }
        if ((GetLocalInt(oNPC5, "STATIONED") == FALSE) && (GetIsInCombat(oNPC5) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC5, 10.0f);
            AssignCommand(oNPC5, ClearAllActions(TRUE));

            if (GetIsInCombat(oPC) == FALSE)
                AssignCommand(oNPC5, ActionForceMoveToObject(oWP5, TRUE, 0.5f, 10.0f));
            else
                AssignCommand(oNPC5, ActionForceMoveToObject(oPC, TRUE, 15.0f, 10.0f));

        }
    }
}

void Debug(string sMSG)
{
    /*object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC) == TRUE)
    {
        //SendMessageToPC(oPC, sMSG);
        oPC = GetNextPC();
    }*/
}
