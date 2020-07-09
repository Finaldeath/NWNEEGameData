//sets that the pc has pesuaded Astriel to pay more for the missions
//Author: Damian Brown (Luspr)
//Date: 27-07-2005
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "astriel_persuade_true", 1);
}
