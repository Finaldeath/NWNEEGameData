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
        AssignCommand(oPC,SpeakString("Clearly the goblins use this area for sleeping. As the inhabitants see you approach, they scowl and gnash their goblin fangs."));
        }
    }
}
