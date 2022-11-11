unit mouse;
{ *****************************************************************
  * T„m„ aliohjelmakirjasto sis„lt„„ hiiriohjaukseen              *
  * tarvittavia PASCAL-kielisi„ aliohjelmia                       *
  *                                                               *
  * HUOM !! hiiren t„ytyy olla MICROSOFTIN hiiren                 *
  *         kanssa yhteensopiva.                                  *
  *                                                               *
  * Microsofin hiiriohjuri k„ytt„„ keskeytyst„ 33h, joka          *
  * on kymmenj„rjestelm„ss„ 51. T„m„ hiiriohjuri sis„l-           *
  * t„„ 18 funktiota, joita voidaan kutsua keskeytyksen           *
  * 33h avulla.                                                   *
  *                                                               *
  * Tieto ohjelman ja hiirifunktioiden v„lill„ siirre-            *
  * t„„n rekistereiden kautta, eli ennen keskeytyst„              *
  * ladataan rekistereihin tarvittava tieto ja keskey-            *
  * tyksen j„lkeen voidaan vastaavasti rekistereist„              *
  * lukea tietoa, jota hiiriohjurin funktiot v„litt„v„t.          *
  *                                                               *
  * Kutsuttaessa jotain funktiota, v„litet„„n AX rekis-           *
  * teriss„ kutsuttavan funktion numero (0-18).                   *
  *                                                               *
  * Seuraavassa on lueteltu n„m„ hiiriohjurin funktiot,           *
  * sek„ kerrottu, mit„ rekistereit„ kulloinkin k„yte-            *
  * t„„n tietojen v„litt„miseen:                                  *
  *                                                               *
  * F0 : Alustaa hiiriohjurin. Palauttaa rekisteriss„             *
  *      AX arvon -1, jos hiiri ja ohjuri l”ytyv„t oikein asen-   *
  *      nettuina, muussa tapauksessa palautuu arvo 0.            *
  *      Rekisteriss„ BX palautetaan hiiren nappuloiden m„„r„.    *
  *                                                               *
  * F1 : Tuo hiirikursorin n„kyviin. (teksti-/grafiikkakursori).  *
  *                                                               *
  * F2 : Piilottaa hiirikursorin. Hiirikursori on piilotettava    *
  *      tulostettaessa n„yt”lle (muuten sekoaa). Mik„li funktiota*
  *      kutsutaan 2 (tai useampia) kertoja per„kk„in, tarvitaan  *
  *      yht„ monta funktion 1 kutsua, jotta kursori tulisi n„ky- *
  *      viin.                                                    *
  *                                                               *
  * F3 : Tutkii hiiren sijainnin ja nappuloiden tilan. (Grafiikka-*
  *      kursoria k„ytett„ess„ m„„ritell„„n funktiolla 9 se kurso-*
  *      rin piste, jonka sijaintia tutkitaan). Ruudun vasen      *
  *      yl„kulma on (0,0). Hiiren liikealue riippuu k„ytett„-    *
  *      v„st„ grafiikkakortista.                                 *
  *                                                               *
  *      Tekstitilassa 1 merkki vastaa 8 pikseli„ sek„ vaaka-,    *
  *      ett„ pystysuunnassa. ( esim. jos hiirikursori on teksti- *
  *      tilassa ja sijaitsee toisella rivill„ kolmannessa sarak- *
  *      keessa, on sen sijainti (16,8).                          *
  *                                                               *
  *      Funktio palauttaa rekisteriss„ BX kahden ensimm„isen     *
  *      bitin arvoina n„pp„inten tilan. bitti 0 vastaa vasenta   *
  *      n„pp„int„ ja bitti 1 oikeaa n„pp„int„. Jos ko bitti on 0,*
  *      niin nappi on alhaalla ja 1 niin ylh„„ll„.               *
  *                                                               *
  *      CX rekisteriss„ palautetaan hiirikursorin sijainti X-    *
  *      suunnassa ja DX rekisteriss„ Y-suunnassa.                *
  *                                                               *
  * F4 : Siirt„„ hiirikursorin haluttuun paikkaan n„yt”ll„.       *
  *      paikka m„„t„ytyy pikselein„ edell„ esitellyll„ tavalla   *
  *      ( sijainti n„yt”ll„ riippuu grafiikkakortista).          *
  *                                                               *
  * F5 : Antaa tietoa siit„, miten hiiren nappuloita on paineltu. *
  *      Funktiolle v„litet„„n BX rekisteriss„ tieto, kumpaa      *
  *      nappulaa halutaan tutkia(0=vasen ja 1=oikea).            *
  *                                                               *
  *      Funktio palauttaa AX rekisteriss„ nappien tilan (kuten   *
  *      fintio 3 rekisteriss„ BX). BX rekisteriss„ palautuu      *
  *      tieto, kuinka monta kertaa tutkittavaa nappulaa on       *
  *      painettu sen j„lkeen, kun funktiota 5 on viimeksi kut-   *
  *      suttu. CX rekisteriss„ palautuu sen paikan X koordi-     *
  *      naatti ja DX rekisteriss„ Y koordinaatti, jossa nappulaa *
  *      on viimeksi painettu.                                    *
  *                                                               *
  * F6 : Antaa tietoa nappuloiden vapauttamisesta. Toimii kutsu-  *
  *      misen osalta kuten funktio 5, mutta palautetun tiedon    *
  *      kohdalla on seuraavat erot: BX rekisteriss„ palautetaan  *
  *      tieto, kuinka monta kertaa tutkittava nappula on vapau-  *
  *      tettu sen j„lkeen, kun funktiota 6 on viimeksi kutsuttu. *
  *      CX- ja DX rekistereiss„ on paikka, jossa nappula on      *
  *      viimeksi vapautettu.                                     *
  *                                                               *
  * F7 : M„„r„„ hiiren rajat X-suunnassa. CX rekisteriss„ v„li-   *
  *      tet„„n funktiolle pienin arvo ja DX rekisteriss„ suurin. *
  *                                                               *
  * F8 : M„„r„„ hiiren rajat Y-suunnassa. CX rekisteriss„ v„li-   *
  *      tet„„n funktiolle pienin arvo ja DX rekisteriss„ suurin. *
  *                                                               *
  * F9 : Grafiikkahiirikursorin m„„rittely. Jotta t„m„ kursori    *
  *      n„kyisi, t„ytyy olla grafiikkatilassa. BX (X) ja DX (Y)  *
  *      rekistereiss„ v„litet„„n sen kursorin pisteen paikka,    *
  *      jonka esim. funktio 3 palauttaa kursorin paikkana.       *
  *      Paikka v„litet„„n suhteessa hiirikursorin vasempaan      *
  *      yl„kulmaan. (arvoalue: -8 - +24)                         *
  *                                                               *
  *      Rekistereiden ES:DX (segmentti:siirros) avulla v„lite-   *
  *      t„„n sen muistialueen osoite, johon on talletettu sit„   *
  *      ennen grafiikkahiirikursorin grafiikka. Grafiikkahiiri-  *
  *      kursori esitet„„n n„yt”ll„ 16x16 pikselin alueena.       *
  *      Jotta homma onnituisi, t„ytyy muistiin olla tallennet-   *
  *      tuna kaksi 16 sanan lohkoa per„kk„in (sana=16 bitti„).   *
  *      ES:DX  :n t„ytyy funktiota kutsuttessa osoittaa em.      *
  *      muistialueen alkuun (ensimm„isen sanan alkuun).          *
  *                                                               *
  *      Hiiriohjuri kopioi em. tiedon omalle muistialueelleen    *
  *      ja k„ytt„„ sit„ grafiikkahiirikursorin luomiseen.        *
  *                                                               *
  *      Kursorin muoto m„„r„ytyy seuraavasti:                    *
  *                                                               *
  *      lohko1                      lohko2                       *
  *      00111111 11111111 = 3FFFH    00000000 00000000 = 0000H   *
  *      00011111 11111111 = 1FFFH    01000000 00000000 = 4000H   *
  *      00001111 11111111 = 0FFFH    01100000 00000000 = 6000H   *
  *      00000111 11111111 = 07FFH    01110000 00000000 = 7000H   *
  *      00000011 11111111 = 03FFH    01111000 00000000 = 7800H   *
  *      00000001 11111111 = 01FFH    01111100 00000000 = 7C00H   *
  *      00000000 11111111 = 00FFH    01111110 00000000 = 7E00H   *
  *      00000000 01111111 = 007FH    01111111 00000000 = 7F00H   *
  *      00000000 00111111 = 003FH    01111111 10000000 = 7F80H   *
  *      00000000 00011111 = 001FH    01111111 11000000 = 7FC0H   *
  *      00000001 11111111 = 01FFH    01111100 00000000 = 7C00H   *
  *      00010000 11111111 = 10FFH    00110110 00000000 = 4600H   *
  *      00110000 11111111 = 30FFH    00000110 00000000 = 0600H   *
  *      11111000 01111111 = F87FH    00000011 00000000 = 0300H   *
  *      11111000 01111111 = F87FH    00000011 00000000 = 0300H   *
  *      11111100 00111111 = FC3FH    00000000 00000000 = 0000H   *
  *                                                               *
  *      lohko1            lohko2             pkseli ruudulla     *
  *        0                 0                     v„ri 0         *
  *        0                 1                     v„ri 15        *
  *        1                 1                     ei muutosta    *
  *        1                 1                     sekaisin       *
  *                                                               *
  * F10: Tekstihiirikursorin m„„rittely. BX rekisteriss„ v„li-    *
  *      tet„„n tieto kursorin tyypist„ (0 = softwarekursori ja   *
  *      1 = hardwarekursori). Softwarekursori voi n„ky„ saman-   *
  *      aikaisesti normaalikursorin kanssa, kun taas hardware-   *
  *      kursori on normaalikursori.                              *
  *                                                               *
  *      Softwarekursori muodostetaan muuttamalla kursorin        *
  *      kohdalla olevaa merkki„. Softwarekursorin v„rin          *
  *      voi m„„ritell„ seuraavasti:                              *
  *                                                               *
  *      ( tausta+edusta+merkki and CX ) xor DX                   *
  *                                                               *
  *      Jos esim. haluttaisiin saada kursoriin punainen          *
  *      tausta ja keltainen merkki, CX ja DX rekisterien         *
  *      tarvittavat arvot saataisiin seuraavasti:                *
  *      punainen = 4 = 0100  =  4h                               *
  *      keltainen = 14 = 1110 =  Eh                              *
  *                                                               *
  *      tausta  edusta   merkki                                  *
  *      --------------------------------------------             *
  *      0110    0011     0011 1110      (tausta+edusta+merkki)   *
  *      0000    0000     1111 1111      : CX = 00FFh             *
  *      ---------------------------------------------            *
  *      0000    0000     0011 1110        AND                    *
  *      0100    1110     0000 0000      : DX = 4E00h             *
  *      ---------------------------------------------            *
  *      0100    1110     0011 1110        XOR                    *
  *                                                               *
  *      Katso aliohjelma STEKSTIKURSORI                          *
  *                                                               *
  *      Valittaessa hardwarekursori, v„litet„„n CX ja DX rekis-  *
  *      tereiss„ n„yt”n ensimm„inen ja viimeinen rivi, jotka     *
  *      n„kyv„t kursorissa.                                      *
  *                                                               *
  *      SUOSITUS: K„yt„ softwarekursoria                         *
  *                                                               *
  * F11: Kertoo, kuinka monta mickeyt„ hiiri on liikkunut ko      *
  *      funktion edellisen k„skyn j„lkeen. Mickey on pienin      *
  *      liike, jonka hiiri tunnistaa (hiirest„ riippuen          *
  *      1/200 - 1/400 tuumaa. Funktio palauttaa rekisteriss„     *
  *      CX mickey m„„r„n vaakasuunnassa (-32768 - +32767) ja     *
  *      DX rekisteriss„ pystysuunnassa.                          *
  *                                                               *
  * F15: M„„r„„ hiirikursorin nopeuden, eli kuinka monta mickeyt„ *
  *      hiiren t„ytyy liikkua, jotta hiirikursori liikkuisi      *
  *      n„yt”ll„ tietyn matkan. Reksiteriss„ CX v„litet„„n       *
  *      tieto kuinka monta mickeyt„ hiiren tulee liikkua         *
  *      vaakasuunnassa, jotta hiirikursori liikkuu kahdeksan     *
  *      pikseli„ vaakasuunnassa (tekstitilassa yhden merkin).    *
  *      Vastaavat pystysuuntaiset tiedot v„litet„„n DX rekiste-  *
  *      riss„. ( oletusarvona on 8 mickeyt„ vaaka- ja 16 mic-    *
  *      keyt„ pystysuunnassa.                                    *
  *                                                               *
  * F16: Alue, jolla hiirikursori poistetaan ruudulta. CX rekis-  *
  *      teriss„ v„litet„„n alueen vasen reuna, DX rekisteriss„   *
  *      yl„reuna, SI sekisteriss„ oikea reuna ja DI rekisteriss„ *
  *      alareuna. Hiirikursori ei palaa automaattisesti n„kyviin *
  *      kun poistutaan t„lt„ alueelta, vaan se t„ytyy luoda      *
  *      funktiolla 1 uudelleen n„kyv„ksi.                        *
  *                                                               *
  * F19: Rajanopeuden m„„ritt„minen. Kun hiirt„ liikutetaan raja- *
  *      nopeutta suuremmalla nopeudella, kaksinkertaistuu hiiri- *
  *      kursorin nopeus n„yt”ll„. DX rekisteriss„ v„litet„„n     *
  *      t„m„ rajanopeus. (oletus = 64 mickeyt„/sekunti).         *
  *                                                               *
  *  LOPPU ONKIN SITTEN OMASTA MIELIKUVITUKSESTA KIINNI !!!!      *
  *                                                               *
  *                                              (C) Kuka Lie     *
  ***************************************************************** }

interface

uses DOS;

procedure alusta_hiiri(var ok:boolean);
procedure nayta_hiiri;
procedure hiiri_piiloon;
procedure paikka_ja_nappulat(var x,y,n1,n2 : integer);
procedure grkursori;
procedure stekstikursori;

implementation

procedure alusta_hiiri(var ok:boolean);
{ ************************************************************
  * T„m„ aliohjelma alustaa hiiren                           *
  ************************************************************ }

var regs : registers;

begin
  regs.ax := 0;                 { valitaan funktio 0 }
  intr($33,regs);               { keskeytys 33h }
  if (regs.ax=0) then ok:=false { onnistuiko alustus }
  else ok:=true;
end;

{ ----------------------------------------------------------- }

procedure nayta_hiiri;
{ ************************************************************
  * T„m„ aliohjelma tuo hiirikursorin n„kyv„ksi              *
  ************************************************************ }

var regs : registers;

begin
  regs.ax:=1;
  intr($33,regs);
end;

{ ----------------------------------------------------------- }

procedure hiiri_piiloon;
{ ************************************************************
  * T„m„ aliohjelma piilottaa hiirikursorin                  *
  ************************************************************ }

var regs : registers;

begin
  regs.ax:=2;
  intr($33,regs);
end;

{ ------------------------------------------------------------ }

procedure paikka_ja_nappulat(var x,y,n1,n2 : integer);
{ ************************************************************
  * T„m„ aliohjelma tutkii hiirikursorin sijainnin ja        *
  * nappuloiden tilan.                                       *
  ************************************************************ }

var regs : registers;

begin
  regs.ax:=3;
  intr($33,regs);
  x:=regs.cx;
  y:=regs.dx;
  n1:=(regs.bx and 1);
  n2:=(regs.bx and 2) shr 1;
end;

{ ----------------------------------------------------------- }

procedure grkursori;
{ ************************************************************
  * T„m„ aliohjelma m„„rittelee grafiikkahiirikursorin       *
  * muodon                                                   *
  ************************************************************ }

var regs : registers;

const cursor : array[1..32] of word =
      ($3FFF,$1FFF,$0FFF,$07FF,$03FF,$01FF,$00FF,$007F,
       $003F,$001F,$01FF,$10FF,$30FF,$F87F,$F87F,$FC3F,
       $0000,$4000,$6000,$7000,$7800,$7C00,$7E00,$7F00,
       $7F80,$7FC0,$7C00,$4600,$0600,$0300,$0300,$0000);

begin
  regs.ax := 9;
  regs.bx := 0;
  regs.cx := 0;
  regs.dx := ofs(cursor);  { taulukon talletusalueen segmentti }
  regs.es := seg(cursor);  { taulukon talletusalueen siirros }
  intr($33,regs);
end;

{ ----------------------------------------------------------- }

procedure stekstikursori;
{ ************************************************************
  * T„m„ aliohjelma m„„rittelee tekstihiirikursorin          *
  * muodon softwarekuesoriksi                                *
  ************************************************************ }

var regs : registers;

begin

  regs.bx:=0;             { valittiin softwarekursori }
  regs.cx:=$00FF;         { kursorissa punainen tausta ja keltainen }
  regs.dx:=$4E00;         { merkki }
  regs.ax:=10;
  intr($33,regs);
end;

end.