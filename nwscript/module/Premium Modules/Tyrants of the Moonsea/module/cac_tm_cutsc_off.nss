//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_cutsc_off
//:: DATE: December 30, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Deactivate cutscene mode during dialogs
//:: Note: This is not intended for HF cutscenes !
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetCutsceneMode(oPC, FALSE);
}
