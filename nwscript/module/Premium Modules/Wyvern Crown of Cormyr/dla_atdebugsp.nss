////////////////////////////////////////////////////////////////////////////////
// :: Created By: Deva B. Winblood
// :: Created On: 7/30/2006
// :: Adds mount speed time adjustment to debug wand
////////////////////////////////////////////////////////////////////////////////

void main()
{
   int nParm=GetLocalInt(GetPCSpeaker(),"nParm");
   object oMod=GetModule();
   DeleteLocalInt(GetPCSpeaker(),"nParm");
   if (nParm==1) SetLocalFloat(oMod,"fMountTimingMultiple",0.3);
   else if (nParm==2) SetLocalFloat(oMod,"fMountTimingMultiple",0.4);
   else if (nParm==3) SetLocalFloat(oMod,"fMountTimingMultiple",0.5);
   else if (nParm==4) SetLocalFloat(oMod,"fMountTimingMultiple",0.6);
   else if (nParm==5) SetLocalFloat(oMod,"fMountTimingMultiple",0.7);
   else if (nParm==6) SetLocalFloat(oMod,"fMountTimingMultiple",0.8);
   else if (nParm==7) SetLocalFloat(oMod,"fMountTimingMultiple",0.9);
   else if (nParm==8) SetLocalFloat(oMod,"fMountTimingMultiple",1.0);
   else if (nParm==9) SetLocalFloat(oMod,"fMountTimingMultiple",1.2);
}
