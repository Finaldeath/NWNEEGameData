//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_die
//:: DATE: December 29, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Kills creature the PC is conversing with
//::////////////////////////////////////////////////////

void main()
{
    object oNPC = OBJECT_SELF;
    effect eDeath = EffectDeath();

    SetPlotFlag(oNPC, FALSE);
    SetImmortal(oNPC, FALSE);

    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oNPC));
}
