//OnEnter script for trigger near to Subterranean Lair illusion

#include "x0_i0_match"

void main()
{
    int nRanks;

    object oController = GetNearestObjectByTag("IllusionController");
    object oPC = GetEnteringObject();
    object oPixie;

    if(GetLocalInt(oController, "nIllusionDispelled") == 1)
    {
        return;
    }

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);

        //Pixie welcomes PC
        oPixie = GetNearestObjectByTag("ElmwoodPixie1", oPC);
        AssignCommand(oPixie, ClearAllActions());
        AssignCommand(oPixie, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oPixie, SpeakString("Welcome! Come and play with us!"));

        //Perform Spellcraft skill check to determine if illusion recognised
        nRanks = GetSkillRank(SKILL_SPELLCRAFT, oPC);
        if(nRanks > 0)
        {
            if(GetSkillRank(SKILL_SPELLCRAFT, oPC) + d20() >= 15)
            {
                AssignCommand(oPC,
                    SpeakString("Spellcraft Success: 150xp! You detect that " +
                                "the scene before you is a powerful illusion."));
                GiveXPToCreature(oPC, 150);

                return;
            }
        }

        //Gnomes detect the illusion
        if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)
        {
            AssignCommand(oPC,
                SpeakString("150xp! Your gnome intuition tells you that there is an illusion at work here."));
            GiveXPToCreature(oPC, 150);
            return;
        }

        //True Seeing detects the illusion
        if(GetHasEffect(EFFECT_TYPE_TRUESEEING, oPC) || GetHasSpellEffect(SPELL_TRUE_SEEING))
        {
            AssignCommand(oPC,
                SpeakString("True Seeing reveals that the scene before you is " +
                            "an illusion masking will-o-wisps and a large plant."));
        }
    }
}
