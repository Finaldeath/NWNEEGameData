////////////////////////////////////////////////////////////////////////////////
// fixappearance - Hot Fix 1 - Appearance fix console command
// By Deva B. Winblood  9/19/2006
////////////////////////////////////////////////////////////////////////////////

void main()
{
   object oMe=OBJECT_SELF;
   int nApp;
   int nRT=GetRacialType(oMe);
   if (nRT==RACIAL_TYPE_DWARF) nApp=APPEARANCE_TYPE_DWARF;
   else if (nRT==RACIAL_TYPE_DWARF) nApp=APPEARANCE_TYPE_ELF;
   else if (nRT==RACIAL_TYPE_ELF) nApp=APPEARANCE_TYPE_ELF;
   else if (nRT==RACIAL_TYPE_HALFELF) nApp=APPEARANCE_TYPE_HALF_ELF;
   else if (nRT==RACIAL_TYPE_HALFLING) nApp=APPEARANCE_TYPE_HALFLING;
   else if (nRT==RACIAL_TYPE_HALFORC) nApp=APPEARANCE_TYPE_HALF_ORC;
   else if (nRT==RACIAL_TYPE_GNOME) nApp=APPEARANCE_TYPE_GNOME;
   else { nApp=APPEARANCE_TYPE_HUMAN; }
   SetCreatureAppearanceType(oMe,nApp);
   SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oMe);
   SetPhenoType(PHENOTYPE_NORMAL,oMe);
   SendMessageToPC(oMe,"fixappearance has been executed.  Hopefully, you appear properly and can now mount and dismount horses.");
}
