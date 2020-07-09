//cac_a3_necroatk

void main()
{
    object oKolmarr = OBJECT_SELF;
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oNPC;

    effect eVFX = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    string sMonster = "NECRO_MONSTER";
    int iCounter = 0;

    ChangeToStandardFaction(oKolmarr, STANDARD_FACTION_HOSTILE);
    AssignCommand(oKolmarr, ActionAttack(oPC, FALSE));

    while (iCounter < 5)
    {
        sMonster = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter+1));
        oNPC = GetObjectByTag(sMonster);

        DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oNPC));
        DelayCommand(1.1f, ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE));
        DelayCommand(1.3f, AssignCommand(oNPC, ActionAttack(oPC, FALSE)));

        iCounter++;
    }
}
