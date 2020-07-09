int nInt;
object oTarget;

void main()
{

object oPC = GetPCSpeaker();

ActionPauseConversation();

if ((GetRacialType(oPC)==RACIAL_TYPE_GNOME))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_ELF))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_DWARF))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALFLING));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFORC))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ORC));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFELF))
   {
   oTarget = oPC;

   nInt = GetObjectType(oTarget);

   ActionCastFakeSpellAtObject(SPELL_POLYMORPH_SELF, oPC);

   DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));

   DelayCommand(2.5, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ELF));
}
DeleteLocalInt(oPC, "HF_POLY_CREATURE_TYPE");
DelayCommand(3.0, ActionResumeConversation());
}

