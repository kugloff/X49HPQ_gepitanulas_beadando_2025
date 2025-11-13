# Titanic túlélési előrejelzés – Neurális hálóval

## Projekt célja
Ez a projekt a **Titanic – Machine Learning from Disaster** adathalmaz alapján készült.  
A cél a **túlélés valószínűségének előrejelzése** a hajó utasainak adatai alapján (pl.: nem, életkor, osztály, családméret).

---

## Projekt felépítése

- titanic.ipynb - fő notebook – adatkezelés és modell
- docs mappa - a beadandó követelményei
- titanic mappa - Titanic adatfájlok (Kaggle-ről)
- requirements.txt - használt csomagok listája
- README.md - ez a dokumentáció


---

## Fő lépések

### 1️. Adatok betöltése és feltárása
- `pandas` segítségével a `train.csv` fájl betöltése
- Adatok megtekintése (`head()`, `describe()`)

---

### 2. Hiányzó és kiugró értékek kezelése
- Hiányzó értékek elemzése
    - A hiányzó értékek vizsgálatánál észrevettem, hogy a `Cabin` oszlopban rengeteg adat (kb. 80%) hiányzik. Ezért ezt a feature-t eldobtam, nem használtam fel a modellben.
    - Az `Age` és `Fare` oszlopokban a hiányzó adatokat mediánnal pótoltam
    - Az `Embarked` oszlopban pedig a leggyakoribb kategóriával (módusz) pótoltam a hiányzó adatokat (`mode()`)
    - A hiányzó értékek pótlása során az eredeti `train` és `test` adathalmazokat változatlanul hagytam, a feldolgozott változatokat `train_new` és `test_new` néven tároltam el.
- Felesleges adatok
    - a `PassengerId` oszlopot is eldobtam, hiszen csak egy sorszám, és nincs köze a túléléshez
- Outlierek elemzése
    - az `Age` és `Fare` oszlopokat vizsgáltam boxen plot segítségével
        - az `Age` oszlop teljesen rendben volt
        - a `Fare` oszlopban van kiugró érték (500 körül), de ezek elvileg valós első osztályú jegyárak, ezért nem lettek eltávolítva
---

### 3. Feature engineering

---

### 4. Modell – Neurális háló

---

### 5. Modell tanítása és értékelése

---

### 6. Eredmény
A neurális háló **__** ért el a validációs adatokon 

---

## Használt könyvtárak

- `pandas`
- `numpy`
- `matplotlib`
- `seaborn`
- `scikit-learn`
- `tensorflow`

---

## Készítette
**Varga Zsófia X49HPQ**  
Gépi tanulás beadandó 2025