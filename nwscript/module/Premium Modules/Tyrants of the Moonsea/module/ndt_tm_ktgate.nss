//Kur-Tharsu gate creature is destroyed so destroy 'real' gate
//See pud_tm_ktdirect for details of actions taken

void main()
{
    SignalEvent(GetObjectByTag("KTDirector"), EventUserDefined(4500));
}
