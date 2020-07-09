void main()
{
object oPC = GetPCSpeaker();

object oSharalyn = GetObjectByTag("SharalynElventree");

object oSentinel = GetObjectByTag("TheSentinel");

object oHilrad = GetObjectByTag("HilradthePatient");

object oLyressa = GetObjectByTag("Lyressa");

AssignCommand(oLyressa, SetFacingPoint(GetPosition(oPC)));

AssignCommand(oSharalyn, SetFacingPoint(GetPosition(oPC)));

AssignCommand(oSentinel, SetFacingPoint(GetPosition(oPC)));

AssignCommand(oHilrad, SetFacingPoint(GetPosition(oPC)));
}
