
const string LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR   = "p_hil_autod_astar";
const string LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH = "p_hil_autod_eremu";
const string LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA = "p_hil_autod_lyres";


int HadHenchmenPreHillsfar(object oPC)
{
    return ( (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR) >= 1) ||
             (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH) >= 1) ||
             (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA) >= 1) );
}

void main()
{
    object oPC = GetEnteringObject();

    if ( GetIsPC(oPC) &&
         (GetLocalInt(OBJECT_SELF, "nDone") <= 0) &&
         (GetLocalInt(oPC, "henchmengonetoelventree") == 1) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        if (HadHenchmenPreHillsfar(oPC))
            AssignCommand(oPC, SpeakString("There is no sign of your companions. You should press on to Elventree; perhaps, with any luck, they've already made their way there."));
    }
}

