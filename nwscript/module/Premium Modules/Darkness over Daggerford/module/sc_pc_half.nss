//script: sc_pc_half
//Text appears if PC is a halfing.
//by Alan Tarrant (modified from existing script by Damian)
//12/10/05
//
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetRacialType(oPC)==RACIAL_TYPE_HALFLING)
    return TRUE;
    return FALSE;
}
