//::///////////////////////////////////////////////
//::
//:: a3_bw_ou_port
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Use script for placeables.
//::
//:: Send PC to associated waypoint.
//:: Waypoint tag is: wp_<this object's tag>
//:: Waypoint should be in *another area*
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/9/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_xp"

void main()
{
    object oUser = GetLastUsedBy();

    if (!GetIsObjectValid(oUser)) oUser = GetEnteringObject();

    if (GetIsPC(oUser))
    {
        if (GetLocalInt(OBJECT_SELF, "nOpen") == 0)
        {
            // open-able objects should have 'sdoor' or 'strap' in
            // their tag, so this animation will play the first
            // time this object is used
            if ((FindSubString(GetTag(OBJECT_SELF), "sdoor") != -1) ||
                (FindSubString(GetTag(OBJECT_SELF), "strap") != -1) ||
                (FindSubString(GetTag(OBJECT_SELF), "minew") != -1))
            {
                PlayAnimation(ANIMATION_PLACEABLE_OPEN);
                SetLocalInt(OBJECT_SELF, "nOpen", 1);
                return;
            }
        }

        // some mine platforms are broken
        if (FindSubString(GetTag(OBJECT_SELF), "minepb") != -1)
        {
            FloatingTextStringOnCreature("This platform is not working.", oUser);
            return;
        }

        string sWP = ("wp_" + GetTag(OBJECT_SELF));
        object oWP = GetWaypointByTag(sWP);
        if (GetIsObjectValid(oWP))
        {
            AssignCommand(oUser, ClearAllActions());

            // special case effects, etc. here:
            if (FindSubString(GetTag(OBJECT_SELF), "pool") != -1)
            {
                PlaySound("as_na_splash1");
            }
            else if (FindSubString(GetTag(OBJECT_SELF), "portal") != -1)
            {
                SetLocalInt(oUser, "nIH_Ported", 1);
                PlaySound("as_mg_telepout1");
            }
            else if ((FindSubString(GetTag(OBJECT_SELF), "minep") != -1) ||
                     (FindSubString(GetTag(OBJECT_SELF), "minew") != -1))
            {
                PlaySound("as_cv_minercar1");
            }

            if ((FindSubString(GetTag(OBJECT_SELF), "sdoor") != -1) ||
                (FindSubString(GetTag(OBJECT_SELF), "strap") != -1))
            {
                if (GetLocalInt(OBJECT_SELF, "nUsed") == 0)
                {
                    // check for journal update
                    string sJournal = "j91"; // relevant quest
                    int nStatus = 1;        // status

                    int nTotalSecrets = 9; // this is the number of secret doors in Illefarn

                    int nSecretDoors = GetLocalInt(GetModule(), "nIH_SecretsFound");
                    nSecretDoors += 1;
                    SetLocalInt(GetModule(), "nIH_SecretsFound", nSecretDoors);

                    if (nSecretDoors >= nTotalSecrets) // no secret doors left
                    {
                        nStatus = 10;        // status: complete
                    }

                    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                    if (GetLocalInt(oUser, sJournalVar) < nStatus)
                    {
                        // player needs an update
                        AddJournalQuestEntry(sJournal, nStatus, oUser, FALSE);

                        // player may need XP for quest completion
                        int nXP = GetJournalQuestExperience(sJournal);
                        if ((nXP > 0) && (nStatus == 10))
                        {
                            //GiveXPToCreature(oUser, nXP);
                            GiveQuestXPToCreature(oUser, sJournal, 100.0);
                        }
                    }

                    SetLocalInt(OBJECT_SELF, "nUsed", 1);
                }
            }

            location lLoc = GetLocation(oWP);
            AssignCommand(oUser, JumpToLocation(lLoc));
        }
    }
}
