// B W-Husey

//Set up Edgar's token

void main()
{
    object oPC = GetPCSpeaker();
        if (GetGender(OBJECT_SELF)==GENDER_MALE)
        {
        SetCustomToken(1020,GetName(oPC)+", my friend");
        }
        else
        {
        SetCustomToken(1020,"My Lady "+GetName(oPC));
        }
}
