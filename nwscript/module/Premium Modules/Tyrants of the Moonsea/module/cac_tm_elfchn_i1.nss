//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_elfchn_i1
//:: DATE: February 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Elf In Chains - Ilandra Dialog
//:: Ilandra tells the PC about Elf's whereabouts
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("ElfinChains", 11, oPC);
}
