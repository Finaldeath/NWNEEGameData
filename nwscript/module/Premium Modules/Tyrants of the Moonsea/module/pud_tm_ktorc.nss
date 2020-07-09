//User defined script for creatures in Kur-Tharsu Lower Ground alerted by gong
void main()
{
    switch(GetUserDefinedEventNumber())
    {
        //Move to the source of the sound
        case 5000 :
           ActionMoveToObject(GetNearestObjectByTag("KTGong"), TRUE);
        break;
    }
}
