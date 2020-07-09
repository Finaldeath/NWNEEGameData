//Player discovers bodies of Bennart and Lashan

#include "hf_in_alignment"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nEntered") == 0) &&
       GetLocalInt(OBJECT_SELF, "nLashanDead") == 1)
    {
        int nXP;

        SetLocalInt(OBJECT_SELF, "nEntered", 1);

        //Updated journal and award half quest completion xp
        AddJournalQuestEntry("LocktowerRescue", 107, oPC);
        nXP = GetJournalQuestExperience("LocktowerRescue") / 2;
        GiveXPToCreature(oPC, nXP);

        //Adjust evil alignment by 5
        AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 5);
    }
}
