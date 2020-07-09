// the player has entered the grove
// ... the fowls jump out of your pack

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        location lLoc = GetLocation(oPC);
        object oTatham = GetNearestObjectByTag("ks_druid_gull", oPC);
        object oArea = GetArea(oPC);

        object oChicken = GetItemPossessedBy(oPC, "a2_chicken");
        if (GetIsObjectValid(oChicken))
        {
            // chicken jumps out of your pack
            FloatingTextStringOnCreature("The chicken in your pack leaps out.", oPC);
            DestroyObject(oChicken);
            oChicken = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_chick", lLoc);
            PlotLevelSet("ks_druid_chick", 3);
            SetLocalInt(oArea, "nChickenBack", 1);

            // chicken rushes over to tatham
            AssignCommand(oChicken, SpeakString("Tatham! *BecaW!* Speak to me!"));
            AssignCommand(oChicken, PlaySound("as_an_chickens1"));
            AssignCommand(oChicken, ActionMoveToObject(oTatham, TRUE, 0.5));
            SetLocalInt(oChicken, "HF_SEEK_TATHAM", 1);
        }

        object oPenguin = GetItemPossessedBy(oPC, "a2_penguin");
        if (GetIsObjectValid(oPenguin))
        {
            // penguin jumps out of your pack
            FloatingTextStringOnCreature("The penguin in your pack leaps out.", oPC);
            DestroyObject(oPenguin);
            oPenguin = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_peng", lLoc);
            PlotLevelSet("ks_druid_peng", 3);
            PlotLevelSet("ks_druid_gull", 3);
            SetLocalInt(oArea, "nPenguinBack", 1);

            // penguin greets tatham
            AssignCommand(oPenguin, SpeakString("Tatham! Help! I'm a penguin!"));
            AssignCommand(oPenguin, PlaySound("c_penguin_hit1"));
            AssignCommand(oPenguin, ActionMoveToObject(oTatham, TRUE, 2.0));
            SetLocalInt(oPenguin, "HF_SEEK_TATHAM", 1);
        }

        object oParrot = GetItemPossessedBy(oPC, "a2_parrot");
        if (GetIsObjectValid(oParrot))
        {
            // parrot jumps out of your pack
            FloatingTextStringOnCreature("The parrot in your pack leaps out.", oPC);
            DestroyObject(oParrot);
            oParrot = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_parrot", lLoc);
            PlotLevelSet("ks_druid_parrot", 3);
            PlotLevelSet("ks_druid_gull", 5);
            SetLocalInt(oArea, "nParrotBack", 1);

            // parrot greets tatham
            AssignCommand(oParrot, SpeakString("Tatham! It's me, Wanix!"));
            AssignCommand(oParrot, PlaySound("c_parrot_sel"));
            AssignCommand(oParrot, ActionMoveToObject(oTatham, TRUE, 2.0));
            SetLocalInt(oPenguin, "HF_SEEK_TATHAM", 1);
        }
    }
}
