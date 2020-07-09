//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_onehand3
// DATE: November 27, 2005.
// AUTH: Luke Scull
// NOTE: Appears if player left companions behind when
//       entering Hillsfar.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

const string LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR   = "p_hil_autod_astar";
const string LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH = "p_hil_autod_eremu";
const string LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA = "p_hil_autod_lyres";


int HadHenchmenPreHillsfar(object oPC)
{
    return ( (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR) >= 1) ||
             (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH) >= 1) ||
             (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA) >= 1) );
}


int StartingConditional()
{
    return (HadHenchmenPreHillsfar(GetPCSpeaker()));
}
