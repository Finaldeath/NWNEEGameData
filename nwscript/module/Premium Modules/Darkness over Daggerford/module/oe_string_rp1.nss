//flavour text pop up
//Phil Mitchell (Baron of Gateford)
void main()
{
object oPC = GetEnteringObject();

if(GetIsPC(oPC) == TRUE) {
    string sString = GetName(OBJECT_SELF);
    string sVal = GetStringLeft(sString, 6);
    string sVar = GetStringRight(sString, 6);
    string sTest = GetLocalString(oPC, sVar);

    if(sTest != sVal) {
        //do once
        SetLocalString(oPC, sVar, sVal);
        //flavor text
        AssignCommand(oPC,SpeakString("The house positively reeks of garlic despite the strong breeze blowing through an open window."));
        }
    }
}
