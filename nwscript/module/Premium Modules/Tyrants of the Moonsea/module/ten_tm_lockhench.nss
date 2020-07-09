//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_lockhench
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: If the player has entered the tower in disguise,
//       then show message that henchmen and followere
//       have been removed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC)) return;

    if (GetLocalInt(OBJECT_SELF, "fired") == 1)
        return;

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

    if (!(nInt == 70))
       return;

    if(GetLocalInt(oPC, "nHenchmenLeft") > 0)
    {
        AssignCommand(oPC,
            SpeakString("Your companions have returned to the Swords' Meet Inn to avoid drawing suspicion."));
        DeleteLocalInt(oPC, "nHenchmenLeft");
    }

    SetLocalInt(OBJECT_SELF, "fired", 1);
}
