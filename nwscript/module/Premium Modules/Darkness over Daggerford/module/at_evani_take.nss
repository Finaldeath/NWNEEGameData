//return the fantabulizer component to Evani
void main()
{
    object oPC=GetPCSpeaker();
    object oComponent=GetItemPossessedBy(oPC,"db_component");
        if(GetIsObjectValid(oComponent)!= 0)
        {
            DestroyObject(oComponent);
            GiveXPToCreature(oPC,500);
            FloatingTextStringOnCreature("Retrieved Fantabulizer component.",oPC);
            //cancel Evani's machine broken ambient animations
            SetLocalInt(GetModule(),"evani_fixed",1);
        }
        //set the machine as fixed
        SetLocalInt(GetModule(),"evani_fixed",1);
        //added after playtesting
        //flag fantabulizer as fixed
        SetLocalInt(GetModule(), "evani_plot", 10);
}
