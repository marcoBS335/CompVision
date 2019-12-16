# CompVision
Shi-Tomasi Corner Detector - Computer Vision Assignement

# Overview (Slovak)
Shi-Tomasi Corner Detector

Marek Berta, Filip Burda, Jakub Geľo
Technická univerzita v Košiciach, KKUI
 
Teória a algoritmus
Shi-Tomasi detektor vychádza z algoritmu, ktorý sa používa v metóde Harris Corner. Harris Corner algoritmus vychádza zo zmeny gradientu na šedotónovom obrázku, ktorá je vyjadrená nasledujúcim vzťahom:

![prva rovnica](https://github.com/marcoBS335/CompVision/blob/master/images/prva_rov.jpg?raw=true)

Kde :
	w(x,y) je okno(časť obrázku) na pozícii (x,y)
	I je intenzita na daných súradniciach


V roku 1994 J. Shi a C. Tomasi urobili malú modifikáciu vo svojom dokumente Good Features to Track, ktorý vykazuje lepšie výsledky v porovnaní s Harris Corner Detector. Funkcia bodovania v detektore Harris Corner Detector bola daná vzťahom, ktorý vyjadruje skóre pre každú časť obrázka, ktorá by mohla obsahovať roh:

![druha rovnica](https://github.com/marcoBS335/CompVision/blob/master/images/druha_rov.jpg?raw=true)

Namiesto vzťahu ( 2 ) Shi-Tomasi navrhol:

![tretia rovnica](https://github.com/marcoBS335/CompVision/blob/master/images/tretia_rov.jpg?raw=true)

Kde λ_1 a λ_2 sú vlastné hodnoty matice zloženej z gradientových intenzít ( 1 ).
Základný princíp algoritmu je: 
* vyhľadanie okien – teda častí obrázka, kde je vysoká zmena intenzity
* pre každé okno je vypočítaná metrika R
* podľa zvoleného thresholdu sú označené nájdené rohy

Tento princíp sme následne implementovali s ohľadom na efektivitu našej funkcie. Pre optimálnejšie spracovanie obrazu sme najprv farebný obraz previedli na šedotónový, pridali sme obrazu orámovanie a použili sme gausovský filter pre odstránenie šumu.
### Implementácia algoritmu
V programovom prostredí MATLAB shiTomasiFeatures(), ktorej vstupom sú 3 parametre, pričom iba prvý z nich je povinný a to obraz ktorý sa spracováva. Druhým parametrom je veľkosť filtra, ktorým je obraz prehľadávaný a tretím je threshold, ktorý určuje akú najnižšiu hodnotu vypočítanej metriky musí mať bod obrazu aby mohol byť považovaný za roh.

Funkcia vráti rohy ktoré pozície nájdených rohov a k nim prislúchajúce hodnoty metriky.

Experimentálne sme porovnávali nami vytvorenú funkciu a funkciu OpenCV. 
 

Pri porovnávaní zistených rohov sme vyberali 79 rohov s najlepšou metrikou. Priemerne bolo zhodných 58 zo 79 rohov a priemerná úspešnosť teda bola 73,4%. Pri experimentoch bola veľkosť filtra nastavená na hodnotu 5 a threshold mal hodnotu 100. Porovnávanie funkcií sme uskutočnili pomocu štyroch obrázkov. Pre ilustráciu porovnania funkcií sme priložili obrázky kirby.jpg a stavebnica.jpg s označenými rohmi, získanými pomocou oboch funkcií.
Pri meraní trvania priebehu našej funkcie a funkcie OpenCV pri 1000 behoch sme dostali priemer trvania behu nami naprogramovanej funkcie je 0,20993s a priemerné trvanie behu OpenCV funkcie je 0,13657.


### Príklady aplikácií

* Rozpoznávanie únavy vodičov na základe charakteristických bodov tváre
* Na rozpoznanie únavy vodičov bola použitá metóda rozpoznávania tvárí Viola-Jones, ktorá využívala metódu rozpoznávania rohov Shi-Tomasi  na uršenie pozícií úst a očí vodičov. [1]
* Rozpoznávanie gest rúk pomocou Kinect 
* Gestá rúk boli snímané pomocou Microsoft Kinect, kde Shi-Tomasi detektor dokázal pre jeden prst nájsť práve jeden roh narozdiel od Harrisovho detektora. [2]
* Rozpoznávanie chybných úchytov koľajníc
 
Na základe fotiek koľajníc boli pomocou Shi-Tomasi a Harris-Stephen detektorov zisťované nebezpečné časti železničných tratí, konkrétne poškodené alebo chýbajúce úchyty koľají. [3]


[Dokumentácia vo forme PDF](https://github.com/marcoBS335/CompVision/blob/master/documentation.pdf)

### Pseudocode

```javascript
read image
convert image to grayscale
calculate derivates x and y axix orientation
calculate Shi-Tomasi metric 
calculate local maxima
if (pixel is local maxima and also satisfies metric){
  save pixel position
}
return pixel positions and its metric
```
### Citations
1. Driver alert state and fatigue detection by salient points analysis. Torres-Torriti, J. Jiménez-Pinto and M. San Antonio : s.n., 2009.
2. Heng Du, TszHang To. Hand Gesture Rrecognition Using Kinect. s.l. : Boston University, 2011.
3. Automatic detection of defective rail anchors. R. A. Khan, S. Islam and R. Biswas. Quingdao : s.n., 2014.
4. Shi-Tomasi Corner Detector & Good Features to Track. OpenCV - Python Tutorials. [Online] https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_feature2d/py_shi_tomasi/py_shi_tomasi.html.
5. Fundamentals of Features and Corners. AI Shack. [Online] http://aishack.in/tutorials/shitomasi-corner-detector/.