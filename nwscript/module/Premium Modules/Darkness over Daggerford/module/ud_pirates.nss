#include "NW_I0_GENERIC"
void main()

{

    //perecive PC - speakstring
    //damian 16th Feb 06
    object oPC=GetLastPerceived();
    if(GetIsPC(oPC)&&GetLastPerceptionSeen()||GetLastPerceptionHeard()
       &&GetLocalInt(OBJECT_SELF,"firstmate_active")!=1)
       {
            string q = GetLocalString(GetModule(), "QUOTE");
            SetLocalInt(OBJECT_SELF,"firstmate_active",1);
            ClearAllActions();
            SpeakString(q+"Hurry up unloading those..."+q);
            DelayCommand(4.0,SpeakString(q+"Wait a minute...to arms, lads!"+q));
            DelayCommand(4.5,ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_HOSTILE));
            object oPirate1=GetObjectByTag("db_barracudarog");
            DelayCommand(4.5,ChangeToStandardFaction(oPirate1,STANDARD_FACTION_HOSTILE));
            object oPirate2=GetObjectByTag("db_barracudacleric");
            DelayCommand(4.5,ChangeToStandardFaction(oPirate2,STANDARD_FACTION_HOSTILE));
            DelayCommand(5.0,DetermineCombatRound(oPC));
            DelayCommand(5.0,AssignCommand(oPirate1,DetermineCombatRound(oPC)));
            DelayCommand(5.0,AssignCommand(oPirate2,DetermineCombatRound(oPC)));
        }
}
