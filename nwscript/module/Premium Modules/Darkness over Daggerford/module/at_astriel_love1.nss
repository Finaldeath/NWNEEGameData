void main()
{
    //flag Astriel as 'romantically inclined' towards the pc
    //for possible use in throne room scene
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "astriel_charmed", 1);
}
