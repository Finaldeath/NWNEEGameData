//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_merrik1
// DATE: November 1, 2005
// AUTH: Luke Scull
// NOTE: Merrik and Haliator face each other.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oMerrik = GetObjectByTag("Merrik");

object oCaptain = GetObjectByTag("CaptainHaliator");

AssignCommand(oMerrik, SetFacing(0.0));

AssignCommand(oCaptain, SetFacing(180.0));

}
