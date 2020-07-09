//flavour text pop up
//Phil Mitchell (Baron of Gateford)
void main()
{
object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == TRUE && GetLocalInt(GetModule(),"rab_plot")==50) {

        AssignCommand(oPC,SpeakString("Rab seems to have left his house hastily."));
        }
}
