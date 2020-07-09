// return true if the player has not accepted the mad miller quest

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(GetLocalInt(oPC, "ac_miller_quest") == 0);
}

