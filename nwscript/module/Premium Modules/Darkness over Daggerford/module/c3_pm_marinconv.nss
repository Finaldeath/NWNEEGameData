//c3_pm_marineconv
//This script is placed on the onenter event of a trigger in the mariners alliance basement
//it will start a conversation with two invisible objects placed near a door
//to give the illusion of talking coming from behind it.
//
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
    object oPC = GetEnteringObject();
    object oNPC1 = GetNearestObjectByTag("pm_firstvoice",oPC,1);
    object oNPC2 = GetNearestObjectByTag("pm_secondvoice",oPC,1);

    if (GetIsPC(oPC) && !GetLocalInt(OBJECT_SELF,"trigger_fired"))
    {
        string q = GetLocalString(GetModule(), "QUOTE");
        SetLocalInt(OBJECT_SELF, "trigger_fired",1);
        AssignCommand(oNPC1,ClearAllActions());
        AssignCommand(oNPC2,ClearAllActions());

        AssignCommand(oNPC1,SpeakString(q+"The shipments of armor have been moving well."+q));

        DelayCommand(5.0,AssignCommand(oNPC2,SpeakString(q+"Aye, and without any unfortunate mishaps."+q)));

        DelayCommand(10.0,AssignCommand(oNPC1, SpeakString(q+"The barges have transferred all their cargo to the ships."+q)));

        DelayCommand(15.0,AssignCommand(oNPC2, SpeakString(q+"And all under the cover of darkness!"+q)));

        DelayCommand(20.0,AssignCommand(oNPC1, SpeakString(q+"Let us hope that all goes smoothly."+q)));
    }
}
