// userdefined script for red portal at bottom of hole

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 501) // summon nasty
    {
        if (!GetIsObjectValid(GetNearestObjectByTag("c_kocrachn", OBJECT_SELF, 6)))
        {
            effect ePulse = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, OBJECT_SELF);

            object oWP = GetNearestObjectByTag("wp_ar0807_sum");
            location lWP = GetLocation(oWP);
            object oCritter = CreateObject(OBJECT_TYPE_CREATURE, "c_kocrachn", lWP);

            AssignCommand(oCritter, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            PlaySound("c_vrock_atk1");

            // object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

            // AssignCommand(oCritter, SetFacing(240.0f));
        }
    }
}
