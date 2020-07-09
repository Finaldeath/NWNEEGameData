// user-defined event for illefarn mirrors when struck by a beam of light

#include "hf_in_xp"

// return true if f1 and f2 are approximately equal
int FloatEquals(float f1, float f2)
{
    if ((abs(FloatToInt(f1-f2))<=10))
    {
        return(TRUE);
    }
    return (FALSE);
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if  (nEvent == 501) // hit by beam
    {
        // unlock door if this is the last terminus
        if (GetLocalInt(OBJECT_SELF, "nLastMirror"))
        {
            object oDoor = GetNearestObjectByTag("EXIT_AR2501_AR2501D");

            effect eVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
            DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDoor));
            DelayCommand(4.7, SetLocked(oDoor, FALSE));
            DelayCommand(5.0, ActionOpenDoor(oDoor));

            // player needs an update, quest complete
            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            if (GetIsObjectValid(oPC))
            {
                string sJournal = "j90";
                int nStatus = 10;

                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                if (GetLocalInt(oPC, sJournalVar) < nStatus)
                {
                    AddJournalQuestEntry(sJournal, nStatus, oPC);
                    int nXP = GetJournalQuestExperience(sJournal);
                    GiveQuestXPToCreature(oPC, sJournal, 100.0);
                }
            }
        }

        // do nothing if no mirror is attached
        if (GetLocalInt(OBJECT_SELF, "nActivated") == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), OBJECT_SELF);
            return;
        }

        // update journal if this is the first time
        if (GetLocalInt(OBJECT_SELF, "nFirstMirror"))
        {
            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            if (GetIsObjectValid(oPC))
            {
                string sJournal = "j90";
                int nStatus = 1;

                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                if (GetLocalInt(oPC, sJournalVar) < nStatus)
                {
                    AddJournalQuestEntry(sJournal, nStatus, oPC);
                }
            }
        }

        // find my mirror facing (opposite of stand facing)
        //float fMyFacing = GetFacing(OBJECT_SELF) + 180.0;
        //if (fMyFacing >= 360.0) fMyFacing -= 360.0;
        float fMyFacing = GetFacing(OBJECT_SELF);

        // lookup reflection target(s)
        int nTarget;
        float fTargetFacing = GetLocalFloat(OBJECT_SELF, "fGoodFacing");
        if (FloatEquals(fMyFacing, fTargetFacing))
            nTarget = GetLocalInt(OBJECT_SELF, "nGoodTarget");
        else
            nTarget = GetLocalInt(OBJECT_SELF, "nBadTarget");

        // draw beam to target mirror
        string sTag = "bw_mirror_" + IntToString(nTarget);
        object oHitObject = GetNearestObjectByTag(sTag);
        if (GetIsObjectValid(oHitObject))
        {
            effect eBeam = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oHitObject, 5.0f);
            SignalEvent(oHitObject, EventUserDefined(501));
        }
        else
        {
            SendMessageToPC(GetFirstPC(), "ERROR: invalid mirror " + sTag);
        }
    }
}

/*
 MIRROR:
 - nFirstMirror   = set to 1 if this is the first mirror in the chain
 - nLastMirror    = set to 1 if this is the last mirror in the chain
 - fBeamDirection = direction of last beam to hit this mirror
 - nNextMirror_N  = beams reflected north from current mirror will hit this mirror
 - nNextMirror_E  = beams reflected east from current mirror will hit this mirror
 - nNextMirror_S  = beams reflected south from current mirror will hit this mirror
 - nNextMirror_W  = beams reflected west from current mirror will hit this mirror
*/
