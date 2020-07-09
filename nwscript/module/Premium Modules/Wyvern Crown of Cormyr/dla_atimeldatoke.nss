// Sets Imelda's current blackmail price token. This is called from all of Imelda's dla_atimeldaoXXX scripts.

void main()
{
    object oPC = GetPCSpeaker();
    int nOffer = GetLocalInt(oPC,"nIOffer");
    if (nOffer <1) nOffer = 2000;
    SetCustomToken(1025,IntToString(nOffer));
}
