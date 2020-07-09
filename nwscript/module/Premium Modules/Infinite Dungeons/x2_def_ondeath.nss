//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    // objects being cleaned up dont count
    if (GetLocalInt(OBJECT_SELF, "bClean") == TRUE)
    {
        return;
    }

    DebugMessage("");
    DebugMessage("Object is not being cleaned.");

    int nObjectType = GetObjectType(OBJECT_SELF);
    if (nObjectType == OBJECT_TYPE_CREATURE)
    {
        string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
        DebugMessage("Object is a creature with variable " + sVariable);
        object oDungeon = GetCurrentDungeon();

        // mark creature as dead
        SetLocalInt(oDungeon, "b" + sVariable + "Dead", TRUE);

        int nType = GetLocalInt(oDungeon, "n" + sVariable);
        DebugMessage("My type is " + IntToString(nType));

        int nPlotNum = GetLocalInt(oDungeon, "nPlotNum");

        // check to see if a plotgiver just died
        string sConversation = GetLocalString(OBJECT_SELF, "sConversation");
        DebugMessage("sConversation is " + sConversation);
        if (sConversation == "id1_plotgiver")
        {
            int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
            string sPlot = "Plot" + IntToString(nPlot);

            // if the plot is not already completed, fail it
            if (GetLocalInt(oDungeon, "b" + sPlot + "Completed") == FALSE)
            {
                SetLocalInt(oDungeon, "b" + sPlot + "Failed", TRUE);

                // create microprocess to inform all quest recipients
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU119");
                SetLocalInt(oMicroCPU, "nPlot", nPlot);
                SetLocalString(oMicroCPU, "sMessage", "Plot giver killed. Quest failed.");

                DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
            }
        } else if (sConversation == "id1_plotdest") // if it was a plot destination
        {
            int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
            string sPlot = "Plot" + IntToString(nPlot);

            // if the plot is not already completed, fail it
            if (GetLocalInt(oDungeon, "b" + sPlot + "Completed") == FALSE)
            {
                SetLocalInt(oDungeon, "b" + sPlot + "Failed", TRUE);

                // create microprocess to inform all quest recipients
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU120");
                SetLocalInt(oMicroCPU, "nPlot", nPlot);
                SetLocalString(oMicroCPU, "sMessage", "Plot destination killed. Quest failed.");

                DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
            }
        }

        int nGameplayType;
        int nCreatureType;
        string sPlot;
        int nKilled;
        int bActivated;
        int bCompleted;
        int bFailed;
        int bInvolved;
        object oMicroCPU;
        int nPlotArea;

        object oArea = GetArea(OBJECT_SELF);
        int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
        int nArea = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

        int nCurrentLevel = GetCurrentLevel();

        object oKiller = GetLastKiller();

        // if this is a follower
        if (GetIsPC(oKiller) == FALSE)
        {
            oKiller = GetMaster(oKiller);
        }

        string sIdentifier = GetPCIdentifier(oKiller);

        // if creature was involved in a plot
        int nPlot = 1;
        while (nPlot <= nPlotNum)
        {
            sPlot = "Plot" + IntToString(nPlot);

            DebugMessage("Examining " + sPlot);

            // if plot has been activated
            bActivated = GetLocalInt(oDungeon, "b" + sPlot + "Activated");
            if (bActivated == TRUE)
            {
                DebugMessage("  Quest has been activated.");

                // if plot has not been completed already
                bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
                if (bCompleted == FALSE)
                {
                    DebugMessage("  Quest has not been completed.");

                    // if the plot has not been failed already
                    bFailed = GetLocalInt(oDungeon, "b" + sPlot + "Failed");
                    if (bFailed == FALSE)
                    {
                        DebugMessage("  Quest has not been failed.");

                        bInvolved = GetLocalInt(oDungeon, "b" + sPlot + "Player_" + sIdentifier);
                        DebugMessage("   b" + sPlot + "Player_" + sIdentifier + " is " + IntToString(bInvolved));
                        if (bInvolved == TRUE)
                        {
                            DebugMessage("    Killer is involved in the quest.");

                            nGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
                            DebugMessage("      GameplayType is " + IntToString(nGameplayType));

                            if (nGameplayType == 1) // kill creatures
                            {
                                if (GetIsPC(oKiller) == TRUE)
                                {
                                    nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                                    DebugMessage("        Needed creature is " + IntToString(nCreatureType));

                                    if (nCreatureType == nType)
                                    {
                                        DebugMessage("        Creature type matches.");

                                        nKilled = GetLocalInt(oDungeon, "n" + sPlot + "CreaturesKilled");
                                        nKilled++;
                                        SetLocalInt(oDungeon, "n" + sPlot + "CreaturesKilled", nKilled);
                                        DebugMessage("        Set n" + sPlot + "CreaturesKilled to " + IntToString(nKilled));

                                        // create microprocess to inform all quest recipients
                                        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU121");
                                        SetLocalInt(oMicroCPU, "nPlot", nPlot);
                                        SetLocalString(oMicroCPU, "sMessage", "Plot creature killed.");

                                        DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
                                    } else
                                    {
                                        DebugMessage("        Creature type does not match.");
                                    }
                                } else
                                {
                                    DebugMessage("       Killer is not a PC or henchman.");
                                }
                            }
                        } else
                        {
                            DebugMessage("    Killer is not involved in the plot.");
                        }

                        if (nGameplayType == 2) // clear areas
                        {
                            // check to see if this area is involved in the quest
                            nPlotArea = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nCurrentLevel) + "Area_" + IntToString(nArea));
                            DebugMessage("        Checking n" + sPlot + "Level" + IntToString(nCurrentLevel) + "Area_" + IntToString(nArea));
                            if (nPlotArea > 0)
                            {
                                DebugMessage("       Area is involved in this plot.");

                                // check to see if all creatures have been killed
                                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU122");
                                SetLocalInt(oMicroCPU, "nPlot", nPlot);
                                SetLocalInt(oMicroCPU, "nArea", nArea);
                                SetLocalObject(oMicroCPU, "oArea", oArea);
                                SetLocalInt(oMicroCPU, "nLevel", nCurrentLevel);
                                SetLocalObject(oMicroCPU, "oSelf", OBJECT_SELF);

                                DelayCommand(0.01, ExecuteScript("exe_id1_micplot2", oMicroCPU));
                            } else
                            {
                                DebugMessage("       Area is not involved in this plot.");
                            }
                        }
                    } else
                    {
                        DebugMessage("    Quest has been failed already.");
                    }
                } else
                {
                    DebugMessage("    Quest has been completed already.");
                }
            } else
            {
                DebugMessage("  Quest has not been activated.");
            }

            // cycle to next plot
            nPlot++;
        }
    } else
    {
        DebugMessage("  Object is not a creature.");
    }

    DebugMessage("Checking for teleporter.");
    object oDungeon = GetCurrentDungeon();
    if (GetLocalInt(oDungeon, "bBossTeleporter") == FALSE)
    {
        // check to see if this is a boss area
        object oArea = GetArea(OBJECT_SELF);
        string sTag = GetTag(oArea);
        string sSubTag = GetSubString(sTag, 0, 8);
        DebugMessage("Tag is " + sTag + " and subtag is " + sSubTag);
        if (sSubTag == "BossArea")
        {
            sSubTag = GetSubString(sTag, 8, 1);
            DebugMessage("  Subtag is " + sSubTag);
            if (sSubTag != "_")
            {
                // check for hostiles and reveal boss teleporter if none exist
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU123");
                SetLocalObject(oMicroCPU, "oArea", oArea);
                SetLocalObject(oMicroCPU, "oSelf", OBJECT_SELF);
                DelayCommand(0.01, ExecuteScript("exe_id1_mictelep", oMicroCPU));
            }
        }
    }

    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_death", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_default7", OBJECT_SELF);
    }

    // spawn treasure on death
    SetLocalObject(OBJECT_SELF, "oContainer", OBJECT_SELF);
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    SetLocalString(OBJECT_SELF, "sLevel", sVariable);
    string sTag = GetLocalString(OBJECT_SELF, "sTag");
    SetLocalString(OBJECT_SELF, "sTag", sTag);
    SetLocalObject(OBJECT_SELF, "oDungeon", oDungeon);
    SetLocalInt(OBJECT_SELF, "bCreature", TRUE);
    ExecuteScript("exe_id1_micloot", OBJECT_SELF);
}
