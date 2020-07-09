//::///////////////////////////////////////////////
//::
//:: c2_oe_ar2505
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:: Play VFX on PC when teleported into grottos.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oEnterer = GetEnteringObject();

    if (GetLocalInt(oEnterer, "nIH_Ported") == 1)
    {
        DeleteLocalInt(oEnterer, "nIH_Ported");

        effect eVFX = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oEnterer);
    }

    if (GetIsPC(oEnterer))
    {
        // captain dratharion says his piece
        if (GetLocalInt(oEnterer, "nIH_HeardCapt") == 0)
        {
            object oBox = GetObjectByTag("ar2505_speakbox");
            if (GetLocalInt(oBox, "nSpeaking") == 0)
            {
                SetLocalInt(oBox, "nSpeaking", 1);

                DelayCommand(1.0, AssignCommand(oBox, PlaySound("as_pl_laughingm4")));
                DelayCommand(2.0, AssignCommand(oBox, SpeakString("Ha ha ha... It appears you find yourself in rather deep trouble, " + GetName(oEnterer) + "...")));
                DelayCommand(7.0, AssignCommand(oBox, PlaySound("as_pl_laughingm4")));
                DelayCommand(9.0, AssignCommand(oBox, SpeakString("I have heard the caverns below Illefarn are home to unspeakable horrors. You will discover the truth for yourself...")));
                DelayCommand(14.0, AssignCommand(oBox, PlaySound("as_pl_laughingm4")));
                DelayCommand(16.0, AssignCommand(oBox, SpeakString("You have taken far too much interest in our plans. The time has come for you to disappear...")));
                DelayCommand(21.0, AssignCommand(oBox, PlaySound("as_pl_laughingm4")));
                DelayCommand(23.0, AssignCommand(oBox, SpeakString("Scream if you like, no one will hear you all the way down there... Hah ha hah...")));

                DelayCommand(24.0, SetLocalInt(oBox, "nSpeaking", 0));

                SetLocalInt(oEnterer, "nIH_HeardCapt", 1);
            }
            else // captain is speaking
            {
                SetLocalInt(oEnterer, "nIH_HeardCapt", 1);
            }
        }

        // check for journal update
        string sJournal = "j17"; // relevant quest
        int nStatus = 8;          // status

        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
        if (GetLocalInt(oEnterer, sJournalVar) < nStatus)
        {
            // player needs an update
            AddJournalQuestEntry(sJournal, nStatus, oEnterer);
        }
    }
}
