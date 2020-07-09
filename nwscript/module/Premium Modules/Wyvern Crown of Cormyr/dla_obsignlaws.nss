// B W-Husey
// September 2005
// Clicked object floats text to denote the description should be read.

void main()
{
    object oPC = GetLastUsedBy();
    FloatingTextStringOnCreature("This sign carries the laws of Cormyr. Examine the sign for more detail",oPC,FALSE);
}
