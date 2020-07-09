////////////////////////////////////////////////////////////////////////////////
// dla_miscdeity - This will assign a suitable deity to PCs that do not have
//                 one.
// Scripted by Deva B. Winblood.   7/19/2006
////////////////////////////////////////////////////////////////////////////////
// If bNoDeityAutomation is set to 1 on the module object it will not execute
// this script.
////////////////////////////////////////////////////////////////////////////////
// Deities of Forgotten Realms most commonly worshipped in Corymyr.  From the
// 3rd Edition Forgotten Realms Campaign Setting page 111.
// Chauntea - NG - venerated by farmers, gardeners, commoner - clerics druids paladin
// Deneir -  NG - Good, Knowledge, Protection, Rune
// Helm - LN - Guardians, Protectors - paladin
// Lathander - NG - commoners, merchants, nobles, and young - Spring, Self-perfection
// Lliira - CG - Chaos, Charm, Family, Good, Travel
// Oghma - N - Any Character - Knowledge, Invention, Inspiration, Bards
// Malar - CE - Evil Lycanthropes, Hunters, Blood lust
// Milil - NG - Charm, Good, Knowledge, Nobility
// Selune - CG - Moon, Stars, Navigation, Wanderers, Questers, Good and Neutral Lycanthropes
// Silvanus - N - Wild Nature, Druids
// Tempus - CN - War, Battle, Warriors
// Tymora - CG - Good Fortune, Skill, Victory, Adventurers
// Waukeen - N - Trade, money, wealth
// Page 238 - Dwarves
// Moradin - LG     Dumathoin - N   Vergadain - N - Trickery
// Page 238 - Elves
// Corellon Larethian - CG
// Page 240 - Gnomes
// Garl Glittergold - LG      Callarduran Smoothhands - N
// Page 240 - Halflings
// Yondalla - LG       Sheela Peryroyl - N   Brandobaris - N - Trickery
// Page 240 - Orc
// Gruumsh - CE
// Page 25 - Paladin information
// Chauntea, Helm - deity must be LG, LN, or NG
// Modified 22nd July 2006, B G P Hughes
// Added Tyr & Torm, both missing and relevant
// In reality this function is a check, as missing deities are assigned by the previous script.
////////////////////////////////////////////////////////////////////////////////


string privateAlignmentString(int nAGE,int nALC);

////////////////////////////////////////////////////////////////////[ M A I N ]/
void main()
{
   object oPC=OBJECT_SELF;
   string sDeity="Unknown";
   int nRace=GetRacialType(oPC);
   int nClass=GetClassByPosition(1,oPC);
   int nAGE=GetAlignmentGoodEvil(oPC);
   int nALC=GetAlignmentLawChaos(oPC);
   string sAlign="NN";
   int nR; // random number holder

   if (!GetLocalInt(GetModule(),"bNoDeityAutomation") && GetDeity(oPC)=="")
   { // okay to do this

       sDeity="Oghma"; // It says this is good for any character
       sAlign=privateAlignmentString(nAGE,nALC);

       if (GetStringRight(sAlign,1)=="E")
       { // evil character

           if (GetStringLeft(sAlign,1)=="L")
           { // lawful

                nR=d4();
                if (nR==1) sDeity="Oghma";
                else if (nR==2) sDeity="Waukeen";
                else if (nR>2) sDeity="Helm";

           } // lawful
           else
           { // neutral or chaotic

               if (nRace==RACIAL_TYPE_HALFORC) sDeity="Gruumsh";
               if (nRace==RACIAL_TYPE_DWARF)
               { // dwarves

                   nR=d4();
                   if (nR==1) sDeity="Dumathoin";
                   else if (nR==2) sDeity="Vergadain";
                   else if (nR==3) sDeity="Malar";
                   else if (nR==4) sDeity="Waukeen";

               } // dwarves
               else if (nRace==RACIAL_TYPE_GNOME)
               { // gnomes

                    nR=d4();
                    if (nR==1) sDeity="Callarduran Smoothhands";
                    else if (nR==2) sDeity="Malar";
                    else if (nR==3) sDeity="Oghma";
                    else if (nR==4) sDeity="Waukeen";

               } // gnomes
               else if (nRace==RACIAL_TYPE_HALFLING)
               { // halflings

                    nR=d4();
                    if (nR==1) sDeity="Sheela Peryroyl";
                    else if (nR==2) sDeity="Brandobaris";
                    else if (nR==3) sDeity="Malar";
                    else if (nR==4) sDeity="Waukeen";

               } // halflings
               else
               { // other

                    nR=d6();
                    if (nR<3) sDeity="Malar";
                    else if (nR<5) sDeity="Oghma";
                    else if (nR==5) sDeity="Waukeen";
                    else if (nR==6) sDeity="Silvanus";

               } // other

           } // neutral or chaotic

       } // evil character
       else if (GetStringRight(sAlign,1)=="G")
       { // good character

            if (nClass==CLASS_TYPE_PALADIN)
            { // paladins

                 if (nRace==RACIAL_TYPE_DWARF)
                 { // dwarves

                      nR=d6();
                      if (nR<3) sDeity="Moradin";
                      else if (nR==3) sDeity="Chauntea";
                      else if (nR==4) sDeity="Helm";
                      else if (nR==5) sDeity="Lathander";
                      else if (nR==6) sDeity="Milil";

                 } // dwarves
                 else if (nRace==RACIAL_TYPE_GNOME)
                 { // gnomes

                      nR=d6();
                      if (nR<3) sDeity="Garl Glittergold";
                      else if (nR==3) sDeity="Chauntea";
                      else if (nR==4) sDeity="Helm";
                      else if (nR==5) sDeity="Lathander";
                      else if (nR==6) sDeity="Milil";

                 } // gnomes
                 else if (nRace==RACIAL_TYPE_HALFLING)
                 { // halflings

                      nR=d6();
                      if (nR<3) sDeity="Yondalla";
                      else if (nR==3) sDeity="Chauntea";
                      else if (nR==4) sDeity="Helm";
                      else if (nR==5) sDeity="Lathander";
                      else if (nR==6) sDeity="Milil";

                 } // halflings
                 else
                 { // other

                      nR=d8();
                      if (nR<3) sDeity="Helm";
                      else if (nR<5) sDeity="Chauntea";
                      else if (nR<7) sDeity="Lathander";
                      else if (nR==7) sDeity="Milil";
                      else if (nR==8) sDeity="Deneir";

                 } // other

            } // paladins
            else if (nClass==CLASS_TYPE_DRUID)
            { // druids

                 nR=d10();
                 if (nR==1) sDeity="Chauntea";
                 else if (nR==2) sDeity="Lathander";
                 else if (nR==3) sDeity="Oghma";
                 else if (nR==4) sDeity="Deneir";
                 else if (nR==5) sDeity="Milil";
                 else if (nR==6) sDeity="Waukeen";
                 else
                 {
                    sDeity="Silvanus";
                 }

            } // druids
            else
            { // other

                if (GetStringLeft(sAlign,1)=="L")
                { // lawful good

                     if (nR==RACIAL_TYPE_DWARF)
                     { // dwarves

                          nR=d4();
                          if (nR<3) sDeity="Moradin";
                          else if (nR==3) sDeity="Helm";
                          else if (nR==4) sDeity="Chauntea";

                     } // dwarves
                     else if (nR==RACIAL_TYPE_GNOME)
                     { // gnomes

                          nR=d4();
                          if (nR<3) sDeity="Garl Glittergold";
                          else if (nR==3) sDeity="Lathander";
                          else if (nR==4) sDeity="Chauntea";

                     } // gnomes
                     else if (nR==RACIAL_TYPE_HALFLING)
                     { // halflings

                          nR=d4();
                          if (nR<3) sDeity="Yondalla";
                          else if (nR==3) sDeity="Lathander";
                          else if (nR==4) sDeity="Chauntea";

                     } // halflings
                     else
                     { // other

                          nR=d6();
                          if (nR==1) sDeity="Chauntea";
                          else if (nR==2) sDeity="Helm";
                          else if (nR==3) sDeity="Lathander";
                          else if (nR==4) sDeity="Deneir";
                          else if (nR==5) sDeity="Milil";
                          else if (nR==6) sDeity="Oghma";

                     } // other

                } // lawful good
                else if (GetStringLeft(sAlign,1)=="C")
                { // chaotic good

                     if (nR==RACIAL_TYPE_ELF)
                     { // elf

                          nR=d6();
                          if (nR<3) sDeity="Corellon Larethian";
                          else if (nR==3) sDeity="Selune";
                          else if (nR==4) sDeity="Tymora";
                          else if (nR==5) sDeity="Chauntea";
                          else if (nR==6) sDeity="Deneir";

                     } // elf
                     else
                     { // other

                          nR=d10();
                          if (nR<4) sDeity="Tymora";
                          else if (nR==4) sDeity="Selune";
                          else if (nR==5) sDeity="Chauntea";
                          else if (nR==6) sDeity="Deneir";
                          else if (nR==7) sDeity="Lathander";
                          else if (nR==8) sDeity="Milil";
                          else if (nR==9) sDeity="Tempus";
                          else if (nR==10) sDeity="Lliira";

                     } // other

                } // chaotic good
                else
                { // neutral good

                     if (nR==RACIAL_TYPE_DWARF)
                     { // dwarves

                          nR=d4();
                          if (nR<3) sDeity="Moradin";
                          else if (nR==3) sDeity="Tymora";
                          else if (nR==4) sDeity="Chauntea";

                     } // dwarves
                     else if (nR==RACIAL_TYPE_GNOME)
                     { // gnomes

                          nR=d4();
                          if (nR<3) sDeity="Garl Glittergold";
                          else if (nR==3) sDeity="Tymora";
                          else if (nR==4) sDeity="Chauntea";

                     } // gnomes
                     else if (nR==RACIAL_TYPE_HALFLING)
                     { // halflings

                          nR=d4();
                          if (nR<3) sDeity="Yondalla";
                          else if (nR==3) sDeity="Lathander";
                          else if (nR==4) sDeity="Tymora";

                     } // halflings
                     else if (nR==RACIAL_TYPE_ELF)
                     { // elf

                          nR=d6();
                          if (nR<3) sDeity="Corellon Larethian";
                          else if (nR==3) sDeity="Selune";
                          else if (nR==4) sDeity="Tymora";
                          else if (nR==5) sDeity="Chauntea";
                          else if (nR==6) sDeity="Deneir";

                     } // elf
                     else
                     { // other

                          nR=d12();
                          if (nR<4) sDeity="Tymora";
                          else if (nR==4) sDeity="Selune";
                          else if (nR==5) sDeity="Chauntea";
                          else if (nR==6) sDeity="Lathander";
                          else if (nR==7) sDeity="Deneir";
                          else if (nR==8) sDeity="Milil";
                          else if (nR==9) sDeity="Lliira";
                          else if (nR==10) sDeity="Oghma";
                          else if (nR==11) sDeity="Waukeen";
                          else if (nR==12) sDeity="Silvanus";

                     } // other

                } // neutral good

            } // other

       } // good character
       else
       { // neutral character

            if (nClass==CLASS_TYPE_DRUID)
            { // druids

                 sDeity="Silvanus";

            } // druids
            else
            { // other

                 if (nR==RACIAL_TYPE_DWARF)
                 { // dwarf

                      nR=d4();
                      if (nR==1) sDeity="Dumathoin";
                      else if (nR==2) sDeity="Vergadain";
                      else if (nR==3) sDeity="Waukeen";
                      else if (nR==4) sDeity="Oghma";

                 } // dwarf
                 else if (nR==RACIAL_TYPE_HALFLING)
                 { // halfling

                      nR=d4();
                      if (nR==1) sDeity="Sheela Peryroyl";
                      else if (nR==2) sDeity="Brandobaris";
                      else if (nR==3) sDeity="Waukeen";
                      else if (nR==4) sDeity="Oghma";

                 } // halfling
                 else if (nR==RACIAL_TYPE_GNOME)
                 { // gnome

                      nR=d4();
                      if (nR<3) sDeity="Callarduran Smoothhands";
                      else if (nR==3) sDeity="Silvanus";
                      else if (nR==4) sDeity="Oghma";

                 } // gnome
                 else
                 { // other

                      nR=d12();
                      if (nR<3) sDeity="Silvanus";
                      else if (nR<5) sDeity="Waukeen";
                      else if (nR<7) sDeity="Oghma";
                      else if (nR==7) sDeity="Chauntea";
                      else if (nR==8) sDeity="Helm";
                      else if (nR==9) sDeity="Tempus";
                      else if (nR==10) sDeity="Lathander";
                      else if (nR==11) sDeity="Deneir";
                      else if (nR==12) sDeity="Milil";

                 } // other

            } // other

       } // neutral character

       SetDeity(oPC,sDeity);

   } // okay to do this

}
////////////////////////////////////////////////////////////////////[ M A I N ]/


///////////////////
// FUNCTIONS
///////////////////


string privateAlignmentString(int nAGE,int nALC)
{ // PURPOSE: Return Alignment String

    string sRet="";

    if (nALC==ALIGNMENT_LAWFUL) sRet="L";
    else if (nALC==ALIGNMENT_CHAOTIC) sRet="C";
    else
    {
       sRet="N";
    }

    if (nAGE==ALIGNMENT_GOOD) sRet=sRet+"G";
    else if (nAGE==ALIGNMENT_EVIL) sRet=sRet+"E";
    else
    {
       sRet=sRet+"N";
    }

    return sRet;

} // privateAlignmentString()
